<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	var chart = new CanvasJS.Chart(
			"chartContainer",
			{
				title : {
					text : "Complaints Comparison on ${res.criterial.service} in ${res.criterial.state}, ${res.criterial.postalCode}"
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
</script>
<c:choose>
	<c:when test="${res.bankList.size() > 0}">
		<div id="chartContainer"
			style="height: 300px; width: 100%; float: right;"></div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>


<script type="text/javascript">
	var chart = new CanvasJS.Chart(
			"sentimentContainer",
			{
				title : {
					text : "Real-time Sentiment on Twitter"
				},
				axisY : {
					title : "Tweets"
				},
				animationEnabled : true,
				data : [
						{
							type : "stackedColumn",
							toolTipContent : "{label}<br/><span style='\"'color: {color};'\"'><strong>{name}</strong></span>: {y} tweets",
							name : "Negative",
							showInLegend : "true",
							dataPoints : []
						},
						{
							type : "stackedColumn",
							toolTipContent : "{label}<br/><span style='\"'color: {color};'\"'><strong>{name}</strong></span>: {y} tweets",
							name : "Positive",
							showInLegend : "true",
							dataPoints : []
						} ],
				legend : {
					cursor : "pointer",
					itemclick : function(e) {
						if (typeof (e.dataSeries.visible) === "undefined"
								|| e.dataSeries.visible) {
							e.dataSeries.visible = false;
						} else {
							e.dataSeries.visible = true;
						}
						chart.render();
					}
				}
			});
	<c:forEach items="${res.sentimentList}" var="item">
	chart.options.data[0].dataPoints.push({
		y : parseInt('${item.negative}'),
		label : "${item.bankName}"
	});
	chart.options.data[1].dataPoints.push({
		y : parseInt('${item.positive}'),
		label : "${item.bankName}"
	});
	</c:forEach>
	chart.render();
</script>
<c:choose>
	<c:when test="${res.sentimentList.size() > 0}">
		<div id="sentimentContainer"
			style="height: 300px; width: 100%; float: right;"></div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>