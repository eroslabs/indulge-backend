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
		<center><h2>Upload Images</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		<c:if test="${not empty success_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${success_message}</div>
		</c:if>
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="savePhoto" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" id="uploadMerchantPhoto" >
			<div class="form-group">
				    <label class="col-sm-3 control-label">File</label>
				    <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				<div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Upload" class="btn btn-primary" />
				    </div>
				  </div> 
		</form:form>
		<c:if test="${merchant.images ne null and  not empty merchant.images}">
				<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12" style="padding:0px;">
					<c:forEach var="banner" items="${merchant.images}" varStatus="status">
							image Path :${banner.image}
					</c:forEach>	
				</div>
			</c:if>
		
	</div>
	</div>
	
</body>
</html>