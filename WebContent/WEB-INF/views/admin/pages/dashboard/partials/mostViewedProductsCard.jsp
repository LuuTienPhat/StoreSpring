<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <div class=" h2 fs-5 fw-bold mb-0 text-info d-flex align-items-center">
        <svg class="icon me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
        	<span>Xem nhiều nhất</span>
        </div>
    </div>
    <div class="card-body">
        <div class="list-group list-group-flush list my--3">
        	<c:forEach items="${mostViewedProducts}" var="product" varStatus="i" begin="0" end="4">
            	<a class="list-group-item list-group-item-action px-2 ${i.index != i.end ? 'border-bottom' : '' }" aria-current="true" href="${applicationScope.productPage }/${product.id}">
    			<div class="row align-items-center justify-content-between">
                <div class="col-auto">
                	<h3 class="my-0 ${i.count == 1 ? 'text-danger' : i.count == 2 ? 'text-secondary' : i.count == 3 ? 'text-tertiary' : 'text-gray-400' }">${i.count }</h3>
                    </div>
                    <div class="col-auto">
                       <img class="rounded" width="50" height="50" alt="Image placeholder" src="${product.images.get(0).image}" />
                    </div>
                    <div class="col-5 text-truncate ">
                        <h4 class="h6 mb-0 text-truncate">
                        ${product.name }
                        </h4>
                    </div>
                    <div class="col-auto">
                        
                        <div class="d-flex align-items-center">
                            <!-- <div class="bg-success dot rounded-circle me-1"></div> -->
                            <svg class="icon icon-xxs text-info me-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                            <small>${product.views }</small>
                        </div>
                    </div>
                </div>
  				</a>
            </c:forEach>
           </div>
    </div>
    <div class="card-footer border-top bg-gray-50">
    	<a class="fw-bold d-flex align-items-center justify-content-center" href="${applicationScope.dashboardPage}/${applicationScope.mostViewedProductsPage}">
    		<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
    		Xem tất cả
    	</a>
    </div>
</div>


<!-- <div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <h2 class="fs-5 fw-bold mb-0">Team members</h2>
        <a href="#" class="btn btn-sm btn-primary">See all</a>
    </div>
    <div class="card-body">
        <ul class="list-group list-group-flush list my--3">
            <li class="list-group-item px-0">
                <div class="row align-items-center">
                    <div class="col-auto">
                        Avatar
                        <a href="#" class="avatar">
                            <img class="rounded" alt="Image placeholder" src="../../assets/img/team/profile-picture-1.jpg" />
                        </a>
                    </div>
                    <div class="col-auto ms--2">
                        <h4 class="h6 mb-0">
                            <a href="#">Chris Wood</a>
                        </h4>
                        <div class="d-flex align-items-center">
                            <div class="bg-success dot rounded-circle me-1"></div>
                            <small>Online</small>
                        </div>
                    </div>
                    <div class="col text-end">
                        <a href="#" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                            <svg class="icon icon-xxs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path>
                            </svg>
                            Invite
                        </a>
                    </div>
                </div>
            </li>
            <li class="list-group-item px-0">
                <div class="row align-items-center">
                    <div class="col-auto">
                        Avatar
                        <a href="#" class="avatar">
                            <img class="rounded" alt="Image placeholder" src="../../assets/img/team/profile-picture-2.jpg" />
                        </a>
                    </div>
                    <div class="col-auto ms--2">
                        <h4 class="h6 mb-0">
                            <a href="#">Jose Leos</a>
                        </h4>
                        <div class="d-flex align-items-center">
                            <div class="bg-warning dot rounded-circle me-1"></div>
                            <small>In a meeting</small>
                        </div>
                    </div>
                    <div class="col text-end">
                        <a href="#" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                            <svg class="icon icon-xxs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z" clip-rule="evenodd"></path>
                            </svg>
                            Message
                        </a>
                    </div>
                </div>
            </li>
            <li class="list-group-item px-0">
                <div class="row align-items-center">
                    <div class="col-auto">
                        Avatar
                        <a href="#" class="avatar">
                            <img class="rounded" alt="Image placeholder" src="../../assets/img/team/profile-picture-3.jpg" />
                        </a>
                    </div>
                    <div class="col-auto ms--2">
                        <h4 class="h6 mb-0">
                            <a href="#">Bonnie Green</a>
                        </h4>
                        <div class="d-flex align-items-center">
                            <div class="bg-danger dot rounded-circle me-1"></div>
                            <small>Offline</small>
                        </div>
                    </div>
                    <div class="col text-end">
                        <a href="#" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                            <svg class="icon icon-xxs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z" clip-rule="evenodd"></path>
                            </svg>
                            Message
                        </a>
                    </div>
                </div>
            </li>
            <li class="list-group-item px-0">
                <div class="row align-items-center">
                    <div class="col-auto">
                        Avatar
                        <a href="#" class="avatar">
                            <img class="rounded" alt="Image placeholder" src="../../assets/img/team/profile-picture-4.jpg" />
                        </a>
                    </div>
                    <div class="col-auto ms--2">
                        <h4 class="h6 mb-0">
                            <a href="#">Neil Sims</a>
                        </h4>
                        <div class="d-flex align-items-center">
                            <div class="bg-danger dot rounded-circle me-1"></div>
                            <small>Offline</small>
                        </div>
                    </div>
                    <div class="col text-end">
                        <a href="#" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                            <svg class="icon icon-xxs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z" clip-rule="evenodd"></path>
                            </svg>
                            Message
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div> -->
