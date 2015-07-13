<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="${pageContext.servletContext.contextPath }/css/bootstrap.css"
	rel="stylesheet">

<link
	href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700'
	rel='stylesheet' type='text/css'>
<link
	href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
	src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script
	src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>

<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
<style type="text/css">
.table {
	font-size: 12px;
}

body {
	background-color: #f0f0f0;
}
</style>
</head>

<body>

	<div class="col-xs-22 col-sm-22 col-md-push-1">
		<div class="row row15" style="margin-bottom: 15px">
			<center>
				<h3>Showing Deals</h3>
				<a href="home">Back to home</a>
			</center>
		</div>
		<form method="post" id="adminForm">
			<c:choose>
				<c:when test="${result != null}">
					<table class="table table-bordered">

						<thead>

							<tr>

								<c:forEach var="stats" items="${result.response}"
									varStatus="status" begin="1" end="1">
									<c:forEach var="item" items="${stats}" varStatus="statusItem">
										<th>${item.key}</th>
									</c:forEach>
								</c:forEach>

							</tr>

						</thead>

						<tbody>




							<c:forEach var="stats" items="${result.response}"
								varStatus="status">
								<tr>
									<c:forEach var="item" items="${stats}" varStatus="statusItem">
										<td style="max-width: 30px; word-wrap: break-word;"><c:choose><c:when test="${item.key == 'Id' }"><a href="${pageContext.servletContext.contextPath }/merchant/homeFromAdmin?id=${item.value}" >${item.value}</a></c:when><c:otherwise>${item.value}</c:otherwise></c:choose></td></td>
									</c:forEach>
								</tr>
							</c:forEach>


						</tbody>
					</table>

				</c:when>
				<c:otherwise>
						No Deals found.
					</c:otherwise>
			</c:choose>
		</form>
	</div>
</body>
<script type="text/javascript">
	function selectCurSort() {
		var match = window.location.href.split('?')[0];
		var parm = $("#selectPaginate option:selected").val();
		window.location = match + "?" + parm;
	}
</script>
</html>