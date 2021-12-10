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
                <!-- <small class="d-flex align-items-center text-gray-500">
                    Feb 1 - Apr 1,  
                    <svg class="icon icon-xxs text-gray-500 ms-2 me-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM4.332 8.027a6.012 6.012 0 011.912-2.706C6.512 5.73 6.974 6 7.5 6A1.5 1.5 0 019 7.5V8a2 2 0 004 0 2 2 0 011.523-1.943A5.977 5.977 0 0116 10c0 .34-.028.675-.083 1H15a2 2 0 00-2 2v2.197A5.973 5.973 0 0110 16v-2a2 2 0 00-2-2 2 2 0 01-2-2 2 2 0 00-1.668-1.973z" clip-rule="evenodd"></path></svg>
                    VN
                </small> 
                <div class="small d-flex mt-1">                               
                    <div>So với tháng trước <svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg><span class="text-success fw-bolder">22%</span></div>
                </div> -->
            </div>
        </div>
    </div>
</div>