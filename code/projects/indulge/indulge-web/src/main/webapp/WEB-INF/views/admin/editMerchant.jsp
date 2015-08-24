<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="${pageContext.servletContext.contextPath }/css/bootstrap.css"
	rel="stylesheet">

<link
	href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700'
	rel='stylesheet' type='text/css'>
<link
	href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />

<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
	src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script
	src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.servletContext.contextPath }/js/jquery.validate-min.js"></script>


</head>
<style type="text/css">
 .ValidationErrors {
    float: none;
    position: absolute;
    top: 0;
    right: -100px; /* Offset by width set on label element */
    padding: 0px;
}
body {
	background-color: #f0f0f0;
}
</style>

<body>
	<div class="container-fluid">

		<div class="row">
			<c:if test="${not empty error_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-success col-xs-22 col-sm-14 col-md-push-6 ">${error_message}</div>
			</c:if>
			<c:if test="${not empty success_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-success col-xs-22 col-sm-14 col-md-push-6 ">${success_message}</div>
			</c:if>
			
			<center>
			<h3 align="center">Merchant Search</h3>
			<a href="home">Back to home</a>
								<form:form method="POST" action="editLogin" 
						 class="form-horizontal white-bg" modelAttribute="merchant"
						id="searchMerchantForm" style="width:60%;text-align:left;padding:15px; border:1px solid;">
						<div style="width: 70%" class="registration-page">
							<center>
							<input id="id"  type="hidden" name="id" value="${merchant.id}"	>
								<div class="input-group" >
									Email : <input id="email"  type="text" name="email" value="${merchant.email }"	>
								</div>
								<div class="input-group" >
									Phone : <input type="phone" name="phone" id="phone" value="${merchant.phone}">
								</div>
								<div class="input-group" >
									Type : <select id="role" name="role">
										<option value="ROLE_USER">User</option>
										<option value="ROLE_OWNER">Owner</option>
									</select>
								</div>

						<input type="submit" value="Save"
							class="signup-button font-size-16 font-type white-text">

					</form:form>
					</center>

		</div>
	</div>
</body>
	<script type="text/javascript">
		function validateEmail(sEmail) {
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			if (filter.test(sEmail)) {
				return true;
			} else {
				return false;
			}
		}
		jQuery(function() {
			jQuery("#email")
					.validate(
							{
								expression : "if(VAL=='' || validateEmail(VAL)) return true; else {return false;}",
								message : "Please Enter the valid email address."
							});
			
			jQuery("#phone")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length == 11 && jQuery.isNumeric(VAL)  ) return true; else {$('div#uploading').hide(); return false;}",
								message : "Contact number should be of 11 numeric digits"
							})
			});
		</script>
</html>