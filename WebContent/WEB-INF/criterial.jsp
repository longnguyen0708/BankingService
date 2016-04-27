<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<title>Retail Banking Services Recomendation</title>
</head>
<body>

	<h2>Please Enter your search here</h2>
	<form:form method="POST" modelAttribute="criterialForm" action="/addCriterial">
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
</body>
</html>