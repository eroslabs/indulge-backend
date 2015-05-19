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
	
<nav class="navbar navbar-default navbar-custom navbar-fixed-top nav-top" style="background-color:#735E56">
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
              <li class="active" style="height:50px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/reviews" style="line-height:35px; margin-top:-5px;"><img src="${pageContext.servletContext.contextPath }/images/Stats.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp; Stats</a></li>
              <li><a href="${pageContext.servletContext.contextPath }/merchant/home" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Info-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Basic Info</a></li>
              <li><a href="${pageContext.servletContext.contextPath }/merchant/inputServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Service-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Services</a></li>
              <li><a href="${pageContext.servletContext.contextPath }/merchant/createMerchantServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Deal-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Deals</a></li>
              <li><a href="${pageContext.servletContext.contextPath }/merchant/createMerchantServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Account</a></li>
            </ul>
        </div>
    </div>
  </nav>
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
	
	<div class="lh20">&nbsp;</div>
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
	<div class="container-fluid" style="margin-top:70px">
    <div class="row row15">
      <div class="col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24 midbrownbg-color">
            <div class="col-sm-16" style="padding-bottom:10px">
            <center>
              <h2>${merchant.name}</h2>
              <div class="star-ratings-sprite"><span style="width:${merchant.rating * 20}%" class="rating"></span></div>
            </center>
            </div>
            <div class="col-sm-8" style="text-align:center">
              <div class="col-xs-12">
                <div class="row row15">
                  <c:set var="count" value="0" scope="page" />
                  <c:forEach var="redemption" items="${merchant.deals}" varStatus="status">
                    <c:set var="count" value="${count + redemption.redemption}" scope="page"/>
                  </c:forEach>
                  <h2>${count}</h2>
                </div>
                <div class="row row15 font-size-24">
                  Deal Usage 
                </div>
              </div>
              <div class="col-xs-12">
                <div class="row row15">
                  <h2>${merchant.totalReviews}</h2>
                </div>
                <div class="row row15 font-size-24">
                  Reviews
                </div>
              </div>
            </div>
      </div>
    </div>
  </div>
  <div class="container-fluid" style="margin-top:0px">
    <div class="row row15" style="text-align:center">
      <div class="col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24 white-bg" style="padding:0px">
        <a href="${pageContext.servletContext.contextPath }/merchant/reviews" style="color:black">
          <div class="col-xs-12 font-size-24" style="border:1px solid #735E56"> Reviews</div>
        </a>
        <a href="${pageContext.servletContext.contextPath }/merchant/listDealRequests" style="color:black">
          <div class="col-xs-12 font-size-24 border-bottom" style="border:1px solid #1fbbad; color:#1fbbad; border-bottom:5px solid #1fbbad;">Deal Requests</div>
        </a>
      </div>
    </div>
  </div>
  <div class="container-fluid" style="margin-top:0px">
    <div class="row row15">
      <div class="col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24" style="padding:0px">
        <c:if test="${requests ne null and  not empty requests}">
          <c:forEach var="request" items="${requests}" varStatus="status">
              <c:forEach var="service" items="${request.services}" varStatus="status">
                  <div class="row row15 white-bg" style="padding:20px 20px 10px 20px; border:1px solid #735E56; border-top:0px">
                  ${service.name}<br/>
                  <p style="opacity:0.4; padding:10px 0px 0px 0px">${request.createdDate}</p>
                  </div>
              </c:forEach>
          </c:forEach>  
        </c:if>
      </div>
    </div>
  </div>


	
</body>
</html>