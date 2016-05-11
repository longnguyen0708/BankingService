<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.bank.model.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Retail Banking Services Recommendation</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no" />
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
<style>
.carousel-inner>.item>img, .carousel-inner>.item>a>img {
	width: 100%;
	margin: auto;
}
</style>
</head>
<body>

	<div id="intro">
		<div class="row">
			<div class="col-sm-10">
				<p class="description"></p>
			</div>
			<div class="col-sm-2" style="float: right;">
				<%
					UserInfo userData = (UserInfo) request.getSession().getAttribute(
							"LOGGEDIN_USER");
					if (userData == null) {
				%>

				<input type="button" value="Sign in" data-toggle="modal"
					data-target="#myModalin">

				<%
					} else {
				%>
				<div style="float: right;">
					Hello,
					<%=userData.getUsername()%>
				</div>

				<%
					}
				%>
			</div>
		</div>
		<h1>Retail Banking Services Recommendation</h1>

	</div>



	<script type="text/javascript">
		<c:if test="${noti}">
		$(document).ready(function() {
			$("#myModalin").modal();
		});
		</c:if>
	</script>
	<div class="modal fade" id="myModalin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<div class="modal-content">

				<div class="container">
					<div class="row">
						<div class="col-sm-6">
							<div class="login-container">
								<div id="output"></div>
								<div class="avatar"></div>
								<div class="form-box">
									<form:form class="form-signin" action="/doLogin" method="post"
										modelAttribute="loginAttribute">

										<br>
										<form:input type="text" class="form-control"
											placeholder="Email" path="email" />


										<form:input class="form-control" placeholder="Password"
											type="password" path="password" />
										<br>
										<input type="submit" class="btn btn-info btn-block login"
											name="login" id="login_1" value="login" />
										<br>
									</form:form>
									<a href="/signup"> Create your account</a>
									<c:if test="${noti}">
										<!--  start message-red -->
										<div class="clear"></div>
										<div style="color: red;">${notiMsg}</div>
										<!--  end message-red -->
									</c:if>
								</div>
							</div>
						</div>

					</div>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->

	</div>
	<!-- /.modal -->

	<br>


	<div class="container">
		<br>
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<br>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="/resources/images/Pic1.png" alt="Bank1" width="460"
						height="100">
				</div>

				<div class="item">
					<img src="/resources/images/Pic2.png" alt="Bank2" width="460"
						height="100">
				</div>

				<div class="item">
					<img src="/resources/images/Pic3.png" alt="Bank3" width="460"
						height="100">
				</div>

			</div>

			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<div class="col-sm-5"></div>
			<div class="col-sm-7">
				<h3 class="text-primary">
					Start here <a href="/result" class="btn btn-info btn-md"> <span
						class="glyphicon glyphicon-play-circle"></span>
					</a>
				</h3>
				<br> <br> <br>

			</div>
		</div>
	</div>


	<div id="fo">Group #10</div>

</body>
</html>