share_text = """
-	jacob ecprice david ben paul richard frank michal cathy ned  rishig patricia
House	1     1       1     1   2    1       1     1      1     1    1     0
Rent	860   840     900   825 900  770     760   940    830   870  0     0
""".strip().split('\n')

users = share_text[0].split('\t')[1].split()

share_names = []
share_dict = {}

for row in share_text[1:]:
    name, shares = row.split('\t', 1)
    share_names.append(name)
    share_dict[name] = {u: int(s) for u, s in zip(users, shares.split()) if int(s)}
