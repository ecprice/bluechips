<%inherit file="/base.mako"/>

<script>
<%
        share_dict = {}
        for k in c.model.share_names:
            share_dict[k] = [c.model.share_dict[k].get(u[1].username, 0) for u in c.users]
%>
 split_dict = {
 % for key in c.model.share_names:
           ${key}: ${share_dict[key]},
 % endfor
          }
 function set_split() {
   var split_name = $("#split")[0].value;
   var split = split_dict[split_name];
   for (var i = 0; i < split.length; i++){
     $("#shares-"+i+"amount")[0].value = split[i];
   }
   calcSplit();
 }
</script>

<form action="${h.url_for(controller='spend', action='update', id=c.expenditure.id)}" method="post">
  ${h.auth_token_hidden_field()}
  <table class="form">
    <tr>
      <th><label for="spender_id">Spender</label></th>
      <td>${h.select('spender_id', c.expenditure.spender_id, c.users)}</td>
    </tr>
    <tr>
      <th><label for="amount">Amount</label></th>
      <td>${h.currency('amount', c.expenditure.amount, size=8, onkeyup="calcSplit();")}</td>
    </tr>
    <tr>
      <th><label for="date">Date</label></th>
      <td>${h.text('date', c.expenditure.date.strftime('%m/%d/%Y'), size=16, class_='datepicker')}</td>
    </tr>
    <tr>
      <th><label for="description">Description</label></th>
      <td>${h.text('description', c.expenditure.description, size=64)}</td>
    </tr>
  </table>

  <p>Change how an expenditure is split up. Choose a preset option: <select id="split" onChange="set_split()">
 % for name in c.model.share_names:
 <option value="${name}">${name}</option>
 % endfor
<select>



  <p>Alternatively, enter the share per user.</p>


  <table class="form">
    % for ii, user_row in enumerate(c.users):
      <%
        user_id, user = user_row
        percent = c.values['shares-%d.amount' % ii]
      %>
      <tr>
        <th><label for="shares-${ii}amount">${user.name}</label></th>
        <td>
          ${h.text('shares-%d.amount' % ii, percent, class_="share-text", onchange="calcSplit();", onkeyup="calcSplit();")}
          ${h.hidden('shares-%d.user_id' % ii, user.id)}
        </td>
        <td id="shares-${ii}amount-calc" align="right">
          0.00
        </td>
      </tr>
    % endfor
    <tr>
      <td colspan="2">
        ${h.submit(None, 'Submit', class_="submitbutton")}
      </td>
    </tr>
  </table>
</form>
${h.javascript_link('%s/js/calculator.js' % request.script_name)}
