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
<body>
		<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
				
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">We make sure that your clients never have to be turned away.</div>

	    		<ol class="progress-meter">
	    			<li class="progress-point done">Basic</li><li class="progress-point done">Address</li><li class="progress-point done">Contacts</li><li class="progress-point todo">Schedule</li><li class="progress-point todo">Photos</li>
	    		</ol>

	    		<form:form method="POST" action="saveMerchantBasicProfile" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px;margin-bottom:15px;padding-bottom:30px">
		    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Enter Availability Details
			    	</div>
		    		<div style="width:70%">
		    			<div class="row row15" style="border-bottom:1px solid #aea190"></div>
	    				<div class="form-group">
		    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		   					<input id="weekSchedule" class="form-control signup-field" type="text" placeholder="Week Schedule" name="weekSchedule" value="${schedule.weekSchedule}">		  				
		   				</div>


			  				<div class="form-group">
			    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
			    				<input id="phone2" placeholder="Phone No(If Applicable)" class="form-control signup-field" type="text" name="phone2">
			  				</div>


			  				<div class="form-group">
			    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
			    				<input id="phone3" placeholder="Phone No(If Applicable)" class="form-control signup-field" type="text" name="phone3">
			  				</div>
			  				<div class="row row15 font-size-16 font-type" style="margin-bottom:15px">
			  					If you already use any appointment management software, let us know so we can do our best to integrate with it and make your life easier. 
			  				</div>
			  				<div class="form-group">
			    				<label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
			    				<input id="software" placeholder="Software(If Applicable" class="form-control signup-field" type="text" name="software" value="${merchant.software}">
			  				</div>
					</div>
					<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type">
					<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22" style="text-align:right">        
						<a class="font-size-16 font-type" href="inputPhoto"><u>Skip this step<u></a>
					</div>
	    		</form:form>
	  		</div>
	  	</center>
	  	</div>
	</div>
	
	</div>


</body>
</html>