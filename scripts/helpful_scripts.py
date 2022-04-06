from brownie import accounts, config, network

def get_account():
    if network.show_active() == "mainnet-fork":
        account = accounts[0]
    else:
        account = accounts.add(config['from_keys']) 
    
    return account