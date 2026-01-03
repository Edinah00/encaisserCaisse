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

Integer etatActuelId = null;
if (cheque != null) {
    try {
        ChequeEtat chE = new ChequeEtat();
        chE.setId_cheque(cheque.getId_Cheque());
        ChequeEtatDAO.getChequeAvecIdEtat(chE);
        etatActuelId = chE.getId_etat();
    } catch (Exception e) {
        // En cas d'erreur, on continue sans état sélectionné
    }
}
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
            margin-top: 30px;
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
        td input[type="text"],
        td select {
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
        .btn-add {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-toggle {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .btn-delete:hover {
            background-color: #da190b;
        }
        .btn-save:hover {
            background-color: #45a049;
        }
        .btn-add:hover {
            background-color: #0b7dda;
        }
        .btn-toggle:hover {
            background-color: #0b7dda;
        }
        .actions-cell {
            text-align: center;
            min-width: 100px;
        }
        .add-form {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-top: 20px;
            border: 2px dashed #ccc;
            display: none;
        }
        .add-form.show {
            display: block;
        }
        .add-form h3 {
            margin-top: 0;
            color: #2196F3;
        }
    </style>
    <script>
        function toggleAddForm() {
            var form = document.getElementById('addStateForm');
            var btn = document.getElementById('toggleBtn');
            if (form.classList.contains('show')) {
                form.classList.remove('show');
                btn.textContent = ' Ajouter un nouvel état';
            } else {
                form.classList.add('show');
                btn.textContent = ' Annuler';
            }
        }
    </script>
</head>
<body>
<jsp:include page="navbar.jsp" />

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
        
        <label>État du chèque :</label>
        <select name="id_etat">
            <% if (etat != null && !etat.isEmpty()) {
                   for (EtatCheque e : etat) {
                       boolean selected = (etatActuelId != null && etatActuelId == e.getId_etat());
            %>
                <option value="<%= e.getId_etat() %>" <%= selected ? "selected" : "" %>>
                    <%= e.getNameEtat() %>
                </option>
            <%     }
               } else { %>
                <option value="">Aucun état disponible</option>
            <% } %>
        </select>
        <button type="submit">Modifier le chèque</button>
    </form>

    <%-- SECTION TABLEAU POUR LES ÉTATS DU CHÈQUE --%>
    <h2>États du chèque :</h2>
    
    <table>
        <thead>
            <tr>
                <th>ID ChequeEtat</th>
                <th>État</th>
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
                        <select name="id_etat" required>
                            <% if (etat != null && !etat.isEmpty()) {
                                   for (EtatCheque et : etat) {
                                       boolean selected = (e.getId_etat() == et.getId_etat());
                            %>
                                <option value="<%= et.getId_etat() %>" <%= selected ? "selected" : "" %>>
                                    <%= et.getNameEtat() %>
                                </option>
                            <%     }
                               } %>
                        </select>
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

    <%-- BOUTON POUR AFFICHER/MASQUER LE FORMULAIRE D'AJOUT --%>
    <button type="button" class="btn-toggle" id="toggleBtn" onclick="toggleAddForm()">
        ➕ Ajouter un nouvel état
    </button>

    <%-- FORMULAIRE D'AJOUT D'UN NOUVEL ÉTAT (caché par défaut) --%>
    <div class="add-form" id="addStateForm">
        <h3>➕ Ajouter un nouvel état pour ce chèque</h3>
        <form action="<%= request.getContextPath() %>/ChequeStatus/add" method="post">
            <input type="hidden" name="id_cheque" value="<%= cheque.getId_Cheque() %>">
            
            <label>État :</label>
            <select name="id_etat" required>
                <option value="">-- Sélectionner un état --</option>
                <% if (etat != null && !etat.isEmpty()) {
                       for (EtatCheque et : etat) {
                %>
                    <option value="<%= et.getId_etat() %>">
                        <%= et.getNameEtat() %>
                    </option>
                <%     }
                   } %>
            </select>

            <label>Date de l'état :</label>
            <input type="date" name="date_etat" required>

            <label>Bénéficiaire :</label>
            <input type="text" name="beneficiaire" placeholder="Nom du bénéficiaire" required>

            <button type="submit" class="btn-add">Ajouter cet état</button>
        </form>
    </div>

<% } %>

</body>
</html>