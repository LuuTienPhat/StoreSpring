<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
    <div class="card-body">
        <div class="row d-block d-xl-flex align-items-center">
            <div class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                <div class="icon-shape icon-shape-info rounded me-4 me-sm-0">
                	<svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path></svg>	
               	</div>
                <div class="d-sm-none">
                    <h2 class="h5">Danh mục</h2>
                    <h3 class="fw-extrabold mb-1">
                    	<fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${categories.size()}" type="number" />
                    </h3>
                </div>
            </div>
            <div class="col-12 col-xl-7 px-xl-0">
                <div class="d-none d-sm-block">
                    <h2 class="h6 text-gray-400 mb-0">Danh mục</h2>
                    <h3 class="fw-extrabold mb-2">
                    	<fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${categories.size()}" type="number" />
                    </h3>
                </div>
                <small class="d-flex align-items-center text-gray-500">
                    Từ trước đến nay
                </small> 
                <div class="small d-flex mt-1">                               
                	<div>So với tháng trước
                    		<c:choose>
                    		<c:when test="${growthRateOfCategories > 0}">
                    			<svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                    			<span class="text-success fw-bolder">
		                    		<fmt:formatNumber value="${growthRateOfCategories}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:when test="${growthRateOfCategories < 0}">
                    			<svg class="icon icon-xs text-danger" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                    			<span class="text-danger fw-bolder">
		                    		<fmt:formatNumber value="${-growthRateOfCategories}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:otherwise>
                    			<svg class="icon icon-xs text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    			<span class="text-gray-600 fw-bolder">
                    				<fmt:formatNumber value="${growthRateOfCategories}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:otherwise>
                    	</c:choose>
                	</div>
                </div>
            </div>
        </div>
    </div>
</div>