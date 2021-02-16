<h3>Existing bakers</h3>
<% @users.each do |user| %>
  <input type="radio" name="cake[giver_id]" id="<%= user.id %>" value="<%= user.id %>"><%= user.name %></input><br>
<% end %>
<br>




<h3>Existing Bday People</h3>
    <% @users.each do |user| %>
      <input type="radio" name="cake[receiver_id]" id="<%= user.id %>" value="<%= user.id %>"><%= user.name %></input><br>
    <% end %>
    <br>


    <h3>Party Invitee Baking The Cake</h3>
    <% @users.each do |user| %>
    <input type="radio" name="cake[giver_id]" id="giver_<%= user.id %>" value="<%= user.id %>"><%= user.name %></input><br>
    <% end %>
    <br>
   

    <h3>Birthday Person The Cake Is For</h3>
    <% @users.each do |user| %>
    <input type="radio" name="cake[receiver_id]" id="user<%= user.id %>" value="<%= user.id %>"><%= user.name %></input><br>
    <% end %>
    <br>