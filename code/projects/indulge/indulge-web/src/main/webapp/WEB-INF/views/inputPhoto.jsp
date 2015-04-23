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
  </head>
<body style="background-color:#f0f0f0">
	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
				
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">Ensure that clients can get easily in touch</div>
	    		<ol class="progress-meter">
	    			<li class="progress-point done">Basic</li><li class="progress-point done">Address</li><li class="progress-point done">Contacts</li><li class="progress-point done">Schedule</li><li class="progress-point todo">Photos</li>
	    		</ol>
	    		<form:form method="POST" action="saveMerchantBasicProfile" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px;margin-bottom:15px;padding-bottom:30px">
		    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Add photos
			    	</div>
			    	<div class="row row15">
			    		<div class="col-md-7 col-lg-7 col-sm-12 col-xs-24">
				    		<div class="row" style="height:150px;width:150px; margin-top:15px">
			    				<div id="file-upload-cont">
							    	<input id="file" type="file"/>
							    	<div id="my-button"></div>
							    	<input id="overlay"/>
								</div>
			    			</div><br>
			    		</div>
			    		<c:if test="${merchant.images ne null and  not empty merchant.images}">
								<c:forEach var="banner" items="${merchant.images}" varStatus="status">
									<div class="col-md-7 col-lg-7 col-sm-12 col-xs-24">
										image Path :${banner.image}
									</div>
								</c:forEach>
						</c:if>
			    	</div>
					<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type">
					<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22" style="text-align:right">        
						<a class="font-size-16 font-type" href="login"><u>Skip this step<u></a>
					</div>
	    		</form:form>
	  		</div>
	  	</center>
	  	</div>
	</div>
	
</body>
</html>