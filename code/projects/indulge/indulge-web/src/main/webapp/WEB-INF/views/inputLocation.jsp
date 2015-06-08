<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../views/globalhead.jsp" />
<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
</head>

<body>
	<div id="loading">
		<img
			src="${pageContext.servletContext.contextPath }/images/ajax-loader.gif"
			id="loading-image" />
	</div>

<div class="container-fluid body-bg">
	<div class="row">
	<center>
		<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
    		<div class="row font-type sign-up font-size-24 location-header">Setup your profile to maximise client reach</div>
    		<ol class="progress-meter">
    			<li class="progress-point doing">Basic</li><li class="progress-point todo">Address</li><li class="progress-point todo">Contacts</li><li class="progress-point todo">Schedule</li><li class="progress-point todo">Photos</li>
    		</ol>
			<div class="row row15">
				<c:if test="${not empty error_message}">
					<div class="lh10">&nbsp;</div>
					<div class="alert alert-danger">${error_message}</div>
				</c:if>
				<c:if test="${not empty success_message}">
					<div class="lh10">&nbsp;</div>
					<div class="alert alert-success">${success_message}</div>
				</c:if>
			</div>
    		<form:form method="POST" action="saveLocation" modelAttribute="merchant" enctype="multipart/form-data" onsubmit="return validateForm();" class="form-horizontal midbrownbg-color" style="margin-bottom:20px; margin-top:20px" >
	    		<div class="row font-size-20 location-head font-type">
	    			${merchant.name}
	    		</div>
	    		<div class="row location-file-upload">
	    			<div id="file-upload-cont" title="click to load profile image.">
					    <input id="file" type="file" name="file" title="click to load profile image."/>
					    <div id="my-button"><img id="sampler" style="width:100%;" src="${pageContext.servletContext.contextPath }/images/1px.png"/></div>
					    <input id="overlay" name="file"/>
					    
					</div>
	    		</div><br>
	    		<div class="row row15">
	    			<c:if test="${merchant.merchantType==1}">
	    			<center>
		    			<div style="width:70%">
		    				<div class="form-group">
			    				<label class="sr-only" for="exampleInputAmount">Experience</label>
			    				<input id="experience" class="form-control location-field midbrownbg-color" name="experience" placeholder="Experience in Years" value="${merchant.experience}">
			  				</div>
			  				<div class="form-group">
			    				<label class="sr-only" for="exampleInputAmount">Certification</label>
			    				<input id="certification" class="form-control location-field midbrownbg-color" name="experience" placeholder="Certification" value="${merchant.certification}">
			  				</div>
			  			</div>
		  			</center>
	    			</c:if>
	    		</div>
               	<div class="row row15 font-size-20 google-map-header">Set Location</div>
               	<div class="row row15" id="map-canvas" style="height:300px;"></div>
               	<div class="row row15 white-bg">
               		<div class="form-group row15">
               			<div class="input-group" style="width:80%">
	               			<input id="address" class="form-control signup-form geocode-text" type="textbox" placeholder="Enter Location & click Find Location" value="${merchant.locality} ${merchant.city}">
	               			<input type="button" onclick="codeAddress()" value="Find Location" class="geocode-button" title="click to select location">
	      					
      					</div>
      					<input id="lat" class="form-control" type="hidden" name="lat">
      					<input id="lng" class="form-control" type="hidden" name="lng" >
      				</div>

					<div class="form-group">
			    		<div class="row">
			      			<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type white-text" />
			    		</div>
			  		</div> 
			  		<div class="col-md-22 col-lg-22 col-xs-22 col-sm-22" style="text-align:right">        
						<a class="font-size-16 font-type"  href="inputAddress"><u>Skip this step<u></a><br><br>
					</div>
				</div>
  			</form:form>
  		</div>
  	</center>
  	</div>
</div>
	<script type="text/javascript">
		$("input[type='image']").click(function() {
			$("input[id='file']").click();
		});

		function showImage() {
			var fr = new FileReader();
			// when image is loaded, set the src of the image where you want to display it
			fr.onload = function(e) {
				document.getElementById('sampler').className = "col-md-8 thumb";
				document.getElementById('sampler').src = this.result;
			};
			var src = document.getElementById("file");
			fr.readAsDataURL(src.files[0]);

		}
		document.getElementById('file').addEventListener('change', showImage,
				false);
	</script>
	<script type="text/javascript">
		$(document.body).on(
				'click',
				'.dropdown-menu li',
				function(event) {

					var $target = $(event.currentTarget);

					$target.closest('.btn-group').find('[data-bind="label"]')
							.text($target.text()).end().children(
									'.dropdown-toggle').dropdown('toggle');

					return false;

				});
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
	<script>
		$('#loading').hide();
		function showLoader() {
			$('#loading').show();
		}

		var geocoder;
		var map;
		var marker;
		function initialize() {
			geocoder = new google.maps.Geocoder();
			var latlng = new google.maps.LatLng(28.6139391, 77.20902120000005);
			var mapOptions = {
				zoom : 8,
				center : latlng
			}
			map = new google.maps.Map(document.getElementById('map-canvas'),
					mapOptions);
			addDefaultLocation();
			google.maps.event.addListener(map, 'click', function(event) {
				placeMarker(event.latLng);
			});
		}

		function validateForm() {
			if (document.getElementById('lat').value == ''
					|| document.getElementById('lng').value == '') {
				alert("Please select geo code location for easy discovery.");
				return false;
			}
			showLoader();
			return true;
		}
		function addDefaultLocation() {
			var latlng;
			if (navigator.geolocation) {
				// Get current position
				navigator.geolocation.getCurrentPosition(function(position) {
					if (!marker) {
						marker = new google.maps.Marker({
							map : map,
							position : {
								lat : position.coords.latitude,
								lng : position.coords.longitude
							}
						});
					} else {
						marker.setPosition(new google.maps.LatLng(
								position.coords.latitude,
								position.coords.longitude));
						map.setCenter(marker.getPosition());
					}
				}, function() {
					codeAddress();
				});
			}
			if (!latlng) {
				codeAddress();
			}
		}

		function codeAddress() {

			var address = document.getElementById('address').value;
			geocoder
					.geocode(
							{
								'address' : address
							},
							function(results, status) {
								if (status == google.maps.GeocoderStatus.OK) {
									map.setCenter(results[0].geometry.location);
									document.getElementById('lat').value = results[0].geometry.location
											.lat();
									document.getElementById('lng').value = results[0].geometry.location
											.lng();
									if (!marker) {
										marker = new google.maps.Marker(
												{
													map : map,
													position : results[0].geometry.location
												});
									} else {
										marker
												.setPosition(results[0].geometry.location);
									}
								} else {
									alert('Geocode was not successful for the following reason: '
											+ status);
								}
							});
		}

		function placeMarker(location) {

			if (marker == undefined) {
				marker = new google.maps.Marker({
					position : location,
					map : map,
					animation : google.maps.Animation.DROP
				});

			} else {
				marker.setPosition(location);
				document.getElementById('lat').value = location.lat();
				document.getElementById('lng').value = location.lng();
			}
			map.setCenter(location);

		}

		jQuery(document)
				.ready(
						function() {
							jQuery("#file-upload-cont")
									.hover(
											function() {
												jQuery("#my-button")
														.css("background",
																"url('../images/inputDigitalMenu.png') center center no-repeat");
											},
											function() {
												jQuery("#my-button")
														.css("background",
																"url('../images/inputDigitalMenu.png') center center no-repeat");
											}

									);

						});

		google.maps.event.addDomListener(window, 'load', initialize);
	</script>
</body>
</html>
