<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Retail Banking Services Recomendation</title>
</head>
<body>
	<div>You must login to use our service</div>
	<form:form action="/doLogin" method="post"
		modelAttribute="loginAttribute">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>Email</th>
				<td><form:input type="text" class="login-inp" path="email" /></td>
			</tr>
			<tr>
				<th>Password</th>
				<td><form:input type="password" path="password" /></td>
			</tr>
			<tr>
				<th></th>
				<td valign="top"><input type="checkbox" class="checkbox-size"
					id="login-check" /><label for="login-check">Remember me</label></td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" class="submit-login" /></td>
			</tr>
		</table>
	</form:form>
	<c:if test="${noti}">
		<!--  start message-red -->
		<div class="clear"></div>
		<div style="color: red;">${notiMsg}</div>
		<!--  end message-red -->
	</c:if>
	
	<a href="/signup"> create your (branch name) account</a>
</body>
</html>