<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Retail Banking Services Recomendation</title>
</head>
<body>
	<form:form action="/doSignup" method="post"
		modelAttribute="signupAttribute">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>Your name</th>
				<td><form:input type="text" class="login-inp" path="username" /></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><form:input type="text" class="login-inp" path="email" /></td>
			</tr>
			<tr>
				<th>Password</th>
				<td><form:input type="password" path="password" /></td>
			</tr>
			<tr>
				<th>Password again</th>
				<td><form:input type="password" path="passwordAgain" /></td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" class="submit-login"
					name="Create your account" /></td>
			</tr>
		</table>
	</form:form>
	<c:if test="${noti}">
		<!--  start message-red -->
		<div class="clear"></div>
		<div style="color: red;">${notiMsg}</div>
		<!--  end message-red -->
	</c:if>
</body>
</html>