from brownie import PoolToken, LpToken, LiquidityProvider, GovernanceToken
from scripts.helpful_scripts import get_account

def main():
    """It deploys the choosen smart contract"""
    deploy("PoolToken")
    deploy("PoolFabra")
    

def deploy(contract_name):
    account = get_account()
    
    if contract_name == "PoolToken":
        name = "Fabra Token"
        symbol = "FBR"
        PoolToken.deploy(name, symbol, {'from': account})
        
    