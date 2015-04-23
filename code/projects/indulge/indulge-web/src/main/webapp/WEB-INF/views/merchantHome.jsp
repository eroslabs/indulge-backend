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
                   <li><a href="${pageContext.servletContext.contextPath }/merchant/reviews">Stats</a></li>
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
  		<div class="container-fluid">
  			<center>
  			<div class="col-xs-5" style="font:14px; padding-left:0px; padding-right:0px">Stats</div>
  			<div class="col-xs-5 act" style="font:14px; padding-left:0px; padding-right:0px">Basic Info</div>
  			<div class="col-xs-4" style="font:14px;padding-left:0px; padding-right:0px">Services</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Deals</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Account</div>
  			</center>
  		</div>
	</nav>
	<div class="container">
		<div class="row" style="text-align: center;">
			<h2>Welcome to merchant app</h2>
			Name  : <strong>${merchant.name}</strong>
			<br/>Pending Task ( Attract more users): <c:if test="${not merchant.profileComplete}"><a href="inputLocation"> Complete Profile</a></c:if>
			<div style="clear:both;"/>
		</div>
	</div>
<jsp:include page="../views/footer.jsp" />

</body>
</html>