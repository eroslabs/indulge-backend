<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../views/globalhead.jsp" />

<style type="text/css">
.header-info {
	inherit: .active;
}
</style>
</head>
<body style="background-color: #f0f0f0">

	<div class="lh20">&nbsp;</div>
	<div class="container" >
		<!-- Nav tabs -->
		<div class="row row5" style="margin-bottom:20px;">
				<span><h3>Welcome to Indulge. Login to any of your Salons.</h3> <a href="${pageContext.servletContext.contextPath }/merchant/inputIssue" class="brown-text;font-size:10px; " >Report if these doesnt belong to you.</a></span> 
		</div>

		
		<div class="row row10" style="margin-bottom:20px;">
			<div class="col-lg-4"><strong>Name</strong></div>
			<div class="col-lg-4"><strong>Locality</strong></div>
			<div class="col-lg-4"><strong>Address</strong></div>
			<div class="col-lg-4"><strong>Select</strong></div>
        </div> 
       <c:forEach var="merchant" items="${merchant_chain}" varStatus="status">
		<div class="row row15" style="margin-bottom:20px;">
		<form action="homeFromAdmin" method="post">
			<input type="hidden" name ="id" value="${merchant.id }"/>
			<div class="col-lg-4">${merchant.name }</div>
			<div class="col-lg-4">${merchant.locality }</div>
			<div class="col-lg-4">${merchant.address }</div>
			<div class="col-lg-4"><input type="submit" 
                        class=" btn-green btn"
                        style="border-radius: 0px; color: white; height: 40px"
                        value="Login Here" ></div>
         </form>
        </div> 
        </c:forEach>
		</div>
	<jsp:include page="../views/includeScript.jsp" />
</body>
</html>
