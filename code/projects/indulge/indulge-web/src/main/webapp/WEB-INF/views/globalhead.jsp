<meta charset="utf-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<% response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
 <link href="${pageContext.servletContext.contextPath }/css/bootstrap.min.css" rel="stylesheet" >

<link href='http://fonts.googleapis.com/css?family=Raleway:400,500,500,200,600,500' rel='stylesheet' type='text/css'>
<link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
<link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.servletContext.contextPath }/js/jquery.validate-min.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->