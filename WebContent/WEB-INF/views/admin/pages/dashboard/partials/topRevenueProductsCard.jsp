<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
    <div class="card-header">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="fs-5 fw-bold mb-0">Top doanh thu sản phẩm trong tháng</h2>
            </div>
            <div class="col text-end">
            	<a href="${applicationScope.dashboardPage}/${applicationScope.topRevenueProductsPage}" class="btn btn-sm btn-gray-200">
            	<span class="d-flex align-items-center">
            		<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
            		<span>Xem tất cả</span>
            	</span>
            	</a>
            </div>
        </div>
    </div>
    <div class="table-responsive" >
        <table class="table align-items-center table-flush" style="table-layout: fixed">
            <thead class="thead-light">
                <tr>
                    <th class="border-bottom" scope="col" colspan="2">Sản phẩm</th>
                    <th class="border-bottom" scope="col">Tháng này</th>
                    <th class="border-bottom" scope="col">So với tháng trước</th>
                    <th class="border-bottom" scope="col">Tổng</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${topRevenueProducts.isEmpty()}">
            	<tr>
            	<td class="fw-bolder text-gray-500" rowspan="0">Chưa có sản phẩm nào</td>
                </tr>
            </c:if>
            
            <c:if test="${!topRevenueProducts.isEmpty()}"> 
            <c:forEach items="${topRevenueProducts}" begin="0" end="4" var="product" varStatus="i">
            	<tr>
                    <th class="text-gray-900 text-truncate" scope="row" colspan="2">
                        <a href="${applicationScope.productPage }/${product.getProduct().id}">
                        	${product.getProduct().name }
                        </a>
                    </th>
                    <td>
                    	<span class="fw-bolder text-gray-500">
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${product.thisMonthRevenue }" type="currency" />
                        </span>
                    </td>
                    <td class="fw-bolder text-gray-500">
                    	<span class="d-flex align-items-center">
                    	<c:set var="bounceRate" value="${product.growthRatePercentage}"></c:set>
                    	<c:if test="${bounceRate > 0}">
                    		<svg class="icon icon-xs text-success me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7l4-4m0 0l4 4m-4-4v18"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${bounceRate}" type="number" maxFractionDigits="0"/>%
                    	</c:if>
                    	<c:if test="${bounceRate < 0}">
                    		<svg class="icon icon-xs text-danger me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 17l-4 4m0 0l-4-4m4 4V3"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${-bounceRate}" type="number" maxFractionDigits="0"/>%
                    	</c:if>
                    	<c:if test="${bounceRate == 0}">
                    		<svg class="icon icon-xs text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${bounceRate}" type="number" maxFractionDigits="0"/>%
                    		
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
</div>
