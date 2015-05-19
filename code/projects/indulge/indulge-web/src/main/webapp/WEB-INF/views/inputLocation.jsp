<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" >
    <link href="${pageContext.servletContext.contextPath }/css/custom.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


  </head>
<body>
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
    		<form:form method="POST" action="saveLocation" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal midbrownbg-color" style="margin-bottom:20px; margin-top:20px" >
	    		<div class="row font-size-20 location-head font-type">
	    			${merchant.name}
	    		</div>
	    		<div class="row location-file-upload">
	    			<div id="file-upload-cont">
					    <input id="file" type="file" name="file"/>
					    <div id="my-button"></div>
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
	               			<input type="button" onclick="codeAddress()" value="Geocode" class="geocode-button">
	      					<input id="address" class="form-control signup-form geocode-text" type="textbox" value="New Delhi, India">
      					</div>
      					<input id="lat" class="form-control" type="hidden" name="lat">
      					<input id="lng" class="form-control" type="hidden" name="lng" >
      				</div>

					<div class="form-group">
			    		<div class="row">
			      			<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type" />
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
	
	<script type="text/javascript"><!--
		$(document).ready(function(){
			$('div#uploading').hide();
			$("option.drmFree").bind("click",function(){
				var id = $(this).attr("id");
				$("div.drm").hide();
				$("div."+id).show();
				return true;
			});
			$("form#resource").submit(function(){
				$('div#uploading').show();
			});
		});
		//$("#handle, #title, #originalIds, #publisher, #discount, #downloadUrl").focus(function(){
			//	$(this).prev().hide();
		//	});
		
		jQuery(function(){
			jQuery("#handle").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Handle field can not left blank."
		    });
			jQuery("#title").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Title field can not left blank."
		    });
			jQuery("#originalIds").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "ISBN field can not left blank."
		    });
			jQuery("#publisher").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Title field can not left blank."
		    });
			jQuery("#discount").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Discount field can not left blank."
		    });
			
			jQuery("#downloadUrl").validate({
		        expression: "if (($('option.drmFree:selected').attr('id') == 'drmFreeYes' && $('div.'+$('option.drmFree:selected').attr('id')).find('input').val().trim().length ==0)) {$('div#uploading').hide(); return false;} else return true;",
		        message: "For DRM Free resource Download URL can not left blank."
		    });
		});
	</script>
	<script type="text/javascript">
	$("input[type='image']").click(function() {
    $("input[id='file']").click();
});</script>
	<script type="text/javascript">
	 $( document.body ).on( 'click', '.dropdown-menu li', function( event ) {

      var $target = $( event.currentTarget );

      $target.closest( '.btn-group' )
         .find( '[data-bind="label"]' ).text( $target.text() )
            .end()
         .children( '.dropdown-toggle' ).dropdown( 'toggle' );

      return false;

   });</script>

     <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script>
var geocoder;
var map;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(28.6139391, 77.20902120000005);
  var mapOptions = {
    zoom: 8,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function codeAddress() {
  var address = document.getElementById('address').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      document.getElementById('lat').value=results[0].geometry.location.lat();
      document.getElementById('lng').value=results[0].geometry.location.lng();
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}
jQuery(document).ready(function(){
	jQuery("#file-upload-cont").hover(
		function(){
		jQuery("#my-button").css("background","url('../images/location-header-hover.png') center center no-repeat");},
		function(){
		jQuery("#my-button").css("background","url('../images/location-header.png') center center no-repeat");
		}

	);
});

google.maps.event.addDomListener(window, 'load', initialize);


    </script>
</body>
</html>