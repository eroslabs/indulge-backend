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
    
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
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
			    			Basic Merchant Statistics (<a href="${pageContext.servletContext.contextPath }/admin/listDeactiveMerchants">View Pending Activations</a>)
			    	</div>
			    	<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Load All Merchants ( <a href="${pageContext.servletContext.contextPath }/admin/loadMeta">Load All</a>)
			    	</div>
 		<form:form method="GET" action="searchMerchant" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px; margin-bottom:15px;padding-bottom:30px">
		    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px">
			    			Search Merchant 
			    	</div>
			    	<input id="s" class="form-control signup-field" type="text" name="s" placeholder="Merchant email, name, address,city" >
			    	
					<input type="submit" value="Search" class="signup-button font-size-16 font-type"/>
	    		</form:form>

    <table class="table table-bordered">

        <thead>

            <tr>

                <c:forEach var="stats" items="${merchant_stats}" varStatus="status" begin="1" end="1">
				    	<c:forEach var="item" items="${stats}" varStatus="statusItem">
			    				 <th>${item.key}</th>
						</c:forEach>
					</c:forEach>
					
            </tr>

        </thead>

        <tbody>


            

                <c:forEach var="stats" items="${merchant_stats}" varStatus="status">
				    	<tr>
					    	<c:forEach var="item" items="${stats}" varStatus="statusItem">
				    				 <td>${item.value}</td>
							</c:forEach>
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