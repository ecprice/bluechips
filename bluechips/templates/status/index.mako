<%inherit file="/base.mako"/>

<div class="block">
  <h2>Current balances</h2>
  <table id="balance">
      <tr>
        <th>User</th>
        <th>Balance</th>
      </tr>
      % for user in sorted(c.users, key=lambda x: c.debts[x[1]]):
      <tr>
      <%
      color = 'white'
      if c.debts[user[1]] < 0:
        color = '#0f0'
      elif c.debts[user[1]] > 0:
        color = 'red'
      %>
       <td>${user[1].name}</td>
       <td class="amount" style="background-color: ${color}">${-c.debts[user[1]]}</td>
      </tr>
      % endfor
  </table>
</div>

<div class="block">
  <h2>Totals</h2>

  <table id="totals">
    <tr>
      <td class="scope"></td>
      <th class="scope">Everyone</th>
      <th class="scope">My Share</th>
    </tr>
    % for period in ('Total', 'Past year', 'Year to date', 'Month to date', 'Last month'):
      <tr>
        <th>${period}</th>
        % for scope in ('all', 'mine'):
          <td>${c.totals[period][scope]}</td>
        % endfor
      </tr>
    % endfor
  </table>
</div>

<div class="block">
  <h2>
    Your History
    <span class="see-all">
      ${h.link_to('See all history', h.url_for(controller='history', action='index'))}
    </span>
  </h2>

  <h3>Expenditures</h3>

  ${self.listExpenditures(c.expenditures)}

  <h3>Transfers</h3>

  ${self.listTransfers(c.transfers)}
</div>
