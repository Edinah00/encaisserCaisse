<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Mouvement" %>

<html>
<head>
    <title>Liste des Mouvements</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <h2>Liste des Mouvements</h2><form action="MouvementServlet/liste" method="get">
    <!-- Numéro de compte -->
    Numéro compte: 
    <input type="text" name="numeroCompte" value="<%= request.getParameter("numeroCompte") != null ? request.getParameter("numeroCompte") : "" %>"><br>

    <!-- Type -->
    Type: 
    <select name="type">
        <option value="" <%= (request.getParameter("type") == null || request.getParameter("type").isEmpty()) ? "selected" : "" %>>--Tous--</option>
        <option value="debit" <%= "debit".equalsIgnoreCase(request.getParameter("type")) ? "selected" : "" %>>Debit</option>
        <option value="credit" <%= "credit".equalsIgnoreCase(request.getParameter("type")) ? "selected" : "" %>>Credit</option>
    </select><br>

    <!-- Date début -->
    Date début: 
    <input type="date" name="dateDebut" value="<%= request.getParameter("dateDebut") != null ? request.getParameter("dateDebut") : "" %>">
    <select name="dateDebutOperator">
        <option value=">=" <%= ">=".equals(request.getParameter("dateDebutOperator")) ? "selected" : "" %>>>=</option>
        <option value=">" <%= ">".equals(request.getParameter("dateDebutOperator")) ? "selected" : "" %> > </option>
        <option value="=" <%= "=".equals(request.getParameter("dateDebutOperator")) ? "selected" : "" %> >= </option>
    </select><br>

    <!-- Date fin -->
    Date fin: 
    <input type="date" name="dateFin" value="<%= request.getParameter("dateFin") != null ? request.getParameter("dateFin") : "" %>">
    <select name="dateFinOperator">
        <option value="<=" <%= "<=".equals(request.getParameter("dateFinOperator")) ? "selected" : "" %>><=</option>
        <option value="<" <%= "<".equals(request.getParameter("dateFinOperator")) ? "selected" : "" %>><</option>
        <option value="=" <%= "=".equals(request.getParameter("dateFinOperator")) ? "selected" : "" %>>=</option>
    </select><br>

    <!-- Montant min -->
    Montant min: 
    <input type="number" step="0.01" name="montantMin" value="<%= request.getParameter("montantMin") != null ? request.getParameter("montantMin") : "" %>">
    <select name="montantMinOperator">
        <option value=">=" <%= ">=".equals(request.getParameter("montantMinOperator")) ? "selected" : "" %>>>=</option>
        <option value=">" <%= ">".equals(request.getParameter("montantMinOperator")) ? "selected" : "" %> > </option>
        <option value="=" <%= "=".equals(request.getParameter("montantMinOperator")) ? "selected" : "" %> >= </option>
    </select><br>

    <!-- Montant max -->
    Montant max: 
    <input type="number" step="0.01" name="montantMax" value="<%= request.getParameter("montantMax") != null ? request.getParameter("montantMax") : "" %>">
    <select name="montantMaxOperator">
        <option value="<=" <%= "<=".equals(request.getParameter("montantMaxOperator")) ? "selected" : "" %>><=</option>
        <option value="<" <%= "<".equals(request.getParameter("montantMaxOperator")) ? "selected" : "" %>><</option>
        <option value="=" <%= "=".equals(request.getParameter("montantMaxOperator")) ? "selected" : "" %>>=</option>
    </select><br>

    <input type="submit" value="Rechercher">
</form>



    <table>
        <tr>
            <th>ID</th>
            <th>Numéro Compte</th>
            <th>Date</th>
            <th>Type</th>
            <th>Montant</th>
        </tr>

        <%
            ArrayList<Mouvement> mouvements = (ArrayList<Mouvement>) request.getAttribute("listeMouvements");
            if (mouvements != null) {
                for (Mouvement m : mouvements) {
        %>
        <tr>
            <td><%= m.getId_mouv() %></td>
            <td><%= m.getNumero_compte() %></td>
            <td><%= m.getDate() %></td>
            <td><%= m.getType() %></td>
            <td><%= m.getMontant() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">Aucun mouvement trouvé.</td>
        </tr>
        <%
            }
        %>

    </table>
    <a href="<%= request.getContextPath()%>/Encaissement">Encaisser Cheque</a>
</body>
</html>
