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
	<form:form action="saveDeal" method="post" id="createDealForm" modelAttribute="deal" >
		<c:if test="${categories ne null and not empty categories}">
				<div id="container">
					<c:forEach var="category" items="${categories}" varStatus="status">
					<div id="row">
					<div id="middle">
							<strong>Category Name : ${category.name}</strong>
					</div>
					</div>		
							<c:forEach var="catService" items="${category.services}" varStatus="serviceStatus">
								
				    <div id="row"><div id="left"><input type="checkbox" name="selection" value="${catService.id}">${catService.name}
							</div>
				  </div>
							</c:forEach>
							
					</c:forEach>	
				</div>
			</c:if>
			<div class="form-group">
				    <label class="col-sm-3 control-label">Description*</label>
				    <div class="col-sm-7">
				      <input id="description" class="form-control" type="text" name="description" value="${deal.description}">
				    </div>
				  </div>
			<div class="form-group">
				    <label class="col-sm-3 control-label">Valid From*</label>
				    <div class="col-sm-7">
				      <input id="validFrom" class="form-control" type="text" name="validFrom" value="${deal.validFrom}">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Valid Till*</label>
				    <div class="col-sm-7">
				      <input id="validTill" class="form-control" type="text" name="validTill" value="${deal.validTill}">
				    </div>
				  </div>
				 <div class="form-group">
				    <label class="col-sm-3 control-label">Flat Off*</label>
				    <div class="col-sm-7">
				      <input id="flatOff" class="form-control" type="text" name="flatOff" value="${deal.flatOff}">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Percent Off*</label>
				    <div class="col-sm-7">
				      <input id="percentOff" class="form-control" type="text" name="percentOff" value="${deal.percentOff}">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-3 control-label">Days*</label>
				    <div class="col-sm-7">
				      <input id="days" class="form-control" type="text" name="days" value="${deal.days}">
				    </div>
				  </div>
				
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