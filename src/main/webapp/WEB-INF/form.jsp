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

        .form-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid #e9ecef;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group.hidden {
            display: none;
        }

        label {
            font-weight: 600;
            color: #495057;
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        button, .btn {
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

        button[type="submit"], .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        button[type="submit"]:hover, .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .section-title {
            color: #2d3748;
            font-size: 24px;
            font-weight: 700;
            margin: 40px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
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

        td input[type="number"],
        td input[type="date"],
        td input[type="text"],
        td select {
            margin: 0;
            padding: 8px 12px;
            font-size: 14px;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f44336 0%, #e91e63 100%);
            color: white;
            padding: 8px 15px;
            font-size: 13px;
            box-shadow: 0 2px 10px rgba(244, 67, 54, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.5);
        }

        .btn-save {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 8px 15px;
            font-size: 13px;
            margin-bottom: 5px;
            box-shadow: 0 2px 10px rgba(76, 175, 80, 0.3);
        }

        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.5);
        }

        .btn-add {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
            padding: 8px 15px;
            font-size: 13px;
            box-shadow: 0 2px 10px rgba(33, 150, 243, 0.3);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.5);
        }

        .btn-toggle {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
            padding: 12px 25px;
            font-size: 15px;
            margin-top: 20px;
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.4);
            width: 100%;
        }

        .btn-toggle:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.6);
        }

        .actions-cell {
            text-align: center;
            min-width: 120px;
        }

        .add-form {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 10px;
            margin-top: 20px;
            border: 2px dashed #667eea;
            display: none;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .add-form.show {
            display: block;
        }

        .add-form h3 {
            color: #2196F3;
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .content {
                padding: 20px;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px 5px;
            }

            button, .btn {
                padding: 10px 15px;
                font-size: 13px;
            }
        }
    </style>
    <script>
        function toggleAddForm() {
            var form = document.getElementById('addStateForm');
            var btn = document.getElementById('toggleBtn');
            if (form.classList.contains('show')) {
                form.classList.remove('show');
                btn.textContent = '➕ Ajouter un nouvel état';
            } else {
                form.classList.add('show');
                btn.textContent = '❌ Annuler';
            }
        }

        function toggleBeneficiaire(selectElement, beneficiaireId) {
            var selectedText = selectElement.options[selectElement.selectedIndex].text.toLowerCase();
            var beneficiaireDiv = document.getElementById(beneficiaireId);
            var beneficiaireInput = beneficiaireDiv.querySelector('input[name="beneficiaire"]');
            
            if (selectedText.includes('encaisser') || selectedText.includes('encaissé')) {
                beneficiaireDiv.classList.remove('hidden');
                beneficiaireInput.required = true;
            } else {
                beneficiaireDiv.classList.add('hidden');
                beneficiaireInput.required = false;
                beneficiaireInput.value = '';
            }
        }

        // Initialiser l'affichage au chargement de la page
        window.onload = function() {
            // Pour le formulaire d'ajout
            var addSelect = document.querySelector('#addStateForm select[name="id_etat"]');
            if (addSelect) {
                toggleBeneficiaire(addSelect, 'beneficiaire_add');
            }

            // Pour les lignes du tableau
            var tableSelects = document.querySelectorAll('table select[name="id_etat"]');
            tableSelects.forEach(function(select, index) {
                toggleBeneficiaire(select, 'beneficiaire_row_' + index);
            });
        };
    </script>
</head>
<body>

<div class="container">
    <div class="header">
        <h2><%= (cheque != null) ? "Modifier un chèque" : "Ajouter un chèque" %></h2>
    </div>

    <div class="content">
        <% if (cheque == null) { %>
            <!-- FORMULAIRE D'AJOUT -->
            <div class="form-card">
                <form action="<%= request.getContextPath() %>/Cheque/add" method="post">
                    
                    <div class="form-group">
                        <label>Numéro du chèque :</label>
                        <input type="text" name="numero" placeholder="Ex: CH-2024-001" required>
                    </div>

                    <div class="form-group">
                        <label>Compte :</label>
                        <input type="text" name="compte" placeholder="Ex: 123456789" required>
                    </div>

                    <div class="form-group">
                        <label>Date limite :</label>
                        <input type="date" name="date_limite" required>
                    </div>
                    
                    <div class="form-group">
                        <label>État du chèque :</label>
                        <select name="id_etat" required>
                            <option value="">-- Sélectionner un état --</option>
                            <% if (etat != null && !etat.isEmpty()) {
                                   for (EtatCheque e : etat) {
                            %>
                                <option value="<%= e.getId_etat() %>">
                                    <%= e.getNameEtat() %>
                                </option>
                            <%     }
                               }  %>
                        </select>
                    </div>

                    <button type="submit">Ajouter le chèque</button>
                </form>
            </div>

        <% } else { %>
            <!-- FORMULAIRE DE MODIFICATION -->
            <div class="form-card">
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
                        <select name="id_etat" required>
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
                    </div>

                    <button type="submit">Enregistrer les modifications</button>
                </form>
            </div>

            <!-- SECTION TABLEAU POUR LES ÉTATS DU CHÈQUE -->
            <h2 class="section-title">États du chèque</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>État</th>
                        <th>Date</th>
                        <th>Bénéficiaire</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% if (list != null && !list.isEmpty()) {
                       int rowIndex = 0;
                       for (ChequeEtat e : list) { 
                           String beneficiaireId = "beneficiaire_row_" + rowIndex;
                           // Vérifier si l'état actuel est "encaisser"
                           String etatName = "";
                           boolean isEncaisser = false;
                           if (etat != null) {
                               for (EtatCheque et : etat) {
                                   if (et.getId_etat() == e.getId_etat()) {
                                       etatName = et.getNameEtat().toLowerCase();
                                       isEncaisser = etatName.contains("encaisser") || etatName.contains("encaissé");
                                       break;
                                   }
                               }
                           }
                %>
                    <tr>
                        <td><strong>#<%= e.getId_ChequeEtat() %></strong></td>
                        
                        <form action="<%= request.getContextPath() %>/ChequeStatus/save/<%= e.getId_ChequeEtat() %>" 
                              method="post">
                            <input type="hidden" name="id_cheque" value="<%= e.getId_cheque() %>">
                            <input type="hidden" name="id_ChequeEtat" value="<%= e.getId_ChequeEtat() %>">
                            
                            <td>
                                <select name="id_etat" required onchange="toggleBeneficiaire(this, '<%= beneficiaireId %>')">
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
                            
                            <td id="<%= beneficiaireId %>" class="<%= !isEncaisser ? "hidden" : "" %>">
                                <input type="text" name="beneficiaire" value="<%= e.getBeneficiaire() != null ? e.getBeneficiaire() : "" %>" placeholder="Nom du bénéficiaire" <%= isEncaisser ? "required" : "" %>>
                            </td>
                            
                            <td class="actions-cell">
                                <button type="submit" class="btn-save">Sauvegarder</button>
                        </form>
                                <br>
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
                <%   
                       rowIndex++;
                       } 
                   } else { %>
                    <tr>
                        <td colspan="5" class="empty-state">
                            Aucun état disponible pour ce chèque.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <!-- BOUTON POUR AFFICHER/MASQUER LE FORMULAIRE D'AJOUT -->
            <button type="button" class="btn-toggle" id="toggleBtn" onclick="toggleAddForm()">
                ➕ Ajouter un nouvel état
            </button>

            <!-- FORMULAIRE D'AJOUT D'UN NOUVEL ÉTAT -->
            <div class="add-form" id="addStateForm">
                <h3>➕ Ajouter un nouvel état pour ce chèque</h3>
                <form action="<%= request.getContextPath() %>/ChequeStatus/add" method="post">
                    <input type="hidden" name="id_cheque" value="<%= cheque.getId_Cheque() %>">
                    
                    <div class="form-group">
                        <label>État :</label>
                        <select name="id_etat" required onchange="toggleBeneficiaire(this, 'beneficiaire_add')">
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
                    </div>

                    <div class="form-group">
                        <label>Date de l'état :</label>
                        <input type="date" name="date_etat" required>
                    </div>

                    <div class="form-group hidden" id="beneficiaire_add">
                        <label>Bénéficiaire :</label>
                        <input type="text" name="beneficiaire" placeholder="Nom du bénéficiaire">
                    </div>

                    <button type="submit" class="btn-add">✅ Ajouter cet état</button>
                </form>
            </div>

        <% } %>
    </div>
</div>

</body>
</html>