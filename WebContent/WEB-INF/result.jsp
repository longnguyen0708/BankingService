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
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style type="text/css">
div#map {
	height: 480px;
	width: 400px;
}

div#sel {
	line-height: 30px;
	background-color: #eeeeee;
	text-align: center;
	width: 405px;
	float: left;
}
</style>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDpN0ue_rAXowatn9dDGeGh0_DWVfUZD2Y&callback=window.initMap&libraries=places">
	
</script>

<script type="text/javascript">
	var marker = null;
	var infowindowtarget;
	var placeservice;
	var markers = [];
	var map;
	var directionsDisplay = null;
	var directionsService;
	var state = null;
	var country = null;
	var postal_code = null;
	var latlng;
	var infowindow;
	var address;
	var isdisplayautolocation = false;

	window.initMap = function() {
		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 12,
			center : {
				lat : 37.333,
				lng : -121.881
			}
		});
		directionsService = new google.maps.DirectionsService;
		var geocoder = new google.maps.Geocoder;
		infowindow = new google.maps.InfoWindow;
		infowindowtarget = new google.maps.InfoWindow();
		placeservice = new google.maps.places.PlacesService(map);

		map.addListener('click', function(e) {
			geocodeLatLng(e.latLng, geocoder, true);
		});
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				isdisplayautolocation = true;
				var rawLatLng = "(" + position.coords.latitude + ","
						+ position.coords.longitude + ")";
				geocodeLatLng(rawLatLng, geocoder, false);
			}, function() {
				//handleLocationError(true, infoWindow, map.getCenter());
			});
		} else {
			// Browser doesn't support Geolocation
			//handleLocationError(false, infoWindow, map.getCenter());
		}
	}

	function geocodeLatLng(rawLatLng, geocoder, issendreq) {

		var latlngStr = rawLatLng.toString().split(',');

		var lati = parseFloat(latlngStr[0].substring(1));
		var longt = parseFloat(latlngStr[1].substring(0,
				latlngStr[1].length - 1));

		latlng = {
			lat : lati,
			lng : longt
		};
		geocoder
				.geocode(
						{
							'location' : latlng
						},
						function(results, status) {
							if (status === google.maps.GeocoderStatus.OK) {
								if (results[0]) {

									for (var i = 0; i < results[0].address_components.length; i++) {
										if (results[0].address_components[i].types[0]
												.localeCompare("administrative_area_level_1") == 0) {
											state = results[0].address_components[i].short_name
										}

										if (results[0].address_components[i].types[0]
												.localeCompare("country") == 0) {
											country = results[0].address_components[i].short_name
										}
										if (results[0].address_components[i].types[0]
												.localeCompare("postal_code") == 0) {
											postal_code = results[0].address_components[i].short_name
										}

									}

									address = results[0].formatted_address;
									if (issendreq == true) {
										if (country.localeCompare("US") == 0) {

											sendCriterial(handleusermaker);

										} else {
											window
													.alert('Sorry, We only provide service in US!!!');
										}
									} else {
										handleusermaker();
									}
								} else {
									window.alert('No results found');
								}
							} else {
								window.alert('Geocoder failed due to: '
										+ status);
							}
						});
	}

	function handleusermaker() {
		if (directionsDisplay != null) {
			directionsDisplay.setMap(null);
			directionsDisplay = null;
		}
		if (marker != null) {
			marker.setMap(null);
		}
		marker = new google.maps.Marker({
			position : latlng,
			icon : 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
			map : map
		});
		if (isdisplayautolocation == true) {
			infowindow.setContent(address);
			isdisplayautolocation = false;
		} else {
			infowindow.setContent(address + "<br>Our Recommendation: <b>"
					+ $('#recommendedbank').val().toString()
					+ "</b><br>Click on the marker to see the nearest banks.");
		}
		infowindow.open(map, marker);

		//clear target markers
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
		//search bank nearby
		marker.addListener('click', function() {
			infowindow.close();
			placeservice.nearbySearch({
				location : latlng,
				name : $('#recommendedbank').val(),
				rankBy : google.maps.places.RankBy.DISTANCE
			}, nearbycallback);
		});
	}

	function nearbycallback(results, status) {
		if (status === google.maps.places.PlacesServiceStatus.OK) {
			var max = results.length;
			if (max > 3) {
				max = 3;
			}
			for (var i = 0; i < max; i++) {
				createMarker(results[i], i * 300);
			}
		}
	}

	function createMarker(place, timeout) {
		window.setTimeout(function() {
			var bankmarker = new google.maps.Marker({
				map : map,
				animation : google.maps.Animation.DROP,
				position : place.geometry.location
			});

			markers.push(bankmarker);

			google.maps.event.addListener(bankmarker, 'click', function() {
				infowindowtarget.setContent(place.name);
				infowindowtarget.open(map, this);
				calculateAndDisplayRoute(this);
			});
		}, timeout);
	}

	function calculateAndDisplayRoute(bankmarker) {
		directionsService.route({
			origin : marker.getPosition(),
			destination : bankmarker.getPosition(),
			travelMode : google.maps.TravelMode.DRIVING
		}, function(response, status) {
			if (status === google.maps.DirectionsStatus.OK) {
				if (directionsDisplay != null) {
					directionsDisplay.setMap(null);
					directionsDisplay = null;
				}
				directionsDisplay = new google.maps.DirectionsRenderer;
				directionsDisplay.setMap(map);
				document.getElementById('graph_content').innerHTML = "";
				directionsDisplay.setPanel(document
						.getElementById('graph_content'));
				directionsDisplay.setOptions({
					suppressMarkers : true
				});
				directionsDisplay.setDirections(response);
			} else {
				window.alert('Directions request failed due to ' + status);
			}
		});
	}

	function sendCriterial(callback) {
		var service_type = $("#service_input").val();
		if (service_type.localeCompare("NONE") == 0) {
			alert("PLEASE CHOOSE A BANK SERVICE!!!");
		} else {
			$.ajax({
				url : "/sendCriterial",
				type : 'POST',
				contentType : 'application/json',
				data : "{\"service\": \"" + service_type + "\""
						+ ",\"state\": \"" + state + "\""
						+ ",\"postal_code\": \"" + postal_code + "\"}",
				success : function(data) {
					$(document).ready(function() {
						$("#graph_content").html(data);
						callback();
					});
				},
				error : function(data, status, er) {
					alert("er:" + er);

				}
			});
		}
	}

	function sendcriterialfromselect(selec, callback) {
		var service_type = selec.value;
		if (service_type.localeCompare("NONE") == 0) {
			alert("PLEASE CHOOSE A BANK SERVICE!!!");
		} else {
			if (country.localeCompare("US") != 0 || state == null
					|| postal_code == null) {
				alert("Please choose your location in US!!!");
			} else {

				$.ajax({
					url : "/sendCriterial",
					type : 'POST',
					contentType : 'application/json',
					data : "{\"service\": \"" + service_type + "\""
							+ ",\"state\": \"" + state + "\""
							+ ",\"postal_code\": \"" + postal_code + "\"}",
					success : function(data) {
						$(document).ready(function() {
							$("#graph_content").html(data);
							callback();
						});
					},
					error : function(data, status, er) {
						alert("er:" + er);

					}
				});
			}
		}
	}
</script>

</head>
<body>
	<div id="intro">
		<h1>Retail Banking Services Recomendation</h1>
	</div>
	<div id="sel">
		<h3>Please choose a bank service</h3>
		<select id="service_input"
			onchange="sendcriterialfromselect(this, handleusermaker)">
			<option value="NONE">--- Select ---</option>
			<option value="Debt collection">Debt collection</option>
			<option value="Credit reporting">Credit reporting</option>
			<option value="Credit card">Credit card</option>
			<option value="Bank account or service">Bank account or
				service</option>
			<option value="Consumer Loan">Consumer Loan</option>
			<option value="Money transfers">Money transfers</option>
			<option value="Mortgage">Mortgage</option>
			<option value="Payday loan">Payday loan</option>
			<option value="Prepaid card">Prepaid card</option>
			<option value="Student loan">Student loan</option>
			<option value="Other financial service">Other financial
				service</option>
		</select>
		<div id="map"></div>
	</div>




	<div id="graph_content" style="width: 850px; float: right;">
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
		<c:choose>
			<c:when test="${res.bankList.size() > 0}">
				<div id="chartContainer"
					style="height: 300px; width: 100%; float: right;"></div>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</div>



	<div id="fo">Group #10</div>
</body>


</html>