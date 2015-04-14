<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Indulge</title>

	<link href='http://fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
    <!-- Bootstrap -->
    <link href="${pageContext.servletContext.contextPath }/css/bootstrap.min.css" rel="stylesheet" />
    	<link href="${pageContext.servletContext.contextPath }/css/custom.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
  	<jsp:include page="WEB-INF/views/adminHeader.jsp" />
    <div class="lh20">&nbsp;</div>
    <div class="container">
		<div class="row">
		<div class="col-md-6">
			<img src="${pageContext.servletContext.contextPath }/images/pozo.jpg" class="float-left" />
		</div>
		<div class="col-md-6">
			<h3 class="mll">Oops,</h3>
			<h3 class="mll">Some error occurred.</h3>
			<p class="mll">Please try after some time.</p>
			<c:forEach items="${exception.stackTrace}" var="element">
    <c:out value="${element}"/>
</c:forEach>
		</div>
		</div>
    </div>
      
	  <div class="lh40">&nbsp;</div>
     <footer class="footer align-center">
      <div class="container">
        <p class="text-muted">&copy; 2015 eros.co all right are reserved.</p>
      </div>
	 </footer>
    
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>