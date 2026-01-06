
<%@ page import="Model.User" %>
<%
User navUser = (User) session.getAttribute("user");
%>

<style>
    
    .navbar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .navbar-brand {
        font-size: 24px;
        font-weight: 600;
    }

    .navbar-menu {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .nav-link {
        color: white;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .nav-link:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }

    .navbar-user {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        background: rgba(255, 255, 255, 0.15);
        padding: 8px 15px;
        border-radius: 20px;
    }

    .btn-login,
    .btn-logout {
        background: white;
        color: #667eea;
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .btn-login:hover,
    .btn-logout:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 255, 255, 0.3);
    }

    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            gap: 10px;
        }

        .navbar-menu {
            flex-direction: column;
            gap: 10px;
        }
    }
</style>

<div class="navbar">
    <div class="navbar-brand">Gestion des Cheques</div>
    <div class="navbar-menu">
        <a href="<%= request.getContextPath() %>/Encaissement">Encaissement</a>
    <a href="<%= request.getContextPath() %>/Cheque/form">Formulaire</a>
    <a href="<%= request.getContextPath() %>/Mouvement/liste">Mouvements</a>
    <a href="<%= request.getContextPath() %>/Cheque/liste">Cheque</a>
    </div>
    <div class="navbar-user">
        <% if (navUser != null) { %>
            <div class="user-info">
                <strong><%= navUser.getPrenom() %> <%= navUser.getNom() %></strong>
            </div>
            <a href="<%= request.getContextPath() %>/login?action=logout" class="btn-logout">
                Deconnexion
            </a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login" class="btn-login">
                Se connecter
            </a>
        <% } %>
    </div>
</div>