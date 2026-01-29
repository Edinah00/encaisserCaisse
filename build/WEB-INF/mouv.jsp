<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Mouvement" %>

<html>
<head>
    <title>Liste des Mouvements</title>
    <!-- <style>
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
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h2 {
            font-size: 28px;
            font-weight: 600;
            margin: 0;
        }

        .content {
            padding: 40px;
        }

        .filter-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid #e9ecef;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-row {
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }

        .filter-row input,
        .filter-row select {
            flex: 1;
        }

        .filter-row select.operator {
            flex: 0 0 80px;
        }

        label {
            font-weight: 600;
            color: #495057;
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: white;
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
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.4);
            margin-left: 10px;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.6);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }

        tbody tr {
            transition: background-color 0.3s ease;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-credit {
            background: #d4edda;
            color: #155724;
        }

        .badge-debit {
            background: #f8d7da;
            color: #721c24;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }

        .result-count {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .action-buttons {
            margin-top: 30px;
            text-align: center;
        }

        @media (max-width: 768px) {
            .content {
                padding: 20px;
            }

            .filter-grid {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px 5px;
            }

            .btn {
                padding: 10px 15px;
                font-size: 13px;
            }
        }
    </style> -->
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="header">
            <h2>Liste des Mouvements</h2>
        </div>

        <div class="content">
            <!-- Message d'erreur -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Formulaire de recherche -->
            <div class="filter-card">
                <form action="<%= request.getContextPath() %>/Mouvement/liste" method="get">
                    <div class="filter-grid">
                        <!-- Numéro de compte -->
                        <div class="filter-group">
                            <label>Numéro de compte :</label>
                            <input type="text" name="numeroCompte" 
                                   value="<%= request.getParameter("numeroCompte") != null ? request.getParameter("numeroCompte") : "" %>"
                                   placeholder="Ex: 123456789">
                        </div>

                        <!-- Type -->
                        <div class="filter-group">
                            <label>Type :</label>
                            <select name="type">
                                <option value="" <%= (request.getParameter("type") == null || request.getParameter("type").isEmpty()) ? "selected" : "" %>>-- Tous --</option>
                                <option value="debit" <%= "debit".equalsIgnoreCase(request.getParameter("type")) ? "selected" : "" %>>Débit</option>
                                <option value="credit" <%= "credit".equalsIgnoreCase(request.getParameter("type")) ? "selected" : "" %>>Crédit</option>
                            </select>
                        </div>

                        <!-- Date début -->
                        <div class="filter-group">
                            <label>Date début :</label>
                            <div class="filter-row">
                                <input type="date" name="dateDebut" 
                                       value="<%= request.getParameter("dateDebut") != null ? request.getParameter("dateDebut") : "" %>">
                                <select name="dateDebutOperator" class="operator">
                                    <option value=">=" <%= ">=".equals(request.getParameter("dateDebutOperator")) || request.getParameter("dateDebutOperator") == null ? "selected" : "" %>>≥</option>
                                    <option value=">" <%= ">".equals(request.getParameter("dateDebutOperator")) ? "selected" : "" %>> ></option>
                                    <option value="=" <%= "=".equals(request.getParameter("dateDebutOperator")) ? "selected" : "" %>>=</option>
                                </select>
                            </div>
                        </div>

                        <!-- Date fin -->
                        <div class="filter-group">
                            <label>Date fin :</label>
                            <div class="filter-row">
                                <input type="date" name="dateFin" 
                                       value="<%= request.getParameter("dateFin") != null ? request.getParameter("dateFin") : "" %>">
                                <select name="dateFinOperator" class="operator">
                                    <option value="<=" <%= "<=".equals(request.getParameter("dateFinOperator")) || request.getParameter("dateFinOperator") == null ? "selected" : "" %>>≤</option>
                                    <option value="<" <%= "<".equals(request.getParameter("dateFinOperator")) ? "selected" : "" %>>< </option>
                                    <option value="=" <%= "=".equals(request.getParameter("dateFinOperator")) ? "selected" : "" %>>=</option>
                                </select>
                            </div>
                        </div>

                        <!-- Montant min -->
                        <div class="filter-group">
                            <label>Montant minimum :</label>
                            <div class="filter-row">
                                <input type="number" step="0.01" name="montantMin" 
                                       value="<%= request.getParameter("montantMin") != null ? request.getParameter("montantMin") : "" %>"
                                       placeholder="0.00">
                                <select name="montantMinOperator" class="operator">
                                    <option value=">=" <%= ">=".equals(request.getParameter("montantMinOperator")) || request.getParameter("montantMinOperator") == null ? "selected" : "" %>>≥</option>
                                    <option value=">" <%= ">".equals(request.getParameter("montantMinOperator")) ? "selected" : "" %>> ></option>
                                    <option value="=" <%= "=".equals(request.getParameter("montantMinOperator")) ? "selected" : "" %>>=</option>
                                </select>
                            </div>
                        </div>

                        <!-- Montant max -->
                        <div class="filter-group">
                            <label>Montant maximum :</label>
                            <div class="filter-row">
                                <input type="number" step="0.01" name="montantMax" 
                                       value="<%= request.getParameter("montantMax") != null ? request.getParameter("montantMax") : "" %>"
                                       placeholder="0.00">
                                <select name="montantMaxOperator" class="operator">
                                    <option value="<=" <%= "<=".equals(request.getParameter("montantMaxOperator")) || request.getParameter("montantMaxOperator") == null ? "selected" : "" %>>≤</option>
                                    <option value="<" <%= "<".equals(request.getParameter("montantMaxOperator")) ? "selected" : "" %>>< </option>
                                    <option value="=" <%= "=".equals(request.getParameter("montantMaxOperator")) ? "selected" : "" %>>=</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary"> Rechercher</button>
                    <a href="<%= request.getContextPath() %>/Mouvement/liste" class="btn btn-secondary"> Réinitialiser</a>
                </form>
            </div>

            <!-- Résultats -->
            <%
                ArrayList<Mouvement> mouvements = (ArrayList<Mouvement>) request.getAttribute("listeMouvements");
                if (mouvements != null && !mouvements.isEmpty()) {
            %>
                <div class="result-count">
                    <%= mouvements.size() %> mouvement(s) trouvé(s)
                </div>
            <% } %>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Numéro Compte</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th style="text-align: right;">Montant</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (mouvements != null && !mouvements.isEmpty()) {
                        for (Mouvement m : mouvements) {
                %>
                    <tr>
                        <td><strong>#<%= m.getId_mouv() %></strong></td>
                        <td><%= m.getNumero_compte() %></td>
                        <td><%= m.getDate() %></td>
                        <td>
                            <% if ("credit".equalsIgnoreCase(m.getType())) { %>
                                <span class="badge badge-credit">Crédit</span>
                            <% } else { %>
                                <span class="badge badge-debit">Débit</span>
                            <% } %>
                        </td>
                        <td style="text-align: right;">
                            <%= String.format("%,.2f", m.getMontant()) %> Ar
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" class="empty-state">
                            Aucun mouvement trouvé avec les critères de recherche.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div class="action-buttons">
                <a href="<%= request.getContextPath()%>/Encaissement" class="btn btn-secondary">
                     Encaisser un chèque
                </a>
            </div>
        </div>
    </div>
</body>
</html>