<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Cheque" %>
<%@ page import="Model.EtatCheque" %>
<%@ page import="Model.ChequeEtat" %>
<%@ page import="DAO.ChequeEtatDAO" %>
<%
ArrayList<EtatCheque> etat = (ArrayList<EtatCheque>) request.getAttribute("listeEtat");
Cheque cheque = (Cheque) request.getAttribute("cheque");
ArrayList<ChequeEtat> list =(ArrayList<ChequeEtat>)request.getAttribute("chequeEtat");
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= (cheque != null) ? "Modifier un chèque" : "Ajouter un chèque" %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #f2f2f2;
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        td {
            padding: 10px;
            border: 1px solid #ddd;
            vertical-align: middle;
        }
        td input[type="number"],
        td input[type="date"],
        td input[type="text"] {
            width: 100%;
            margin-top: 0;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-save {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .btn-delete:hover {
            background-color: #da190b;
        }
        .btn-save:hover {
            background-color: #45a049;
        }
        .actions-cell {
            text-align: center;
            min-width: 100px;
        }
    </style>
</head>
<body>

<% if (cheque == null) { %>
    <!-- FORMULAIRE D'AJOUT -->
    <h2>Ajouter un chèque</h2>

    <form action="<%= request.getContextPath() %>/Cheque/add" method="post">
        
        <label>Numéro du chèque :</label>
        <input type="text" name="numero" required>

        <label>Compte :</label>
        <input type="text" name="compte" required>

        <label>Date limite :</label>
        <input type="date" name="date_limite" required>
        
        <label>État du chèque :</label>
        <select name="id_etat">
            <% if (etat != null && !etat.isEmpty()) {
                   for (EtatCheque e : etat) {
            %>
                <option value="<%= e.getId_etat() %>">
                    <%= e.getNameEtat() %>
                </option>
            <%     }
               }  %>
        </select>

        <button type="submit">Ajouter</button>
    </form>

<% } else { %>
    <h2>Modifier un chèque</h2>

    <form action="<%= request.getContextPath() %>/Cheque/add" method="post">
        
        <%-- Champ caché pour l'ID --%>
        <input type="hidden" name="id_cheque" value="<%= cheque.getId_Cheque() %>">

        <label>Numéro du chèque :</label>
        <input type="text" name="numero" value="<%= cheque.getNumero_Cheque() %>" required>

        <label>Compte :</label>
        <input type="text" name="compte" value="<%= cheque.getNumero_Compte() %>" required>

        <label>Date limite :</label>
        <input type="date" name="date_limite" value="<%= cheque.getDate_limite() %>" required>
        
        <button type="submit">Modifier le chèque</button>
    </form>

    <%-- SECTION TABLEAU POUR LES ÉTATS DU CHÈQUE --%>
    <h2>États du chèque :</h2>
    
    <table>
        <thead>
            <tr>
                <th>ID ChequeEtat</th>
                <th>ID État</th>
                <th>Date de l'état</th>
                <th>Bénéficiaire</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% if (list != null && !list.isEmpty()) {
               for (ChequeEtat e : list) { %>
            <tr>
                <%-- Colonne 1: ID ChequeEtat (lecture seule) --%>
                <td><%= e.getId_ChequeEtat() %></td>
                
                <%-- Colonne 2 à 4: Formulaire pour la modification --%>
                <form action="<%= request.getContextPath() %>/ChequeStatus/save/<%= e.getId_ChequeEtat() %>" 
                      method="post">
                    <input type="hidden" name="id_cheque" value="<%= e.getId_cheque() %>">
                    <input type="hidden" name="id_ChequeEtat" value="<%= e.getId_ChequeEtat() %>">
                    
                    <td>
                        <input type="number" name="id_etat" value="<%= e.getId_etat() %>" required>
                    </td>
                    
                    <td>
                        <input type="date" name="date_etat" value="<%= e.getDaty() %>" required>
                    </td>
                    
                    <td>
                        <input type="text" name="beneficiaire" value="<%= e.getBeneficiaire() %>" required>
                    </td>
                    
                    <td class="actions-cell">
                        <button type="submit" class="btn-save">Enregistrer</button>
                </form>
                        <br>
                        <%-- Formulaire séparé pour la suppression --%>
                        <form action="<%= request.getContextPath() %>/ChequeStatus/delete/<%= e.getId_ChequeEtat() %>" 
                              method="get">
                            <input type="hidden" name="id_cheque" value="<%= e.getId_cheque() %>">
                            <button type="submit" class="btn-delete" 
                                    onclick="return confirm('Voulez-vous vraiment supprimer cet état ?');">
                                Supprimer
                            </button>
                        </form>
                    </td>
            </tr>
        <%   } 
           } else { %>
            <tr>
                <td colspan="5" style="text-align: center;">Aucun état disponible pour ce chèque.</td>
            </tr>
        <% } %>
        </tbody>
    </table>

<% } %>

</body>
</html>