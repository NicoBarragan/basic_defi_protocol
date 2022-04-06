from multiprocessing import pool
from brownie import PoolToken, LpToken, GovernanceToken, LiquidityPool, interface
from scripts.helpful_scripts import get_account
from scripts.deploy import deploy


def main():
    account = get_account()
    
    if len(PoolToken) == 0:
        deploy("PoolToken")
    
    if len(LpToken) == 0:
        deploy("LpToken")
        
    if len(GovernanceToken) == 0:
        deploy("GovernanceToken")
        
    if len(LiquidityPool) == 0:
        deploy("LiquidityPool", PoolToken[-1].address, LpToken[-1].address, GovernanceToken[-1].address)

    
    tx = PoolToken[-1].mint(account, 1000000, {'from': account})
    tx.wait(1)
    

    pool_token = interface.IERC20(PoolToken[-1].address)
    pool_token.approve(LiquidityPool[-1].address, 1000000, {'from': account})
    tx = LiquidityPool[-1].depositPool(1000000, {'from': account})
    tx.wait(1)
    
    lp_token = interface.IERC20(LpToken[-1].address)
    gov_token = interface.IERC20(GovernanceToken[-1].address)
    print(f"Balance of Pool token: {pool_token.balanceOf(account)}")
    print(f"Balance of LP token: {lp_token.balanceOf(account)}")
    print(f"Balance of Governance token: {gov_token.balanceOf(account)}")   
     
    print(f"-"*20)
     
    lp_token.approve(LiquidityPool[-1].address, lp_token.balanceOf(account), {'from': account})
    tx = LiquidityPool[-1].withdrawPool(lp_token.balanceOf(account), {'from': account}) 
    tx.wait(1)
    print(f"Balance of Pool token: {pool_token.balanceOf(account)}")
    print(f"Balance of LP token: {lp_token.balanceOf(account)}")
    print(f"Balance of Governance token: {gov_token.balanceOf(account)}")   