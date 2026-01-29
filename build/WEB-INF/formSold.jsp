<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Consultation de solde</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fafafc 0%, #eaddf8 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 600px;
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

        .header h2 { font-size: 28px; }

        .content {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
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

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        button {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .result {
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 1px solid #e9ecef;
            font-size: 16px;
        }

        .empty-state {
            color: #6c757d;
            font-style: italic;
        }
    </style>
    
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Consultation de solde</h2>
    </div>
<div class="content">
    <form id="soldeForm">
        <div class="form-group">
            <label>Numéro du compte :</label>
            <input type="text" id="numero_compte" placeholder="Ex: ACC12345" required>
        </div>
        <button type="submit">Consulter le solde</button>
    </form>

    <p id="resultat"></p>
</div>
</div>
<script>
document.getElementById("soldeForm").addEventListener("submit", function (e) {
    e.preventDefault(); // empêche le rechargement

    const numero = document.getElementById("numero_compte").value;

    fetch("<%= request.getContextPath() %>/compte/solde?numero_compte=" 
          + encodeURIComponent(numero))
        .then(response => {
            if (!response.ok) {
                throw new Error("Erreur serveur");
            }
            return response.json();
        })
        .then(data => {
            document.getElementById("resultat").innerText =
                "Solde du compte " + data.numero_compte + " : " + data.solde + " €";
        })
        .catch(() => {
            document.getElementById("resultat").innerText =
                "Impossible de récupérer le solde";
        });
});   
</script>



</body>
</html>
