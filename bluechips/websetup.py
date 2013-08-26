"""Setup the BlueChips application"""
import logging

from bluechips.config.environment import load_environment

log = logging.getLogger(__name__)

def setup_app(command, conf, vars):
    """Place any commands to setup bluechips here"""
    load_environment(conf.global_conf, conf.local_conf)

    # Load the models
    from bluechips.model import meta
    meta.metadata.bind = meta.engine

    # Create the tables if they aren't there already
    meta.metadata.create_all(checkfirst=True)

    #add_shares()

def add_shares():
    """Not actually used"""
    from bluechips.lib.base import get_users
    from bluechips.model import Share, share_dict
    users = get_users()
    for _,u in users:
        u.shares = []
        for key in share_dict:
            if u.username in share_dict[key]:
                u.shares.append(Share(key, share_dict[key][u.username]))
