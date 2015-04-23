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
function loaded()
{
    window.setTimeout(CloseMe, 2500);
}

function CloseMe() 
{
    window.close();
}
</script>
  </head>
<body style="background-color:#f0f0f0" onLoad="loaded()">
	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
		<center><h2>Merchant Status Update</h2></center>
		<c:choose>
		<c:when test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:when>
		<c:otherwise>
			Status of merchant updated success fully .
			(would close automatically in 2 minutes)
		</c:otherwise>
		</c:choose>
		</center>	
	</div>
	</div>
	
</body>
</html>