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
		<center><h2>Sign Up</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveMerchantBasicProfile" modelAttribute="merchant" class="form-horizontal" id="creatMerchantForm" >
			<div class="resourceListBlock resourceListHeading">
				<div class="form-group">
				    <label class="col-sm-3 control-label">Merchant Name*</label>
				    <div class="col-sm-7">
				      <input id="name" class="form-control" type="text" name="name">
				    </div>
				  </div>
				
				<div class="form-group">
				    <label class="col-sm-3 control-label">Email*</label>
				    <div class="col-sm-7">
				      <input id="email" class="form-control" type="text" name="email">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Password*</label>
				    <div class="col-sm-7">
				      <input id="passPhrase" class="form-control" type="password" name="passPhrase">
				    </div>
				  </div>
				 
				<div class="form-group">
				    <label class="col-sm-3 control-label">Phone Number*</label>
				    <div class="col-sm-7">
				      <input id="phone" class="form-control" type="text" name="phone">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Unit*</label>
				    <div class="col-sm-7">
				      <input id="unitNumber" class="form-control" type="text" name="unitNumber">
				    </div>
				  </div>
				 <div class="form-group">
				    <label class="col-sm-3 control-label">City*</label>
				    <div class="col-sm-7">
				      <input id="city" class="form-control" type="text" name="city">
				    </div>
				  </div> 
				 <div class="form-group">
				    <label class="col-sm-3 control-label">State*</label>
				    <div class="col-sm-7">
				      <input id="state" class="form-control" type="text" name="state">
				    </div>
				  </div>  
				 <div class="form-group">
				    <div class="col-sm-4">
				     <input id="agreement" class="form-control" type="checkbox" name="agreement" required>  
				    </div>
				    <label class="col-sm-4 control-label">Agree to Our Terms & Conditions*</label>
				  </div>  
				 
				  <div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Register" class="btn btn-primary" />
				    </div>
				  </div>   
			</div>
		</form:form>
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
			jQuery("#name").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "First name can not left blank"
		    });
			jQuery("#email").validate({
		        expression: "if((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Email address can not left blank."
		    });

			jQuery("#email").validate({
		        expression: "if(validateEmail(VAL)) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Please Enter the valid email address."
		    });
			jQuery("#passPhrase").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Password can not left blank."
		    });
    
			jQuery("#phone").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Contact number can not left blank."
		    });
			jQuery("#unit").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Unit can not left blank."
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