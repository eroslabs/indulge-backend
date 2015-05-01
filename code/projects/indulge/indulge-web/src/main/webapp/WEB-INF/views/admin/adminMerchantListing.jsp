<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" >
    <link href="${pageContext.servletContext.contextPath }/css/custom.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>

    <script>
	$(window).load(function(){
    	$("ol.progtrckr").each(function(){
        	$(this).attr("data-progtrckr-steps", 
                $(this).children("li").length);
    		});
		})
	</script>
	<link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
	
  </head>

<body>
		<center><h2>Searched Merchant List</h2></center>
			    	

    <table class="table table-bordered" style="width:80%;margin:0 auto;">

        <thead>

            <tr>

			    				 <th>Id</th>
			    				 <th>Email</th>
								<th>Name</th>
								<th>Merchant Type</th>
								<th>City</th>
								<th>Phone</th>
								<th>image</th>
								<th>Address</th>
								<th>Review Count</th>
								<th>Rating</th>
								<th>active (activate /Deactivate)</th>
								<th>view</th>	
            </tr>

        </thead>

        <tbody>


            

                <c:forEach var="mer" items="${result}" varStatus="status">
				    	<tr>
				    				 <td>${mer.id}</td>
				    				 <td>${mer.email}</td>
								<td>${mer.name}</td>
								<td><c:if test="${mer.merchantType == 0 }">Parlour</c:if><c:if test="${mer.merchantType == 1 }">Individual</c:if></td>
								<td>${mer.city}</td>
								<td>${mer.phone}</td>
								<td>${mer.image}</td>
								<td>${mer.address}</td>
								<td>${mer.totalReviews}</td>
								<td>${mer.rating}</td>
								<td>${mer.status} <c:choose><c:when test="${mer.status}"><a onclick="window.location.reload();" target="_blank" href="${pageContext.servletContext.contextPath }/admin/deactivateMerchant/${mer.id}">Deactivate</a></c:when><c:otherwise><a target="_blank" onclick="window.location.reload();" href="${pageContext.servletContext.contextPath }/admin/activateMerchant/${mer.id}">Activate</a></c:otherwise></c:choose></td>
								<td><a target="_blank" href="${pageContext.servletContext.contextPath }/merchant/homeFromAdmin?id=${mer.id}">view</a></td>
								<td><a target="_blank" href="${pageContext.servletContext.contextPath }/admin/fetchLatLong?id=${mer.id}">update Lat/Lng</a></td>
						</tr>
					</c:forEach>
					
            					
					</tbody>
					</table>
					</div>
	  		</div>
</body>
</html>