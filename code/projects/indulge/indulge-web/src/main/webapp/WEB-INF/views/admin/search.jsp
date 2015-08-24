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


</head>
<style type="text/css">
.table {
	font-size: 12px;
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
								<form:form method="POST" action="searchMerchant"
						 class="form-horizontal white-bg"
						id="searchMerchantForm" style="width:60%;text-align:left;padding:15px; border:1px solid;">
						<div style="width: 70%" class="registration-page">
							<center>
								<div class="input-group" >
									Name: <input id="name"  type="text" name="name"	>
									City : <input type="text" name="city" id="city"
										 list="browser" >
									<datalist id="browser">
										<c:forEach var="state" items="${states}" varStatus="status">
											<c:forEach var="city" items="${state.cities}"
												varStatus="stat">
												<div id="row">
													<option value="${city.cityName}">${city.cityName}</option>
												</div>
											</c:forEach>
										</c:forEach>
									</datalist>	
								</div>

								<div class="input-group">
									Locality : <input type="text" name="locality"
										id="locality" >
									Type : <select id="merchantType" name="merchantType">
										<option value="0">Merchant</option>
										<option value="1">Individual</option>
									</select>
								</div>


								<div class="input-group">
									Email : <input id="email" name="email" type="text">
									Phone :<input id="phone" name="phone" type="text">
								</div>

						<input type="submit" value="Search Merchant"
							class="signup-button font-size-16 font-type white-text">

					</form:form>
					</center>

		</div>
	</div>
</body>
</html>