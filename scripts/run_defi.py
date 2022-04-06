from brownie import TokenFabra, PoolFabra, interface
from scripts.helpful_scripts import get_account
from scripts.deploy import deploy


def main():
    account = get_account()
    
    if len(TokenFabra) == 0:
        deploy("TokenFabra")
    
    if len(PoolFabra) == 0:
        token_address = TokenFabra[-1].address
        deploy("PoolFabra")
    
    print(TokenFabra)
    print(TokenFabra[-1])
    
    tx = TokenFabra[-1].mint(account, 1000000, {'from': account})
    tx.wait(1)
    
    token_fabra = interface.IERC20(TokenFabra[-1].address)
    tx = token_fabra.approve(PoolFabra[-1].address, 100, {'from': account})
    tx.wait(1)
    
    tx = PoolFabra[-1].depositPool(100, {'from': account})
    tx.wait(1)
    
    print("Balance of account:", token_fabra.balanceOf(account.address))
    
    tx = PoolFabra[-1].withdraw(100, {'from': account})
    tx.wait(1)
    print("Balance of account:", token_fabra.balanceOf(account.address))