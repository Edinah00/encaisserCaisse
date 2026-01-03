<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Encaissement de Chèque</title>
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <h2>Encaissement de Chèque</h2>

    <form action="Encaissement" method="post">
        Numéro du chèque: 
        <input type="text" name="numero_cheque" value="<%= request.getParameter("numero_cheque") != null ? request.getParameter("numero_cheque") : "" %>"><br>

        Montant: 
        <input type="number" step="0.01" name="montant" value="<%= request.getParameter("montant") != null ? request.getParameter("montant") : "" %>"><br>

        Date limite: 
        <input type="date" name="date_limite" value="<%= request.getParameter("date_limite") != null ? request.getParameter("date_limite") : "" %>"><br>

        Nom bénéficiaire: 
        <input type="text" name="nom_beneficiaire" value="<%= request.getParameter("nom_beneficiaire") != null ? request.getParameter("nom_beneficiaire") : "" %>"><br>

        <input type="submit" value="Encaisser">
    </form>

    <% if (request.getAttribute("error") != null) { %>
    <p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<% if (request.getAttribute("success") != null) { %>
    <p style="color:green;"><%= request.getAttribute("success") %></p>
<% } %>

</body>
</html>
