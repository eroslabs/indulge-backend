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
	<div class="container-fluid" style="background-color:#f0f0f0">
		<div class="row">
		<center>
			<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
				
	    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">Ensure that clients can get easily in touch</div>
	    			<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Searched Merchant List
			    	</div>
			    	

    <table class="table table-bordered">

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
								<td>${mer.status} <c:choose><c:when test="${mer.status}"><a target="_blank" href="${pageContext.servletContext.contextPath }/admin/deactivateMerchant/${mer.id}">Deactivate</a></c:when><c:otherwise><a target="_blank" href="${pageContext.servletContext.contextPath }/admin/activateMerchant/${mer.id}">Activate</a></c:otherwise></c:choose></td>
						</tr>
					</c:forEach>
					
            					
					</tbody>
					</table>
					</div>
	  		</div>
	  	</center>
	  	</div>
	</div>
</body>
</html>