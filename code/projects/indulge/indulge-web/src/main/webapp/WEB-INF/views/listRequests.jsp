<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="../views/globalhead.jsp" />
  </head>
<body style="background-color:#f0f0f0">
	<jsp:include page="../views/postmerchantHeader.jsp" />
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
	<div class="container-fluid" style="margin-top:10px">
    <div class="row row15">
      <div class="col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24 midbrownbg-color">
            <div class="col-sm-16" style="padding-bottom:10px">
            <center>
              <h3>${merchant.name}</h3>
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
                <div class="row row15 font-size-20">
                  Deal Usage 
                </div>
              </div>
              <div class="col-xs-12">
                <div class="row row15">
                  <h2>${merchant.totalReviews}</h2>
                </div>
                <div class="row row15 font-size-20">
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
          <div class="col-xs-12 font-size-24" style="border:1px solid #735E56;padding: 10px;"> Reviews</div>
        </a>
        <a href="${pageContext.servletContext.contextPath }/merchant/listDealRequests" style="color:black">
          <div class="col-xs-12 font-size-24 border-bottom" style="border:1px solid #1fbbad; color:#1fbbad; border-bottom:5px solid #1fbbad;padding: 10px;">Deal Requests</div>
        </a>
      </div>
    </div>
  </div>
  <div class="container-fluid" style="margin-top:0px">
    <div class="row row15">
      <div class="col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24 font-size-16" style="padding:0px">
        <c:if test="${requests ne null and  not empty requests}">
          <c:forEach var="request" items="${requests}" varStatus="status">
              <c:forEach var="service" items="${request.services}" varStatus="status">
                  <div class="row row15 white-bg" style="padding:20px 20px 10px 20px; border:1px solid #735E56; border-top:0px">
                  ${service.serviceName}<br/>
                  <p style="opacity:0.4; padding:10px 0px 0px 0px">${request.createdDate}</p>
                  </div>
              </c:forEach>
          </c:forEach>  
        </c:if>
      </div>
    </div>
  </div>

  <script>
    $('.header-stats').addClass('active');
  </script>
	
</body>
</html>