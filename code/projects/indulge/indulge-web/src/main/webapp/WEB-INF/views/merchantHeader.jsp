<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Indulge Vendor Admin Panel</title>

    <link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" >
    <link href="${pageContext.servletContext.contextPath }/css/custom.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    
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
<div >
	      <div style="float:left;">
	        <a  href="${pageContext.servletContext.contextPath }/merchant/home">
	            <img src="${pageContext.servletContext.contextPath }/images/logo.png" style="" class="img-responsive" alt="Indulge" />
	            
	        </a>
	         
	      </div>
	      <div style="float:right;">
	      <sec:authorize var="loggedIn" access="isAuthenticated()" />
		  <c:if test="${not empty loggedIn and  loggedIn}">
		      	Hi, <sec:authentication property="name"/>&nbsp;&nbsp;&nbsp;
		      		<a style="margin-right:20px;" href="${pageContext.servletContext.contextPath }/j_spring_security_logout">Logout</a>&nbsp;&nbsp;&nbsp;
	      </c:if>
		 </div>
		 <a href="${pageContext.servletContext.contextPath }/merchant/home">home</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/reviews">See Reviews</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/listDeals">See Your Deals</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/inputDeal">Enter Deal</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu">Enter Digi Menu</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/inputServices">Enter Services</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		 <a href="${pageContext.servletContext.contextPath }/merchant/listDealRequests">Deals Request</a>
	<div style="clear:both;"/>
</div>

</body>
</html>