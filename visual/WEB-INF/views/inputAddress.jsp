<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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

    <script>
	$(window).load(function(){
    	$("ol.progtrckr").each(function(){
        	$(this).attr("data-progtrckr-steps", 
                $(this).children("li").length);
    		});
		})
	</script>
	<link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
  </head>

<body>
	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
				
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">Ensure that clients can get easily in touch</div>
	    		<ol class="progress-meter">
	    			<li class="progress-point done">Basic</li><li class="progress-point todo">Address</li><li class="progress-point todo">Contacts</li><li class="progress-point todo">Schedule</li><li class="progress-point todo">Photos</li>
	    		</ol>
	    		<form:form method="POST" action="saveMerchantBasicProfile" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px; margin-bottom:15px;padding-bottom:30px">
		    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Enter Address Info
			    	</div>
		    		<div style="width:70%">
		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		   					<input id="unitNumber" class="form-control signup-field" type="text" name="unitNumber" placeholder="Unit No.">
		  				</div>


		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="floor" class="form-control signup-field" type="text" name="floor" placeholder="Floor" value="${merchant.floor }">
		  				</div>


		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="building" class="form-control signup-field" type="text" name="building" placeholder="Building" value="${merchant.building }">
		  				</div>

		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="Street" class="form-control signup-field" type="text" name="street" placeholder="Street Name" value="${merchant.street }">
		  				</div>

		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="landmark" class="form-control signup-field" type="text" name="landmark" placeholder="Landmark" value="${merchant.landmark }">
		  				</div>

		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="city" class="form-control signup-field" type="text" name="city" placeholder="City" value="${merchant.city }">
		  				</div>

		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="state" class="form-control signup-field" type="text" name="state" placeholder="State" value="${merchant.state }">
		  				</div>
		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="pincode" class="form-control signup-field" type="text" name="pincode" placeholder="Pincode" value="${merchant.pincode }">
		  				</div>
		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    				<input id="country" class="form-control signup-field" type="text" name="country" placeholder="country" value="${merchant.country }">
		  				</div>
					</div>
					<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type">
					<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22" style="text-align:right">        
						<a class="font-size-16 font-type" href="inputContact"><u>Skip this step<u></a>
					</div>
	    		</form:form>
	  		</div>
	  	</center>
	  	</div>
	</div>
	<script type="text/javascript">
	function validateEmail(sEmail) {
	    var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    if (filter.test(sEmail)) {
	        return true;
	    }
	    else {
	        return false;
	    }
	}
		jQuery(function(){
			jQuery("#unitNumber").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Unit Number can not left blank"
		    });
			

			
			jQuery("#country").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Country can not left blank."
		    });
    
			jQuery("#floor").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Floor number can not left blank."
		    });
			jQuery("#building").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Building can not left blank."
		    });
			jQuery("#Street").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Street can not left blank."
		    });
			jQuery("#city").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "City can not left blank."
		    });
			jQuery("#state").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "State can not left blank."
		    });
			
			
		});
	</script>
</body>
</html>