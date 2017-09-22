<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">

    <title>Admin Panel</title>
    <meta name="description" content="">

    <link rel="shortcut icon" href="img/favicon/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="img/favicon/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/favicon/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/favicon/apple-touch-icon-114x114.png">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="styles/css/global.css">
    <link rel="stylesheet" href="styles/css/login.css">

    <script src="libs/modernizr/modernizr.js"></script>
</head>
<body>

<div class="login-form">
    <div class="login">
        <form role="form" action="/login" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <h2>Login form</h2>
        <input name="email" placeholder="Email" type="text">
        <input id="pw" name="password" placeholder="Password" type="password">
        <div class="agree">
            <input id="agree" class="agree" name="agree" type="checkbox">
            <label for="agree"></label>Remember me on this computer
        </div>
            <input type="submit" value="Sign in"/>
        </form>
    </div>
</div>
<div class="hidden"></div>
<div class="loader">
    <div class="loader_inner"></div>
</div>
<script src="libs/jquery/jquery-2.1.4.min.js"></script>
<script src="js/common.js"></script>
</body>
</html>