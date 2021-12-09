<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
    <div class="card-header">
        <div class="row align-items-center">
            <div class="h2 col d-flex align-items-center text-tertiary fw-bold mb-0 fs-5">
                <svg class="icon me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 18.657A8 8 0 016.343 7.343S7 9 9 10c0-2 .5-5 2.986-7C14 5 16.09 5.777 17.656 7.343A7.975 7.975 0 0120 13a7.975 7.975 0 01-2.343 5.657z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.879 16.121A3 3 0 1012.015 11L11 14H9c0 .768.293 1.536.879 2.121z"></path></svg>
              		Đơn hàng mới
            </div>
            <!-- <div class="col text-end">
                <a href="#" class="btn btn-sm btn-gray-200">
            	<span class="d-flex align-items-center">
            		<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
            		<span>Xem tất cả</span>
            	</span>
            	</a>
            </div> -->
        </div>
    </div>
    <div class="card-body">
    <div class="list-group list-group-flush">
              <!-- <div class="h6 text-center text-danger fw-bold border-bottom border-light py-3 d-flex align-items-center justify-content-center">
              	<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 18.657A8 8 0 016.343 7.343S7 9 9 10c0-2 .5-5 2.986-7C14 5 16.09 5.777 17.656 7.343A7.975 7.975 0 0120 13a7.975 7.975 0 01-2.343 5.657z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.879 16.121A3 3 0 1012.015 11L11 14H9c0 .768.293 1.536.879 2.121z"></path></svg>
              		Đơn hàng mới
              </div> -->
              
              <c:forEach items="${applicationScope.lastestOrders}" var="order" varStatus="i" begin="0" end="4">
              <a href="${applicationScope.ordersPage}/${order.id}" class="list-group-item list-group-item-action ${i.index != i.end ? 'border-bottom' : '' }">
                <div class="row align-items-center">
                    <div class="col-auto d-flex flex-column">
                    	<small class="text-danger">
                            <fmt:setLocale value="vi_VN" scope="session"/>
                            <fmt:formatDate value="${order.orderDate}" pattern="HH:mm"/>
                    	</small>
                        <small class="text-danger">
                        	<fmt:setLocale value="vi_VN" scope="session"/>
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM"/>
                        </small>
                      <!-- Avatar -->
                      <%-- <img alt="Image placeholder" src="<c:url value='/resources/admin/assets/img/team/profile-picture-1.jpg' />" class="avatar-md rounded"> --%>
                    </div>
                    <div class="col ps-0 ms-2">
                      <div class="d-flex justify-content-between align-items-center">
                          <div>
                            <h4 class="h6 mb-0 text-small d-flex align-items-center">
                            <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14"></path></svg>
                            ${order.id}</h4>
                          </div>
                          <div class="text-end">
                           <%--  <small class="text-danger">${order.orderDate}</small> --%>
                            <small class="text-success d-flex flex-column align-items-end">
                            	<fmt:setLocale value="vi_VN" scope="session" />
                              	<fmt:formatNumber value="${order.getTotalPrice()}" type="currency" />
                            </small>
                          </div>
                      </div>
                      <p class="font-small mt-1 mb-0 text-truncate">
                      	<svg class="icon icon-xxs text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                      	${order.shipName}
                      </p>
                      
                      <p class="font-small my-0">
                      <span class="d-inline-block text-truncate" style="min-width: 200px;">
                      	 <svg class="icon icon-xxs text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
							  ${order.shipAddress}
							</span>
                      </p>
                    </div>
                </div>
              </a>
              </c:forEach>
            </div>
    	</div>
    	<div class="card-footer border-top bg-gray-50">
    	<a class="fw-bold d-flex align-items-center justify-content-center" href="${applicationScope.ordersPage}">
    		<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
    		Xem tất cả
    	</a>
    </div>
</div>
