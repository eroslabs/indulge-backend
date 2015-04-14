<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
     #container {
    display: table;
    }

  #row  {
    display: table-row;
    }

  #left, #right, #middle {
    display: table-cell;
    }
    
    </style>
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
	<form:form action="saveMerchantServices" method="post" id="createServiceForm" modelAttribute="merchant" >
	
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
		<c:if test="${categories ne null and not empty categories}">
				<div id="container">
					<c:forEach var="category" items="${categories}" varStatus="status">
					<div id="row">
					<div id="middle">
							<strong>Category Name : ${category.name}</strong>
					</div>
					</div>		
							<c:forEach var="catService" items="${category.services}" varStatus="serviceStatus">
								
				    <div id="row"><div id="left"><input type="checkbox" name="selectedId" value="${catService.id}" onclick="$(this).is(':checked') && $('#${catService.id}').removeAttr('disabled') || $('#${catService.id}').attr('disabled','disabled');" />${catService.name}
				    				<div  style="display:hidden;">price : <input id="${catService.id}" type="text" name="selectedPrice" value="" disabled="disabled"></div>
							</div>
				  </div>
							</c:forEach>
							
					</c:forEach>	
				</div>
			</c:if>
		
			
				
				  <div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Post Deal" class="btn btn-primary" />
				    </div>
				  </div>
	</form:form>
	</div>
	</div>
	
</body>
</html>