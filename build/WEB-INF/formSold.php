<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation de solde</title>
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

        .header h2 { 
            font-size: 28px; 
            margin: 0;
        }

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
            transition: all 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .result {
            margin-top: 30px;
            padding: 20px;
            border-radius: 10px;
            font-size: 16px;
            display: none;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .result.success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            display: block;
        }

        .result.error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            display: block;
        }

        .result.loading {
            background: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
            display: block;
        }

        .solde-amount {
            font-size: 24px;
            font-weight: bold;
            margin-top: 10px;
            color: #667eea;
        }

        .loader {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #667eea;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .account-info {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }

        .account-number {
            font-weight: 600;
            color: #495057;
            margin-bottom: 10px;
        }

        .required {
            color: #f44336;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>💰 Consultation de solde</h2>
    </div>
    
    <div class="content">
        <form id="soldeForm">
            <div class="form-group">
                <label for="numero_compte">
                    Numéro du compte <span class="required">*</span>
                </label>
                <input 
                    type="text" 
                    id="numero_compte" 
                    name="numero_compte"
                    placeholder="Ex: ACC12345" 
                    required
                    autocomplete="off"
                >
            </div>
            <button type="submit" id="submitBtn">
                🔍 Consulter le solde
            </button>
        </form>

        <div id="resultat" class="result"></div>
    </div>
</div>

<script>
// Modifiez cette URL selon votre configuration
//const SERVLET_URL = '<%= request.getContextPath() %>/compte/solde?numero_compte=';
const SERVLET_URL = 'http://localhost:8080/ChequeServlet/compte/solde';
const form = document.getElementById('soldeForm');
const submitBtn = document.getElementById('submitBtn');
const resultatDiv = document.getElementById('resultat');
const numeroCompteInput = document.getElementById('numero_compte');

// Gestion de la soumission du formulaire
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const numeroCompte = numeroCompteInput.value.trim();
    
    if (!numeroCompte) {
        showError('Veuillez saisir un numéro de compte');
        return;
    }
    
    // Désactiver le bouton et afficher le loader
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="loader"></span> Recherche en cours...';
    
    // Afficher le message de chargement
    showLoading();
    
    try {
        // Construire l'URL avec le paramètre
        const url = `${SERVLET_URL}?numero_compte=${encodeURIComponent(numeroCompte)}`;
        
        // Appel à l'API servlet
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
            }
        });
        
        if (!response.ok) {
            if (response.status === 400) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Requête invalide');
            } else if (response.status === 404) {
                throw new Error('Compte non trouvé');
            } else {
                throw new Error('Erreur serveur');
            }
        }
        
        const data = await response.json();
        
        // Afficher le résultat
        showSuccess(data);
        
    } catch (error) {
        console.error('Erreur:', error);
        showError(error.message || 'Impossible de récupérer le solde');
    } finally {
        // Réactiver le bouton
        submitBtn.disabled = false;
        submitBtn.innerHTML = '🔍 Consulter le solde';
    }
});

// Fonction pour afficher le message de chargement
function showLoading() {
    resultatDiv.className = 'result loading';
    resultatDiv.innerHTML = `
        <span class="loader"></span>
        Récupération du solde en cours...
    `;
}

// Fonction pour afficher le succès
function showSuccess(data) {
    resultatDiv.className = 'result success';
    
    // Formater le solde avec 2 décimales et séparateurs de milliers
    const soldeFormate = parseFloat(data.solde).toLocaleString('fr-FR', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
    
    resultatDiv.innerHTML = `
        <div class="account-info">
            <div class="account-number">
                📊 Compte : <strong>${data.numero_compte}</strong>
            </div>
            <div>Solde disponible :</div>
            <div class="solde-amount">
                ${soldeFormate} €
            </div>
        </div>
    `;
}

// Fonction pour afficher les erreurs
function showError(message) {
    resultatDiv.className = 'result error';
    resultatDiv.innerHTML = `
        <strong>❌ Erreur</strong>
        <p style="margin-top: 10px;">${message}</p>
    `;
}

// Validation en temps réel
numeroCompteInput.addEventListener('input', (e) => {
    // Convertir en majuscules automatiquement
    e.target.value = e.target.value.toUpperCase();
    
    // Cacher le résultat quand on modifie le numéro
    if (resultatDiv.style.display !== 'none') {
        resultatDiv.className = 'result';
    }
});

// Effacer le résultat quand on clique dans l'input
numeroCompteInput.addEventListener('focus', () => {
    resultatDiv.className = 'result';
});
</script>

</body>
</html>