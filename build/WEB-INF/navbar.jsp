<!-- navbar.jsp -->
<style>
    .navbar {
        background-color: #2c3e50;
        padding: 10px;
        display: flex;
        gap: 20px;
    }
    .navbar a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        padding: 6px 12px;
        border-radius: 4px;
    }
    .navbar a:hover {
        background-color: #34495e;
    }
</style>

<div class="navbar">
    <a href="<%= request.getContextPath() %>/Encaissement">Encaissement</a>
    <a href="<%= request.getContextPath() %>/Cheque/form">Formulaire</a>
    <a href="<%= request.getContextPath() %>/Mouvement">Mouvements</a>
    <a href="<%= request.getContextPath() %>/Cheque/liste">Cheque</a>
</div>
