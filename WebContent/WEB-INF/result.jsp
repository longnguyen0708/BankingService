<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Retail Banking Services Recomendation</title>
<script type="text/javascript"
	src="<c:url value="/resources/jscharts.js" />">
	
</script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery-1.12.3.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/main.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/canvasjs.min.js" />"></script>
<link href="<c:url value="/resources/main.css" />" rel="stylesheet">
</head>
<body>
	<div id="intro">
		<h1>Retail Banking Services Recomendation</h1>
	</div>
	<div id="sel">
		<form:form method="POST" modelAttribute="criterialForm"
			action="/addCriterial">
			<table>

				<tr>
					<td>Service</td>
					<td><form:select path="service">
							<form:option value="NONE" label="--- Select ---" />
							<form:options items="${serviceList}" />
						</form:select></td>
				</tr>
				<tr>
					<td>State</td>
					<td><form:select path="state">
							<form:option value="NONE" label="--- Select ---" />
							<form:options items="${stateList}" />
						</form:select></td>
				</tr>

				<tr>
					<td colspan="3"><input type="submit" /></td>
				</tr>
			</table>
		</form:form>
	</div>

	<script type="text/javascript">
		window.onload = function() {
			var chart = new CanvasJS.Chart(
					"chartContainer",
					{
						title : {
							text : "Complaints Comparison on ${res.criterial.service} in ${res.criterial.state}"
						},
						animationEnabled : true,
						axisY : {
							title : "Complaints"
						},
						legend : {
							verticalAlign : "bottom",
							horizontalAlign : "center"
						},
						theme : "theme2",
						data : [

						{
							type : "column",
							showInLegend : false,
							legendMarkerColor : "grey",
							dataPoints : []
						} ]
					});
			<c:forEach items="${res.bankList}" var="item">
			chart.options.data[0].dataPoints.push({
				y : parseInt('${item.complaints}'),
				label : "${item.name}"
			});
			</c:forEach>
			chart.render();
		}
	</script>
	<div id="chartContainer" style="height: 300px; width: 80%;  float:right;"></div>

	<div id="fo">Group #10</div>
</body>


</html>