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
		
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveDigitalMenu" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" id="uploadMerchantPhoto" >
			<div class="form-group">
				    <label class="col-sm-3 control-label">File</label>
				    <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				  <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				  <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				
		
		
			<div class="form-group">
				    <label class="col-sm-3 control-label">Go To Customer Home*</label>
				    <div class="col-sm-7">
				      <input id="homeService" class="form-control" type="checkbox" name="homeService" >${merchant.homeService}
				    </div>
				  </div>
			<div class="form-group">
				    <label class="col-sm-3 control-label">Service Radius </label>
				    <div class="col-sm-7">
				      <input id="serviceRadius" class="form-control" type="text" name="serviceRadius" value="${merchant.serviceRadius}">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Separate Rate Card</label>
				    <div class="col-sm-7">
				      <input id="separateRateCard" class="form-control" type="checkbox" name="separateRateCard" >
				    </div>
				  </div>
		<div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Save" class="btn btn-primary" />
				    </div>
				  </div> 
	</div>
	</div>
	</form:form>
	
</body>
</html>