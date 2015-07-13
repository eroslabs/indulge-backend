<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.servletContext.contextPath }/css/bootstrap.min.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath }/js/jquery.validate-min.js"></script>
	<link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
  </head>

<body>
	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
				
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">Ensure that clients can get easily in touch</div>
	    		<ol class="progress-meter">
	    			<li class="progress-point done">Basic</li><li class="progress-point doing">Address</li><li class="progress-point todo">Contacts</li><li class="progress-point todo">Schedule</li><li class="progress-point todo">Photos</li>
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
	    		<form:form method="POST" action="saveAddress" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px; margin-bottom:15px;padding-bottom:30px">
		    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Enter Venue Info
			    	</div>
		    		<div style="width:70%">
		    			<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Address</label>
		    				<textarea id="address" class="form-control signup-field" name="address" placeholder="Address" value="${merchant.address}" style="resize:none; height:100px; border:1px solid #1fbbad"></textarea>
		  				</div>

		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Landmark</label>
		    				<input id="landmark" class="form-control signup-field" type="text" name="landmark" placeholder="Landmark" value="${merchant.landmark }">
		  				</div>
		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Establishment</label>
		    				<input id="establishment" class="form-control signup-field" type="text" name="establishment" placeholder="Mall/Market/Hotel" value="${merchant.establishment }">
		  				</div>
		  				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Pincode</label>
		    				<input id="pincode" class="form-control signup-field" type="text" name="pincode" placeholder="Pincode" value="${merchant.pincode }">
		  				</div>
		  				<div class="form-group">
			  				<div class="col-xs-16 address-radio">
			  				Credit/Debit Card Accepted
			  				</div>
			  				<div class="col-xs-8">
				  				<label>
								    <input type="radio" name="ccAccepted" value="1" >
								    <span>Yes</span>
								</label>
								<label>
								    <input type="radio" name="ccAccepted" value="0">
								    <span>No</span>
								</label>
							</div>
						</div>
						<div class="form-group">
			  				<div class="col-xs-16 address-radio">
			  				Air Conditioning Facility
			  				</div>
			  				<div class="col-xs-8">
				  				<label>
								    <input type="radio" name="acFacility" value="1" >
								    <span>Yes</span>
								</label>
								<label>
								    <input type="radio" name="acFacility" value="0">
								    <span>No</span>
								</label>
							</div>
						</div>
	    				<input id="city" class="form-control signup-field" type="hidden" name="city" placeholder="City" value="${merchant.city }">
	    				<input id="city" class="form-control signup-field" type="hidden" name="locality" placeholder="Locality" value="${merchant.locality }">
	    				<input id="state" class="form-control signup-field" type="hidden" name="state" placeholder="State" value="${merchant.state }">
	    				<input id="country" class="form-control signup-field" type="hidden" name="country" placeholder="Country" value="${merchant.country }">
					</div>
					<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type white-text">
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
			jQuery("#address").validate({
		        expression: "if ((jQuery.trim(VAL)).length > 3) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Address can not be short or left blank"
		    });
			jQuery("#country").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Country can not left blank."
		    });
    
			jQuery("#city").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "City number can not left blank."
		    });
			jQuery("#state").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "State can not left blank."
		    });
			jQuery("#pincode").validate({
				expression: "if ((jQuery.trim(VAL)).length == 6 && jQuery.isNumeric(VAL)) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Pincode should be 6 digit numeric."
		    });
			
			
		});
	</script>
	<jsp:include page="../views/includeScript.jsp" />
</body>
</html>
