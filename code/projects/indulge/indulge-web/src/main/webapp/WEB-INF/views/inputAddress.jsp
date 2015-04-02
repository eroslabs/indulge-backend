<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
<body>
	
	<jsp:include page="../views/merchantHeader.jsp" />
	<div class="lh20">&nbsp;</div>
	<div class="container">
		<!-- Nav tabs -->
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 formRightBody">
		<center><h2>Enter Complete Address Details</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		<c:if test="${not empty success_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${success_message}</div>
		</c:if>
		
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveAddress" modelAttribute="merchant" class="form-horizontal" id="addressForm" >
			<div class="resourceListBlock resourceListHeading">
				
				<div class="form-group">
				    <label class="col-sm-3 control-label">Unit*</label>
				    <div class="col-sm-7">
				      <input id="unitNumber" class="form-control" type="text" name="unitNumber" value="${merchant.unitNumber }">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Building*</label>
				    <div class="col-sm-7">
				      <input id="building" class="form-control" type="text" name="building" value="${merchant.building }">
				    </div>
				  </div> 
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Floor*</label>
				    <div class="col-sm-7">
				      <input id="floor" class="form-control" type="text" name="floor" value="${merchant.floor }">
				    </div>
				  </div> 
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Street*</label>
				    <div class="col-sm-7">
				      <input id="street" class="form-control" type="text" name="street" value="${merchant.street }">
				    </div>
				  </div> 
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Landmark*</label>
				    <div class="col-sm-7">
				      <input id="landmark" class="form-control" type="text" name="landmark" value="${merchant.landmark }">
				    </div>
				  </div>
				 <div class="form-group">
				    <label class="col-sm-3 control-label">City*</label>
				    <div class="col-sm-7">
				      <input id="city" class="form-control" type="text" name="city" value="${merchant.city }">
				    </div>
				  </div> 
				 <div class="form-group">
				    <label class="col-sm-3 control-label">State*</label>
				    <div class="col-sm-7">
				      <input id="state" class="form-control" type="text" name="state" value="${merchant.state }">
				    </div>
				  </div>  
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Pincode*</label>
				    <div class="col-sm-7">
				      <input id="pincode" class="form-control" type="text" name="pincode" value="${merchant.pincode }">
				    </div>
				  </div>  
				   
				 <div class="form-group">
				    <label class="col-sm-3 control-label">Country*</label>
				    <div class="col-sm-7">
				      <input id="country" class="form-control" type="text" name="country" value="${merchant.country }">
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Save" class="btn btn-primary" />
				    </div>
				  </div>   
			</div>
		</form:form>
		<a href="inputContact">Skip</a>
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