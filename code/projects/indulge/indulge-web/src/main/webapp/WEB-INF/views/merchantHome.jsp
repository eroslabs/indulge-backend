<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
	<div style="text-align: center;">
	<h2>Welcome to merchant app</h2>
	Name  : <strong>${merchant.name}</strong>
	<br/>Pending Task ( Attract more users): <c:if test="${not merchant.profileComplete}"><a href="inputLocation"> Complete Profile</a></c:if>
	<div style="clear:both;"/>
	</div>
<jsp:include page="../views/footer.jsp" />

</body>
</html>