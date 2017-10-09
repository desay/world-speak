<%--
  Created by IntelliJ IDEA.
  User: Helga
  Date: 09.07.16
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="libs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="libs/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="libs/mCustomScrollbar/css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="libs/DataTables/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="styles/css/global.css">
    <link rel="stylesheet" href="styles/css/main.css">

    <script src="libs/modernizr/modernizr.js"></script>
</head>
<body>
<div class="page js-page">
    <header class="header">
        <div class="container-fluid">
            <div class="user-menu">
                <div class="item">
                    <a href="/create">Add new User</a>
                </div>

                <div class="item"><i class="fa fa-user"></i>Admin</div>
                <div class="item">
                    <form action="/logout" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-primary js-add-row">Log out</button>
                </form>
                </div>
            </div>
        </div>
    </header>

    <aside class="left-menu js-left-menu">
        <div class="toggle-menu js-toggle-menu" title="Меню">
            <div class="btn-row"></div>
            <div class="btn-row"></div>
            <div class="btn-row"></div>
        </div>
        <nav class="left-navigation js-left-navigation mCustomScrollbar">
            <ul class="left-menu-list js-left-menu-list">
                <li class="active js-main-item"><a href="#"><span class="menu-img js-menu-img"><i class="fa fa-home"></i></span>Users</a></li>
                <li class="js-main-item"><a href="#" class="js-prevent-default"><span class="menu-img js-menu-img"><i class="fa fa-file"></i></span>Files <i class="fa fa-angle-down"></i></a>
                    <ul>
                        <li><a href="#1">Menu item 1</a></li>
                        <li><a href="#2">Menu item 2</a></li>
                        <li><a href="#3">Menu item 3</a></li>
                    </ul>
                </li>
                <li class="js-main-item"><a class="js-prevent-default" href="#"><span class="menu-img js-menu-img"><i class="fa fa-cog"></i></span>Settings <i class="fa fa-angle-down"></i></a>
                    <ul>
                        <c:if test="${not empty applicationMenuList}">
                            <c:forEach items="${applicationMenuList}" var="app">
                                <li><a href="#" class="js-prevent-default"><c:out value="${app.name}"/> <i class="fa fa-angle-down fa-angle-down--not-main"></i></a>
                                    <ul>
                                        <c:forEach items="${app.groupMenu}" var="group">
                                            <li><a class="js-prevent-default" href="#5">${group.name} <i class="fa fa-angle-down fa-angle-down--not-main"></i></a>
                                                <ul>
                                                    <c:forEach items="${group.menuItems}" var="item">
                                                        <li><a href="#">${item.name}</a></li>
                                                    </c:forEach>
                                                </ul>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </li>

                <li class="js-main-item"><a href="#"><span class="menu-img js-menu-img"><i class="fa fa-table"></i></span>Tables</a></li>
            </ul>
        </nav>
    </aside>

    <section class="content-wrapper">
        <div class="content">
            <div class="row">
                <div class="js-ajax-messages"></div>
                <form role="form" name="form" id="addForm">
                    <div class="add-new-row js-add-new-row" align="center" style="
    margin-right: 300px;
">
                        Form
                        <div class="btn-group">
                            <button type="button" class="btn btn-success">Russian</button>
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Меню с переключением</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Действие</a></li>
                                <li><a href="#">Другое действие</a></li>
                                <li><a href="#">Что-то иное</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Отдельная ссылка</a></li>
                            </ul>
                        </div>
                        To
                        <div class="btn-group">
                            <button type="button" class="btn btn-success">English</button>
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Меню с переключением</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Действие</a></li>
                                <li><a href="#">Другое действие</a></li>
                                <li><a href="#">Что-то иное</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Отдельная ссылка</a></li>
                            </ul>
                        </div>

                        <button type="button" class="btn btn-default btn-lg" style="margin-left: 160px;
"><span class="glyphicon glyphicon-star"></span></button>
                        <button type="button" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-volume-up"></span></button>

                        <div class="btn-group" style="
    left: 300px;
">
                            <button type="button" class="btn btn-success">Select theme</button>
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Меню с переключением</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Действие</a></li>
                                <li><a href="#">Другое действие</a></li>
                                <li><a href="#">Что-то иное</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Отдельная ссылка</a></li>
                            </ul>
                        </div>
                    </div>                    <div class="add-new-row js-add-new-row" align="center">
                        <i class="fa fa-microphone fa-3x" aria-hidden="true"></i>
                    </div>
                    <div class="add-new-row js-add-new-row" align="center">
                        <textarea rows="3"></textarea>
                    </div>

                </form>
            </div>
        </div>
    </section>
</div>
<div class="hidden"></div>
<div class="loader js-loader">
    <div class="loader_inner"></div>
</div>
<script src="libs/jquery/jquery-2.1.4.min.js"></script>
<script src="libs/DataTables/js/jquery.dataTables.min.js"></script>
<script src="libs/DataTables/js/dataTables.bootstrap.min.js"></script>
<script src="libs/mCustomScrollbar/jquery.mCustomScrollbar.min.js"></script>
<script src="js/common.js"></script>
</body>
</html>