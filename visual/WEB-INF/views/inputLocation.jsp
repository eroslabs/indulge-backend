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
	<nav class="navbar navbar-default navbar-custom navbar-fixed-top nav-top" style="background-color:#aea190">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
               <a  class="navbar-brand" style="padding:0px 0px" href="${pageContext.servletContext.contextPath }/merchant/home">
	            		<img src="${pageContext.servletContext.contextPath }/images/logo.png" class="img-responsive" alt="Indulge" style="height:50px" /></a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                   <li><a href="#">Stats</a></li>
                	<li class="active"><a href="#">Basic Info</a></li>
                	<li><a href="#">Services</a></li>
                	<li><a href="#">Deals</a></li>
                	<li><a href="#"> Account</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <br><br>
	<nav class="navbar navbar-default navbar-fixed-bottom nav-bot">
  		<div class="container-fluid" style="margin-top:10px">
  			<center>
  			<div class="col-xs-5" style="font:14px; padding-left:0px; padding-right:0px">Stats</div>
  			<div class="col-xs-5 act" style="font:14px; padding-left:0px; padding-right:0px">Basic Info</div>
  			<div class="col-xs-4" style="font:14px;padding-left:0px; padding-right:0px">Services</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Deals</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Account</div>
  			</center>
  		</div>
	</nav>

	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">Setup your profile to maximise client reach</div>
	    		<ol class="progress-meter">
	    			<li class="progress-point todo">Basic</li><li class="progress-point todo">Address</li><li class="progress-point todo">Contacts</li><li class="progress-point todo">Schedule</li><li class="progress-point todo">Photos</li>
	    		</ol>
	    		<form:form method="POST" action="saveLocation" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal bg-color" style="margin-bottom:20px; margin-top:20px" >
		    		<div class="row font-size-20 location-head font-type">
		    			Enter Basic Info
		    		</div>
		    		<div class="row" style="height:150px;width:150px; margin-top:15px">
		    			<div id="file-upload-cont">
						    <input id="file" type="file"/>
						    <div id="my-button"></div>
						    <input id="overlay"/>
						</div>
		    		</div><br>
					<div style="width:70%">
	  					<div class="form-group" style="border-bottom:1px solid #fff">
	    					<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	     					<input id="name" class="form-control signup-field bg-color" type="text" name="name" placeholder="Salon's Name" style="text-align:center">
	    				</div>
	    				<div class="row" style="border-bottom:1px solid #fff; margin-bottom:10px">
	               			<div class="btn-group" >
	                 			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="background-color:#aea190; border:none">
	                   			<span data-bind="label">Unit Type</span>&nbsp;<span class="caret"></span>
	                 			</button>
	                 			<ul class="dropdown-menu" role="menu" style="min-width:0px; background-color:#aea190">
	                   				<li><a href="#">Spa</a></li>
	                   				<li><a href="#">Salon</a></li>
	                   				<li><a href="#">Individual</a></li>
	                 			</ul>
	               			</div>
	               		</div>
	               	</div>
	               	<div class="row row15 font-size-20" style="background-color:#7b7060;color:#fff; height:26px; text-align:center">Set Location</div>
	               	<div class="row row15" id="map-canvas" style="height:300px;"></div>
	               	<div class="row row15" style="background-color:white">
      					<input id="address" class="form-control signup-form" type="textbox" value="New Delhi, India"><br>
      					<!--<input id="lat" class="form-control" type="textbox" name="lat" value="${merchant.lat}"><input id="lng" class="form-control" type="text" name="lng" value="${merchant.lng}">-->
      					<input type="button" value="Geocode" onclick="codeAddress()">
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



<!--
<div id="uploading" class="loadingBox" style="display:none;">Uploading...</div>

	<div class="lh20">&nbsp;</div>
	<div class="container">
	Nav tabs
	<div class="col-lg-9 col-md-9 col-sm-7 col-xs-12 formRightBody">	
		<div class="formHeader">Upload a single file</div>
		<p class="ValidationErrors" >${error_message}</p>
		<div class="lh20">&nbsp;</div>
		
			<div class="resourceListBlock resourceListHeading">
			
				<div class="form-group">
				    <label class="col-sm-3 control-label">Name*</label>
				    <div class="col-sm-7">
				     
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Lat/Long*</label>
				    <div class="col-sm-7">
				      
				    </div>
				  </div>
				
				<div class="form-group">
				    <label class="col-sm-3 control-label">File</label>
				    <div class="col-sm-7">
				      
				    </div>
				  </div>
				<div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Upload" class="btn btn-primary" />
				    </div>
				  </div>          
			</div>
		<a href="inputAddress">Skip</a>
	</div>
	-->
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
  var latlng = new google.maps.LatLng(-34.397, 150.644);
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
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
</body>
</html>