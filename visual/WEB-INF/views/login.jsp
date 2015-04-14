<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    	<meta charset="utf-8"/>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1"/>
    	<title>Indulge Merchant Log In</title>
 
		<link rel="shortcut icon" href="${pageContext.servletContext.contextPath }/images/favicon.png"/>
		<link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    	
    	<!-- Bootstrap -->
    	<link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" />
    	<link href="${pageContext.servletContext.contextPath }/css/custom.css?s=1" rel="stylesheet" />

    	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    	<script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    	<!-- Include all compiled plugins (below), or include individual files as needed -->
    	<script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    	<style type="text/css">
    		.form-signin{ margin:50px auto 0px; max-width:330px; padding:15px;}
    	</style>
</head>
 
<body>
 <jsp:include page="../views/merchantHeader.jsp" />
 
<div class="container">
	
  <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
  	  <div class="lh20">&nbsp;</div>
      <div class="alert alert-danger">Your login attempt was not successful due to <b><c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/></b>.</div>
  </c:if>
  <form class="form-signin" name='form' action='${pageContext.servletContext.contextPath }/j_spring_security_check' method='POST'>
    <h2 class="form-signin-heading">Seller Panel Log In</h2>
    <label class="sr-only">Email address</label>
    <input type="email" autofocus="" required="" placeholder="Email address" class="form-control" name='j_username' value='' >
    <div class="lh10">&nbsp;</div>
    <label class="sr-only">Password</label>
    <input type="password" required="" placeholder="Password" class="form-control" name='j_password'>
    <div class="lh10">&nbsp;</div> 
    <button type="submit" class="btn btn-lg btn-primary btn-block" name="submit">Sign in</button>
  </form>
  <a href="/indulge/register/input" > Register, If not already</a><br/><br/>
</div> 
<jsp:include page="../views/footer.jsp" />

</body>
</html>