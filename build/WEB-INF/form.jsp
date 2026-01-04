<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Cheque" %>
<%@ page import="Model.EtatCheque" %>
<%@ page import="Model.ChequeEtat" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.ChequeEtatDAO" %>

<%
User user = (User) session.getAttribute("user");
ArrayList<EtatCheque> etat = (ArrayList<EtatCheque>) request.getAttribute("listeEtat");
Cheque cheque = (Cheque) request.getAttribute("cheque");
ArrayList<ChequeEtat> list =(ArrayList<ChequeEtat>)request.getAttribute("chequeEtat");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (cheque != null) ? "Modifier un chèque" : "Ajouter un chèque" %></title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fafafc 0%, #eaddf8 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: #4CAF50;
            color: white;
        }

        .btn-success:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
        }

        .btn-danger {
            background: #f44336;
            color: white;
        }

        .btn-danger:hover {
            background: #da190b;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.4);
        }

        .btn-back {
            background: #9e9e9e;
            color: white;
            margin-left: 10px;
        }

        .btn-back:hover {
            background: #757575;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 1px;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .actions-cell {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container">
    <% if (cheque == null) { %>
        <h2>Ajouter un chèque</h2>

        <form action="<%= request.getContextPath() %>/Cheque/add" method="post">
             <input type="hidden" name="id_cheque" value="<%= cheque.getId_Cheque() %>">
            <div class="form-group">
                <label>Numéro du chèque :</label>
                <input type="text" name="numero" required>
            </div>

            <div class="form-group">
                <label>Compte :</label>
                <input type="text" name="compte" required>
            </div>

            <div class="form-group">
                <label>Date limite :</label>
                <input type="date" name="date_limite" required>
            </div>
            
            <div class="form-group">
                <label>État du chèque :</label>
                <select name="id_etat">
                    <% if (etat != null && !etat.isEmpty()) {
                           for (EtatCheque e : etat) { %>
                        <option value="<%= e.getId_etat() %>">
                            <%= e.getNameEtat() %>
                        </option>
                    <%     } } %>
                </select>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">Ajouter</button>
                <a href="<%= request.getContextPath() %>/Cheque/liste" class="btn btn-back">
                    Retour à la liste
                </a>
            </div>
        </form>

    <% } else { %>
        <h2>Modifier un chèque</h2>

        <form action="<%= request.getContextPath() %>/Cheque/add" method="post">
            
            <input type="hidden" name="id_cheque" value="<%= cheque.getId_Cheque() %>">

            <div class="form-group">
                <label>Numéro du chèque :</label>
                <input type="text" name="numero" value="<%= cheque.getNumero_Cheque() %>" required>
            </div>

            <div class="form-group">
                <label>Compte :</label>
                <input type="text" name="compte" value="<%= cheque.getNumero_Compte() %>" required>
            </div>

            <div class="form-group">
                <label>Date limite :</label>
                <input type="date" name="date_limite" value="<%= cheque.getDate_limite() %>" required>
            </div>
            <div class="form-group">
                <label>État du chèque :</label>
                <select name="id_etat">
                    <% ChequeEtat Ch = new ChequeEtat(); %>
                              
                    <% if (etat != null && !etat.isEmpty()) {
                           for (EtatCheque e : etat) { %>
                             <%  Ch.setId_etat(e.getId_etat());
                                 ChequeEtatDAO.getChequeAvecIdEtat(Ch);
                               %>
                        <option value="<%= e.getId_etat() %>" 
                            <%= (e.getId_etat() == Ch.getId_etat() ? "selected" : "") %>>
                            <%= e.getNameEtat() %>
                        </option>
                    <%     } } %>
                </select>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Modifier le chèque</button>
                <a href="<%= request.getContextPath() %>/Cheque/liste" class="btn btn-back">
                    Retour à la liste
                </a>
            </div>
        </form>

        <h2 style="margin-top: 40px;">États du chèque</h2>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>État</th>
                    <th>Date</th>
                    <th>Bénéficiaire</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% if (list != null && !list.isEmpty()) {
                   for (ChequeEtat e : list) { %>
                <tr>
                    <td><%= e.getId_ChequeEtat() %></td>
                    
                    <form action="<%= request.getContextPath() %>/ChequeStatus/save/<%= e.getId_ChequeEtat() %>" 
                          method="post">
                        <input type="hidden" name="id_cheque" value="<%= e.getId_cheque() %>">
                        
                        <td>
                            <input type="number" name="id_etat" value="<%= e.getId_etat() %>" required>
                        </td>
                        
                        <td>
                            <input type="date" name="date_etat" value="<%= e.getDaty() %>" required>
                        </td>
                        
                        <td>
                            <input type="text" name="beneficiaire" value="<%= e.getBeneficiaire() != null ? e.getBeneficiaire() : "" %>">
                        </td>
                        
                        <td>
                            <div class="actions-cell">
                                <button type="submit" class="btn btn-success">Enregistrer</button>
                    </form>
                                <form action="<%= request.getContextPath() %>/ChequeStatus/delete/<%= e.getId_ChequeEtat() %>" 
                                      method="get" style="display: inline;">
                                    <input type="hidden" name="id_cheque" value="<%= e.getId_cheque() %>">
                                    <button type="submit" class="btn btn-danger" 
                                            onclick="return confirm('Voulez-vous vraiment supprimer cet état ?');">
                                        Supprimer
                                    </button>
                                </form>
                            </div>
                        </td>
                </tr>
            <%   } 
               } else { %>
                <tr>
                    <td colspan="5" style="text-align: center; padding: 30px; color: #999;">
                        Aucun état disponible pour ce chèque
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>