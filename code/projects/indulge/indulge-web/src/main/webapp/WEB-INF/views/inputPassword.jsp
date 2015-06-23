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
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
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
<div class="container-fluid body-bg">
<div class="container-fluid" id="header">
      <div class="row row15">
        <div class="col-xs-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/howitwork.html">How it Works</a></div>
        <div class="col-xs-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/benefits.html">Benefits</a></div>
        <div class="col-xs-2 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/pricing.html">Pricing</a></div>
        <div class="col-xs-8 header-image">
          <center>
          <a  href="#">
                <img src="${pageContext.servletContext.contextPath }/images/erosimg/logo1.png" style="height:50px" class="img-responsive" alt="Indulge"/></a></center>
            </div>
        <div class="col-sm-2 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/faq.html">FAQ's</a></div>
			<div class="col-sm-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/merchant/login">Login</a></div>
			<div class="col-sm-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/register/input">Join Us</a></div>
      </div>
      </div>
	<div class="row">
	<center>
		<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
    		<div class="row font-type sign-up font-size-24 location-header">Enter New Password</div>
    		
    		<form:form method="POST" action="changePassword" modelAttribute="merchant" class="form-horizontal " style="margin-bottom:20px; margin-top:20px" >
    			<div class="form-group">
                <label class="sr-only">Email address / Registered Phone</label>
                <input type="text" autofocus="" required="" readonly="readonly" placeholder="Email or Phone no." class="form-control sign-in-username sign-in-place font-size-20" name='identifier' value='${identifier }' >
                <input type="hidden" name='requestId' value='${requestId}' >
              </div>
              <div class="form-group">
                <label class="sr-only">Password</label>
                <input type="password" autofocus="" required="" placeholder="Password" class="form-control sign-in-username sign-in-place font-size-20" name='passphrase' value='' >
              </div>
              <br/>
              <button type="submit" class="btn btn-lg btn-primary btn-block btn-login" name="submit">Submit</button>
              
	    		  			</form:form>
  		</div>
  	</center>
  	</div>
</div>
	
	</body>
</html>
