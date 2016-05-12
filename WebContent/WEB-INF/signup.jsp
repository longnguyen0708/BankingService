<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Retail Banking Services Recommendation</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes" />

<script type="text/javascript"
	src="<c:url value="/resources/jquery-1.12.3.min.js" />"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link href="<c:url value="/resources/main.css"/>" rel="stylesheet">

</head>
<body>
	<div id="intro">
		<h1>Retail Banking Services Recommendation</h1>
	</div>
	<h2 style="text-align: center">Signup</h2>


	<div id="login" class="container">

		<div class="row">
			<!--div class="col-sm-7"-->
				<div class="login-container">
					<div id="output"></div>
					<div class="avatar"></div>
					<div class="form-box">
						<form:form action="/doSignup" class="form-signin" method="post"
							modelAttribute="signupAttribute">
							<br>
							<form:input class="form-control" placeholder="Username"
								name="username" type="text" path="username" />
							<br>
							<form:input class="form-control" placeholder="Email" name="email"
								type="text" path="email" />
							<br>
							<form:input class="form-control" placeholder="Password"
								name="password" type="password" path="password" />
							<br>
							<form:input class="form-control" placeholder="Retype Password"
								name="password" type="password" path="passwordAgain" />
							<br>
							<input type="submit" class="btn btn-info btn-block login"
											name="signup" id="login_1" value="Sign up" />
										<br>
						</form:form>
					</div>
				</div>
			<!-- /div-->
		</div>
	</div>



	<c:if test="${noti}">
		<!--  start message-red -->
		<div class="clear"></div>
		<div style="color: red;">${notiMsg}</div>
		<!--  end message-red -->
	</c:if>
</body>
</html>