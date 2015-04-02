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
		<center><h2>Fill Up your Schedule</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		<c:if test="${not empty success_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${success_message}</div>
		</c:if>
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveSchedule" modelAttribute="schedule" class="form-horizontal" id="saveScheduleForm" >
			<div class="resourceListBlock resourceListHeading">
			<input type="hidden"name="id" id="id">
				<div class="form-group">
				    <label class="col-sm-3 control-label">Opening Time*</label>
				    <div class="col-sm-7">
				      <input id="openingTime" class="form-control" type="text" name="openingTime" value="${schedule.openingTime}">
				    </div>
				  </div>
				
				<div class="form-group">
				    <label class="col-sm-3 control-label">Closing Time*</label>
				    <div class="col-sm-7">
				      <input id="closingTime" class="form-control" type="text" name="closingTime" value="${schedule.closingTime}">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Week Schedule*</label>
				    <div class="col-sm-7">
				      <input id="weekSchedule" class="form-control" type="text" name="weekSchedule" value="${schedule.weekSchedule}">
				    </div>
				  </div>
				 
				
				  <div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Save" class="btn btn-primary" />
				    </div>
				  </div>   
			</div>
		</form:form>
		<a href="inputPhoto">Skip</a>
	</div>
	</div>

</body>
</html>