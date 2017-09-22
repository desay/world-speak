<%--
  Created by IntelliJ IDEA.
  User: helga
  Date: 14.7.16
  Time: 11.21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form role="form" name="form" action="" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <div>
        <label for="email">Email address</label>
        <input type="email" name="email" id="email" value="${form.email}" required autofocus/>
    </div>
    <div>
        <label for="password">Password</label>
        <input type="password" name="password" id="password" required/>
    </div>
    <div>
        <label for="role">Role</label>
        <select name="role" id="role" required>
            <option><c:if test="${form.role == 'USER'}">USER</c:if></option>
            <option><c:if test="${form.role == 'ADMIN'}">ADMIN</c:if></option>
        </select>
    </div>
    <button type="submit">Save</button>
</form>
</body>
</html>
