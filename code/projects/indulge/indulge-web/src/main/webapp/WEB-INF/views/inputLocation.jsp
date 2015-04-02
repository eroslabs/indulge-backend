<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
<body>
<div id="uploading" class="loadingBox" style="display:none;">Uploading...</div>
	<jsp:include page="../views/merchantHeader.jsp" />
	<div class="lh20">&nbsp;</div>
	<div class="container">
	<!-- Nav tabs -->
	<jsp:include page="../views/leftMenu.jsp" />
	<div class="col-lg-9 col-md-9 col-sm-7 col-xs-12 formRightBody">	
		<div class="formHeader">Upload a single file</div>
		<p class="ValidationErrors" >${error_message}</p>
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveLocation" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" >
			<div class="resourceListBlock resourceListHeading">
			
				<div class="form-group">
				    <label class="col-sm-3 control-label">Name*</label>
				    <div class="col-sm-7">
				      <input id="name" class="form-control" type="text" name="name" value="${merchant.name}" />
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Lat/Long*</label>
				    <div class="col-sm-7">
				      <input id="lat" class="form-control" type="text" name="lat" value="${merchant.lat}"><input id="lng" class="form-control" type="text" name="lng" value="${merchant.lng}">
				    </div>
				  </div>
				
				<div class="form-group">
				    <label class="col-sm-3 control-label">File</label>
				    <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				<div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Upload" class="btn btn-primary" />
				    </div>
				  </div>          
			</div>
		</form:form>
		<a href="inputAddress">Skip</a>
	</div>
	
	</div>
	
	<script type="text/javascript"><!--
		$(document).ready(function(){
			$('div#uploading').hide();
			$("option.drmFree").bind("click",function(){
				var id = $(this).attr("id");
				$("div.drm").hide();
				$("div."+id).show();
				return true;
			});
			$("form#resource").submit(function(){
				$('div#uploading').show();
			});
		});
		//$("#handle, #title, #originalIds, #publisher, #discount, #downloadUrl").focus(function(){
			//	$(this).prev().hide();
		//	});
		
		jQuery(function(){
			jQuery("#handle").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Handle field can not left blank."
		    });
			jQuery("#title").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Title field can not left blank."
		    });
			jQuery("#originalIds").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "ISBN field can not left blank."
		    });
			jQuery("#publisher").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Title field can not left blank."
		    });
			jQuery("#discount").validate({
		        expression: "if ((jQuery.trim(VAL)).length != 0) return true; else {$('div#uploading').hide(); return false;}",
		        message: "Discount field can not left blank."
		    });
			
			jQuery("#downloadUrl").validate({
		        expression: "if (($('option.drmFree:selected').attr('id') == 'drmFreeYes' && $('div.'+$('option.drmFree:selected').attr('id')).find('input').val().trim().length ==0)) {$('div#uploading').hide(); return false;} else return true;",
		        message: "For DRM Free resource Download URL can not left blank."
		    });
		});
	</script>
</body>
</html>