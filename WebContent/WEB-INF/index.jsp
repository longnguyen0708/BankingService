<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.bank.model.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Retail Banking Services Recomendation</title>

<script type="text/javascript"
	src="<c:url value="/resources/jquery-1.12.3.min.js" />"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/style.css" />">
<style>
.carousel-inner>.item>img, .carousel-inner>.item>a>img {
	width: 100%;
	margin: auto;
}
</style>
</head>
<body>
	<%
		UserInfo userData = (UserInfo) request.getSession().getAttribute(
				"LOGGEDIN_USER");
		if (userData == null) {
	%>
	<div class="container" style="float: right;">
		<input type="button" value="Sign in" data-toggle="modal"
			data-target="#myModalin">
	</div>
	<%
		} else {
	%>
	<div style="float: right;">
		Hello, <%=userData.getUsername()%>
	</div>

	<%
		}
	%>

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
											name="login" id="login" value="login" />
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

	<div class="container">
		<ul class="pagination">
			<li><a href="details.html">About Us</a></li>
			<li><a href="real-time.html">Special Feature</a></li>
			<li><a href="forms.html">Service</a></li>
			<li><a href="contact.html">Contact Us</a></li>
		</ul>
	</div>


	<div class="container">
		<br>
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="/resources/images/bank1.png" alt="Bank1" width="460"
						height="100">
				</div>

				<div class="item">
					<img src="/resources/images/bank2.png" alt="Bank2" width="460"
						height="100">
				</div>

				<div class="item">
					<img src="/resources/images/bank3.png" alt="Bank3" width="460"
						height="100">
				</div>

				<div class="item">
					<img src="/resources/images/bank4.png" alt="Bank4" width="460"
						height="345">
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
		<div class="jumbotron">
			<a href="/criterial">
				<h2 class="text-primary">Retail Banking Recommendation System</h2>
				<p class="text-muted">Let's select a bank in your area!</p>
			</a>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<h3 class="text-info">
					<a href="details.html"> Click to see Details About APP 
				</h3>
				</a>
				<p class="text-muted">Provides results based on your selection
					criteria</p>
			</div>
			<div class="col-sm-4">
				<h3 class="text-info">
					<a href="real-time.html"> Real-time reviews 
				</h3>
				</a>
				<p class="text-muted">Shows latest feedbacks</p>
			</div>
			<div class="col-sm-4">
				<h3 class="text-info">
					<a href="contact.html"> Contact us 
				</h3>
				</a>
				<p class="text-muted">Open for further details and enquiry</p>
			</div>
		</div>
	</div>

</body>
</html>