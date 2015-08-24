<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<div class="col-xs-24 col-sm-18 col-md-push-4 " style="border: 1px solid black;text-align:center;padding: 20px">
	    			<div class="row row15 font-size-12" >
	    			<div class="col-md-2"><a class="signup-button font-size-16 font-type" href="${pageContext.servletContext.contextPath }/admin/home">Home</a></div>
	    			<div class="col-md-2"><a class="signup-button font-size-16 font-type" href="${pageContext.servletContext.contextPath }/admin/listDeactiveMerchants">Pending Activations</a></div>
	    			<div class="col-md-3"><a  href="${pageContext.servletContext.contextPath }/admin/loadMeta">Refresh Cache</a></div>
	    			<div class="col-md-2"><a  href="${pageContext.servletContext.contextPath }/admin/listErrors">Errors</a></div>
	    			<div class="col-md-3"><a  href="${pageContext.servletContext.contextPath }/admin/redemption">Redemption Status</a></div>
	    			<div class="col-md-2"><a  href="${pageContext.servletContext.contextPath }/admin/listDeals">Deals</a></div>
	    			<div class="col-md-2"><a  href="${pageContext.servletContext.contextPath }/admin/search">Search Merchant</a></div>
</div>
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
