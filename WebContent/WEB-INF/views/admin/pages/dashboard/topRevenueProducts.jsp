<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- ========== Meta Tags ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>

        <!-- ========== Favicon linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/favicon.jsp"%>

        <!-- ========== All CSS files linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/styles.jsp"%>
    </head>

    <body>
        <%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

        <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder" />
        <c:url value="${pagedLink }" var="pagedLink">
            <c:param name="p" value="~" />
        </c:url>

        <main class="content">
            <%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center py-4">
                <div class="d-block mb-4 mb-md-0">
                    <a href="${applicationScope.dashboardPage }" class="btn btn-gray-200">
	                    <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
	                    Quay lại
                    </a>
                </div>
            </div>

            
            <!-- <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden"> -->
                <div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <div class=" h2 fs-5 fw-bold mb-0 text-gray-800 d-flex align-items-center">
        <svg class="icon me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path></svg>
        	<span>${title }</span>
        
        </div>
    </div>
    <div class="card-body">
    	<div class="table-responsive" >
        <table class="table align-items-center table-flush" style="table-layout: fixed">
            <thead class="thead-light">
                <tr>
                	<th class="border-bottom rounded-start" scope="col">Xếp hạng</th>
                    <th class="border-bottom" scope="col" colspan="3">Sản phẩm</th>
                    <th class="border-bottom" scope="col">Tháng này</th>
                    <th class="border-bottom" scope="col">So với tháng trước</th>
                    <th class="border-bottom rounded-end" scope="col">Tổng</th>
                </tr>
            </thead>
            <tbody>
             <c:if test="${pagedListHolder.pageList.isEmpty()}">
            	<tr>
            	<td class="fw-bolder text-gray-500" rowspan="0">Chưa có sản phẩm nào</td>
                </tr>
            </c:if>
            
            <c:if test="${!pagedListHolder.pageList.isEmpty()}"> 
            
            <c:forEach items="${pagedListHolder.pageList}" var="product" varStatus="i">
            	<tr>
            		<td class="text-gray-900">
                        <c:set var="index" value="${(pagedListHolder.page) * pagedListHolder.pageSize + i.count}"></c:set>
                            <h3 class="my-0 ${index == 1 ? 'text-danger' : index == 2 ? 'text-secondary' : index == 3 ? 'text-tertiary' : 'text-gray-400' }">
                            	${index}
                            </h3>
                    </td>
                    <th class="text-gray-900 text-truncate" scope="row" colspan="3">
                    	<a href="${applicationScope.productPage }/${product.getProduct().id}">
                        	${product.getProduct().name }
                        </a>
                    </th>
                    <td class="fw-bolder text-gray-500">
                    	<fmt:setLocale value="vi_VN" scope="session" />
<%--                         <fmt:formatNumber value="${product[0].getGrossRevenueInOrdersOfThisMonth(product[0].id) }" type="currency" /> --%>
                        <fmt:formatNumber value="${product.thisMonthRevenue }" type="currency" />
                    </td>
                    <td class="fw-bolder text-gray-500">
                    	<span class="d-flex align-items-center">
                    	<c:set var="bounceRate" value="${product.growthRatePercentage}"></c:set>
                    	<c:if test="${bounceRate > 0}">
                    		<svg class="icon icon-xs text-success me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7l4-4m0 0l4 4m-4-4v18"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${bounceRate}" type="number" />%
                    	</c:if>
                    	
                    	<c:if test="${bounceRate < 0}">
                    		<svg class="icon icon-xs text-danger me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 17l-4 4m0 0l-4-4m4 4V3"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${-bounceRate}" type="number" />%
                    	</c:if>
                    	
                    	<c:if test="${bounceRate == 0}">
                    		<svg class="icon icon-xs text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${bounceRate}" type="number" />%
                    		
                    	</c:if>
                    	</span>
                    </td>
                    <td class="fw-bolder text-gray-500">
                    	<fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${product.allTimeRevenue}" type="currency" />
                    </td>
                    <%-- <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                            <!-- <svg class="icon icon-xs text-danger me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M5.293 7.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 5.414V17a1 1 0 11-2 0V5.414L6.707 7.707a1 1 0 01-1.414 0z" clip-rule="evenodd"></path>
                            </svg> -->
                            ${product.getTotalRevenueInOrders(product.id)}
                        </div>
                    </td> --%>
                </tr>
            </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>
    <div>
      <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
  </div>
</div>
</div>
            <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
        </main>

        <!-- ========== All JS files linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
    </body>
</html>
