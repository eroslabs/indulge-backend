<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
<body>
	
	<jsp:include page="../views/merchantHeader.jsp" />
	<div class="lh20">&nbsp;</div>
	<div class="container">
		<!-- Nav tabs -->
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 formRightBody">
		<center><h2>Reviews</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
	
		<c:if test="${reviews.userReviews ne null and  not empty reviews.userReviews}">
				<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12" style="padding:0px;">
					<c:forEach var="review" items="${reviews.userReviews}" varStatus="status">
							id :: ${review.id} User Name :: ${review.user }   Rating :: ${review.rating } Review Text :: ${review.text }<br/>
					</c:forEach>	
				</div>
			</c:if>
		
	</div>
	</div>
	
</body>
</html>