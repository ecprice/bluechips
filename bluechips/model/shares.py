rent_shares = dict((x.split()[0], int(x.split()[1])) for x in """
jacob  860
ecprice  840
david  900
sara  870
ben  825
katja  450
paul  450
richard  770
frank  760
michal  940
cathy  830
""".strip().split('\n'))

occupants = rent_shares.keys() + 'rishig'.split()

share_names = ['House', 'Rent']
share_dict = {u"Rent": rent_shares,
              u"House": dict((x, 1) for x in occupants),
              }
