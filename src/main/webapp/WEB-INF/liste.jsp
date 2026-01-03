<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Cheque" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Chèques</title>
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
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
        }

        .btn-add {
            background: white;
            color: #667eea;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .table-container {
            padding: 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-edit {
            background: #4CAF50;
            color: white;
        }

        .btn-edit:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
        }

        .btn-delete {
            background: #f44336;
            color: white;
        }

        .btn-delete:hover {
            background: #da190b;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .table-container {
                padding: 15px;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 10px;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="header">
        <h1> ETU004280 - Gestion des Chèques</h1>
        <a href="<%= request.getContextPath()%>/Cheque/form" class="btn-add">
             Ajouter un chèque
        </a>
    </div>

    <div class="table-container">
        <%
            ArrayList<Cheque> liste = (ArrayList<Cheque>) request.getAttribute("listeCheques");
            if (liste != null && !liste.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Numéro</th>
                    <th>Compte</th>
                    <th>Date limite</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
        <%
                for (Cheque c : liste) {
        %>
                <tr>
                    <td><%= c.getId_Cheque() %></td>
                    <td><%= c.getNumero_Cheque() %></td>
                    <td><%= c.getNumero_Compte() %></td>
                    <td><%= c.getDate_limite() %></td>
                    <td>
                        <div class="actions">
                            <a href="<%= request.getContextPath()%>/Cheque/form/<%= c.getId_Cheque() %>" 
                               class="btn btn-edit">
                                 Modifier
                            </a>
                            <a href="<%= request.getContextPath() %>/Cheque/delete/<%= c.getId_Cheque() %>"
                               class="btn btn-delete"
                               onclick="return confirm('Voulez-vous vraiment supprimer ce chèque ?');">
                                 Supprimer
                            </a>
                        </div>
                    </td>
                </tr>
        <%
                }
        %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <div class="empty-state">
            <p> Aucun chèque disponible</p>
            <a href="<%= request.getContextPath()%>/Cheque/form" class="btn btn-edit">
                Ajouter le premier chèque
            </a>
        </div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>