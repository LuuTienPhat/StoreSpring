<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
            <div class="card-body">
              <div class="row d-block d-xl-flex align-items-center">
                <div class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                  <div class="icon-shape icon-shape-tertiary rounded me-4 me-sm-0">
                    <!-- <svg class="icon" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg> -->
                    <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 14l6-6m-5.5.5h.01m4.99 5h.01M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16l3.5-2 3.5 2 3.5-2 3.5 2zM10 8.5a.5.5 0 11-1 0 .5.5 0 011 0zm5 5a.5.5 0 11-1 0 .5.5 0 011 0z"></path></svg>
                  </div>
                  <div class="d-sm-none">
                    <h2 class="fw-extrabold h5">Hóa đơn</h2>
                    <h3 class="mb-1">
                    	<span class="fw-extrabold mb-2 d-inline-flex align-items-baseline ">
                    <span class="me-3">
                    	<small>Nhập:</small><span class="my-0 h3 ms-1 fw-extrabold">${thisMonthInvoices.getImportInvoices().size() }</span>
                    </span>
                   	<span>
                   		<small>Xuất:</small><span class="my-0 ms-1 h3 fw-extrabold">${thisMonthInvoices.getExportInvoices().size() }</span>
                   	</span>
                    </span>
                    </h3>
                  </div>
                </div>
                <div class="col-12 col-xl-7 px-xl-0">
                  <div class="d-none d-sm-block">
                    <h2 class="h6 text-gray-400 mb-0">Hóa đơn</h2>
                    <span class="fw-extrabold mb-2 d-inline-flex align-items-baseline ">
                    <span class="me-3">
                    	<small>Nhập:</small><span class="my-0 h3 ms-1 fw-extrabold">${thisMonthInvoices.getImportInvoices().size()}</span>
                    </span>
                   	<span>
                   		<small>Xuất:</small><span class="my-0 ms-1 h3 fw-extrabold">${thisMonthInvoices.getExportInvoices().size()}</span>
                   	</span>
                    </span>
                  </div>
                  <small class="text-gray-500">
                  	${thisMonth }
                  </small>
                  <div class="small d-flex mt-1">
                    <div>
                    So với tháng trước 
                    	<c:choose>
                    		<c:when test="${growthRateOfInvoices > 0}">
                    			<svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                    			<span class="text-success fw-bolder">
		                    		<fmt:formatNumber value="${growthRateOfInvoices}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:when test="${growthRateOfInvoices < 0}">
                    			<svg class="icon icon-xs text-danger" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                    			<span class="text-danger fw-bolder">
		                    		<fmt:formatNumber value="${-growthRateOfInvoices}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:otherwise>
                    			<svg class="icon icon-xs text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    			<span class="text-gray-600 fw-bolder">
                    				<fmt:formatNumber value="${growthRateOfInvoices}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:otherwise>
                    	</c:choose>
                	</div>
                  </div>
                </div>
              </div>
            </div>
          </div>