from brownie import PoolToken, LpToken, GovernanceToken, LiquidityPool
from scripts.helpful_scripts import get_account
    

def deploy(contract_name, pool_token_address=None, lp_token_address=None, gov_token_address=None):
    account = get_account()
    
    if contract_name == "PoolToken":
        PoolToken.deploy({'from': account})
        
    elif contract_name == "LpToken":
        LpToken.deploy({'from': account})
        
    elif contract_name == "GovernanceToken":
        GovernanceToken.deploy({'from': account})
        
    elif contract_name == "LiquidityPool":
        LiquidityPool.deploy(
            pool_token_address,
            lp_token_address,
            gov_token_address,
            {'from': account})
        
    