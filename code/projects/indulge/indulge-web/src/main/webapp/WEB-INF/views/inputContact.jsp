<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		<center><h2>Enter Additional Contact Numbers</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		<c:if test="${not empty success_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${success_message}</div>
		</c:if>
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveContact" modelAttribute="merchant" class="form-horizontal" id="creatMerchantForm" >
			<div class="resourceListBlock resourceListHeading">
			<c:if test="${merchant.phones ne null and  not empty merchant.phones}">
					<c:forEach var="phoneItem" items="${merchant.phones}" varStatus="status">
							<div class="form-group">
				    <label class="col-sm-3 control-label">Phone ${status.index+1 }*</label>
				    <div class="col-sm-7">
				      <input id="phone1" class="form-control" type="text" name="phone${status.index+1 }" value=${phoneItem.phone }>
				    </div>
				  </div>
					</c:forEach>	
			</c:if>
			<c:if test="${merchant.phones == null or  empty merchant.phones}">
				<div class="form-group">
				    <label class="col-sm-3 control-label">Phone 1*</label>
				    <div class="col-sm-7">
				      <input id="phone1" class="form-control" type="text" name="phone1">
				    </div>
				  </div>
				</c:if>
				<c:if test="${merchant.phones == null or  empty merchant.phones or fn:length(merchant.phones) ==1 }">
				<div class="form-group">
				    <label class="col-sm-3 control-label">Phone 2*</label>
				    <div class="col-sm-7">
				      <input id="phone2" class="form-control" type="text" name="phone2">
				    </div>
				  </div>
				  </c:if>
				  <c:if test="${merchant.phones == null or  empty merchant.phones or fn:length(merchant.phones) ==2 }">
				<div class="form-group">
				    <label class="col-sm-3 control-label">Phone 3*</label>
				    <div class="col-sm-7">
				      <input id="phone3" class="form-control" type="text" name="phone3">
				    </div>
				  </div>
				</c:if> 
				<div class="form-group">
				    <label class="col-sm-3 control-label">Software</label>
				    <div class="col-sm-7">
				      <input id="software" class="form-control" type="text" name="software" value="${merchant.software}">
				    </div>
				  </div>
				
				  <div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Save" class="btn btn-primary" />
				    </div>
				  </div>   
			</div>
		</form:form>
		<a href="inputSchedule">Skip</a>
	</div>
	</div>
	
</body>
</html>