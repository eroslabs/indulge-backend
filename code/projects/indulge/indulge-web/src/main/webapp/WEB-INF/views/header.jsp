<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<meta charset="utf-8"/>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1"/>
    	<title>Indulge</title>
 
		<link rel="shortcut icon" href="${pageContext.servletContext.contextPath }/images/favicon.png"/>
		<link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    	
    	<!-- Bootstrap -->
    	<link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" />
    	<link href="${pageContext.servletContext.contextPath }/css/font-awesome.min.css" rel="stylesheet" />
    	<c:if test="${sessionScope['CATEGORY_SESSION_ATTRIBUTE'] ne null}">
        	<link href="${pageContext.servletContext.contextPath }/css/custom_${sessionScope['CATEGORY_SESSION_ATTRIBUTE']}.css?s=1" rel="stylesheet" />
        	<style>
        		
        	</style>
		</c:if>

    	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    	<script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    	<!-- Include all compiled plugins (below), or include individual files as needed -->
    	<script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
		<script src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>
    	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    	<!--[if lt IE 9]>
      	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    	<![endif]-->
    	
		
  	</head>
  	<body>
  
	<div class="">
	
      		
      		<!-- New Header Body Start from here -->
      		<div class="headerWrapper">
      			<ul>
      				
      				
      				<li class="searchLi">
	               		<form action="${pageContext.servletContext.contextPath }/search" method="get" id="searchSubmit" class="searchBox">
	               			<c:choose>
	               				<c:when test='${param["keyword"] ne null and param["keyword"] ne ""}'>
	               					<input type="text" value='${param["keyword"]}' id="searchBox" placeholder="Let's find you an ebook" name="keyword" '/>
	               				</c:when>
	               				<c:otherwise>
	                				<input type="text" value="" id="searchBox" placeholder="find your deals"  name="keyword" />
	               				</c:otherwise>
	               			</c:choose>
	               			<span class="fa fa-search" id="searchButton" style="cursor:pointer;"></span>
	               		</form>
	               		
      				</li>
      			</ul>
      		</div>
      		<!-- / New Header Body Start from here -->
      		
	</div> 


