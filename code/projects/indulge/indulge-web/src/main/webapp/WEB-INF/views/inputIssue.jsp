<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="../views/globalhead.jsp" />
  </head>
<body style="background-color: #f0f0f0;">
<jsp:include page="../views/postmerchantHeader.jsp" />
  <center>
    <div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7 white-bg">
        <div class="row font-size-24 location-header white-text" style="background-color:#1fbbad;">Report an issue</div>
        
        <form:form method="POST" action="saveIssue" modelAttribute="issue" class="form-horizontal col-sm-24" style="margin-bottom:20px; margin-top:20px" >
          <div class="form-group">
                <label class="sr-only">Subject</label>
                 <select id="subject" name="subject" class="form-control signup-field" placeholder="subject">
                  <option value="Category Missing">Category Missing</option>
                  <option value="Technical Error">Technical Error</option>
                  <option value="Customer Support Not Reachable">Customer Support Not Reachable</option>
              </select>
              </div>
              <div class="form-group">
                <label class="sr-only">Details</label>
                <textarea id="details" class="form-control signup-field" name="details" placeholder="Details"  style="resize:none; height:100px; border:1px solid #1fbbad"></textarea>
              </div>
              <input type="hidden" name='merchantId' value='${merchant.id }' >
              
              <br/>
              <div class="col-sm-24">
              <button type="submit" class="btn btn-lg btn-primary btn-block btn-login" name="submit">Submit</button>
              </div>
                  </form:form>
      </div>
    </center>
	
	</body>
</html>