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
				<h3>Showing merchants found</h3>
				<a href="home">Back to home</a>
			</center>
		</div>
		<form method="post" id="adminForm">
			<input type="button"
				class="signup-button font-size-16 font-type white-text"
				onclick="setAction(0);" value="Activate All"> <input
				type="button"
				class="signup-button font-size-16 font-type white-text"
				value="Deactivate All" onclick="setAction(1);"> <input
				type="button"
				class="signup-button font-size-16 font-type white-text"
				onclick="setAction(2);" value="Update Lat/Lng"> <input
				type="button"
				class="signup-button font-size-16 font-type white-text"
				onclick="setAction(3);" value="Update Luxury Rating">
			<c:set var="count" value="0" scope="page" />
			<c:if
				test="${result != null and results.total != null and result.total > 0}">
				<span style="float: right;">Page :<select id="selectPaginate"
					onchange="selectCurSort();">
						<c:forEach var="page" begin="50" step="50" end="${result.total}"
							varStatus="status">
							<option value="s=<%=request.getParameter("s") %>&page=${count}">${status.index}</option>
							<c:set var="count" value="${count +1 }" scope="page" />
						</c:forEach>

				</select></span>
			</c:if>
			<input type="hidden" name="rating" id="rating">
			<table class="table table-bordered ">

				<thead>

					<tr>
						<th>Select</th>
						<th>Id</th>
						<th>Email</th>
						<th>Name</th>
						<th>Merchant Type</th>
						<th>Lat/Lng</th>
						<th>Phone</th>
						<th>image</th>
						<th>Address</th>
						<th>Review Count</th>
						<th>Rating</th>
						<th>Status</th>
						<th>action</th>
						<th>View</th>
						<th>update Lat/Lng</th>
					</tr>

				</thead>

				<tbody>


					<c:choose>
						<c:when test="${result != null}">
							<c:forEach var="mer" items="${result.response}"
								varStatus="status">
								<tr>
									<td><input type="checkbox" name="id" value="${mer.id}" /></td>
									<td>${mer.id}</td>
									<td>${mer.email}</td>
									<td>${mer.name}</td>
									<td><c:if test="${mer.merchantType == 0 }">Parlor</c:if> <c:if
											test="${mer.merchantType == 1 }">Individual</c:if></td>
									<td>${mer.lat}/${mer.lng}</td>
									<td>${mer.phone}</td>
									<td><a href="http://justindulge.in/images/${mer.image}"
										target="_blank">link</a></td>
									<td>${mer.address}</td>
									<td>${mer.totalReviews}</td>
									<td>${mer.rating}</td>
									<td><c:choose>
											<c:when test="${mer.status}">Active</c:when>
											<c:otherwise>Inactive</c:otherwise>
										</c:choose></td>
									<td><a onclick="window.location.reload();" target="_blank"
										href="${pageContext.servletContext.contextPath }/admin/deactivateMerchant?id=${mer.id}">Deactivate</a>
										/<a target="_blank" onclick="window.location.reload();"
										href="${pageContext.servletContext.contextPath }/admin/activateMerchant?id=${mer.id}">Activate</a>
										/<a target="_blank" onclick="window.location.reload();"
										href="${pageContext.servletContext.contextPath }/admin/refreshMerchant?id=${mer.id}">Activate</a></td>
									<td><a target="_blank"
										href="${pageContext.servletContext.contextPath }/merchant/homeFromAdmin?id=${mer.id}">view</a></td>
									<td><a target="_blank"
										href="${pageContext.servletContext.contextPath }/admin/fetchLatLong?id=${mer.id}">update
											Lat/Lng</a></td>
								</tr>
							</c:forEach>
				</tbody>
			</table>
			</c:when>
			<c:otherwise>
						No Merchant found.
					</c:otherwise>
			</c:choose>
		</form>
	</div>
</body>
<script type="text/javascript">
	function setAction(act) {
		if (act == 0) {
			document.getElementById('adminForm').action = "activateMerchant";
		} else if (act == 1) {
			document.getElementById('adminForm').action = "deactivateMerchant";
		} else if (act == 2) {
			document.getElementById('adminForm').action = "fetchLatLong";
		} else if (act == 3) {
			var rating = prompt("Please enter rating to be assigned", "3");
			if (rating) {
				document.getElementById('rating').value = rating;
				document.getElementById('adminForm').action = "setLuxuryRating";
			} else {
				return;
			}
		}

		document.forms["adminForm"].submit();

	}
	function selectCurSort() {
		var match = window.location.href.split('?')[0];
		var parm = $("#selectPaginate option:selected").val();
		window.location = match + "?" + parm;
	}
</script>
</html>