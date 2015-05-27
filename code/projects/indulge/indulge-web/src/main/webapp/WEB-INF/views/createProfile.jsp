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
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,500,500,200,600,500' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    
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

	<div class="container">
		<!-- Nav tabs -->
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 formRightBody">
			<c:if test="${not empty error_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-danger">${error_message}</div>
			</c:if>
			<c:if test="${not empty success_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-success">${success_message}</div>
			</c:if>
		</div>
	</div>
<!--1fbbad ddcbbd f0f0f0-->

	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
	    		<div class="row font-type sign-up font-size-32" style="color:#ddcbbd">Sign Up</div>
		    	<div class="row" style="padding-top:8px; margin: 15px 0px 0px 0px; background-color:#ddcbbd"></div>
				
				<form:form method="POST" action="saveMerchantBasicProfile" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm" style="padding-top:15px">

				<div style="width:70%">
				<center>
	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Name</label>
	    				<div class="input-group" id="signup1">
	     					<div class="fa fa-user fa-2x input-group-addon"></div>
	     					<input id="name" class="form-control signup-field" type="text" name="name" placeholder="Merchant Name">
	    				</div>
	  				</div>


	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">City</label>
	    				<div class="input-group">
	    					<div class="fa fa-globe fa-2x input-group-addon"></div>
	            			<input type="text" name="city" class="form-control signup-field" id="city" placeholder="Delhi/NCR" list="browser">
	            			<datalist id="browser">
								<c:forEach var="state" items="${states}" varStatus="status">
									<c:forEach var="city" items="${state.cities}" varStatus="stat">
									    <div id="row">
								    		<option value="${city.cityName}">
										</div>
									</c:forEach>
								</c:forEach>			
							</datalist>
	    				</div>
	  				</div>


	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	    				<div class="input-group">
	    					<div class="fa fa-map-marker fa-2x input-group-addon"></div>
	            			<input type="text"name="locality"  class="form-control signup-field" id="locality" placeholder="Locality">
	    				</div>
	  				</div>

	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	    				<div class="input-group">
	    					<div class="fa fa-home fa-2x input-group-addon"></div>
	    					 <select id="merchantType" name="merchantType" class="form-control signup-field" placeholder="Type">
							  	<option value="0">Merchant</option>
						  		<option value="1">Indivisual</option>
							</select>
	    				</div>
	  				</div>


	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	    				<div class="input-group">
	    					<div class="fa fa-envelope-o fa-2x input-group-addon"></div>
	    	        		<input id="email" name="email" type="text" class="form-control signup-field" placeholder="Email Id">
	    				</div>
	  				</div>

	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	    				<div class="input-group">
	    					<div class="fa fa-phone fa-2x input-group-addon"></div>
	    	        		<input id="phone" name="phone" type="text" class="form-control signup-field" placeholder="Phone No.">
	    				</div>
	  				</div>

	  				<div class="form-group">
	    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
	    				<div class="input-group">
	    					<div class="fa fa-lock fa-2x input-group-addon"></div>
	        	    		<input id="passPhrase" type="password" name="passPhrase" class="form-control signup-field" placeholder="Password">
	    				</div>
	  				</div>
	  			</center>
	  			</div>
            	<input type="hidden" name="state"value="Delhi"/>
            	<input type="hidden" name="country" value="India"/>
            	<div class="row font-type font-size-16 signup-terms">
           			By signing up, I agree to to Indulge's Terms of Service
        		</div>
				
				<input type="submit" value="Create Account" class="signup-button font-size-16 font-type">
	    		
	    		</form:form>
	    		<div class="font-size-32 white-bg" style="margin-bottom:15px; padding-top:15px; padding-bottom:15px">
	    			Already a member ? 
	    			<a href="${pageContext.servletContext.contextPath }/merchant/login" style="color:#ddcbbd">Login Now.</a>
	    		</div>
			</div>
		</center>
		</div>
	</div>

	<!-- Bootstrap Core JavaScript -->
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
		        expression: "if ((jQuery.trim(VAL)).length > 3 && (jQuery.trim(VAL)).length < 100) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Name should be greater than 3 and less than 100 Chars"
		    });
			jQuery("#email").validate({
		        expression: "if(VAL=='' || validateEmail(VAL)) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Please Enter the valid email address."
		    });
			jQuery("#passPhrase").validate({
				expression: "if ((jQuery.trim(VAL)).length != 0 && (jQuery.trim(VAL)).length > 3) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Password can not left blank and should be greater than 3 chars."
		    });
    
			jQuery("#phone").validate({
				expression: "if ((jQuery.trim(VAL)).length == 10 && jQuery.isNumeric(VAL)  ) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Contact number should be of 10 numeric digits"
		    });
			jQuery("#city").validate({
				expression: "if ((jQuery.trim(VAL)).length > 3 ) return true; else {$('div#uploading').hide(); return false;}",
		        message: "City can not left blank & should be a valid city."
		    });
			jQuery("#locality").validate({
				expression: "if ((jQuery.trim(VAL)).length > 3) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Locality can not left blank & should be altleast 3 chars."
		    });
			
		});
	</script>
	<script src="${pageContext.servletContext.contextPath }/js/bootstrap.js"></script>
</body>
</html>