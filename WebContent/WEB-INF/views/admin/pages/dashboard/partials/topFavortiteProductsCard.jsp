<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <div class=" h2 fs-5 fw-bold mb-0 text-danger d-flex align-items-center">
        <svg class="icon me-2" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
        	<span>Yêu thích nhất</span>
        
        </div>
    </div>
    <div class="card-body">
        <div class="list-group list-group-flush list my--3">
            <c:forEach items="${topFavoriteProducts}" var="product" varStatus="i" begin="0" end="4">
                <a class="list-group-item list-group-item-action px-2 ${i.index != i.end ? 'border-bottom' : '' }" aria-current="true" href="${applicationScope.productPage }/${product.id}">
                    <div class="row align-items-center justify-content-between">
                        <div class="col-auto">
                            <h3 class="my-0 ${i.count == 1 ? 'text-danger' : i.count == 2 ? 'text-secondary' : i.count == 3 ? 'text-tertiary' : 'text-gray-400' }">${i.count }</h3>
                        </div>
                        <div class="col-auto">
                            <img class="rounded" width="50" height="50" alt="Image placeholder" src="${product.images.get(0).image}" />
                        </div>
                        <div class="col-5 text-truncate">
                            <h4 class="h6 mb-0 text-truncate">
                                ${product.name }
                            </h4>
                        </div>
                        <div class="col-auto">
                            <div class="d-flex align-items-center">
                                <!-- <div class="bg-success dot rounded-circle me-1"></div> -->
                                <svg class="icon icon-xxs text-danger me-1" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                                    ></path>
                                </svg>
                                <small>${product.favoriteProducts.size() }</small>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
    <div class="card-footer border-top bg-gray-50">
    	<a class="fw-bold d-flex align-items-center justify-content-center" href="${applicationScope.dashboardPage}/${applicationScope.topFavoriteProductsPage}">
    		<svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4"></path></svg>
    		Xem tất cả
    	</a>
    </div>
</div>

<!-- <div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <h2 class="fs-5 fw-bold mb-0">Progress track</h2>
        <a href="#" class="btn btn-sm btn-primary">See tasks</a>
    </div>
    <div class="card-body">
        Project 1
        <div class="row mb-4">
            <div class="col-auto">
                <svg class="icon icon-sm text-gray-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path>
                    <path
                        fill-rule="evenodd"
                        d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z"
                        clip-rule="evenodd"
                    ></path>
                </svg>
            </div>
            <div class="col">
                <div class="progress-wrapper">
                    <div class="progress-info">
                        <div class="h6 mb-0">Rocket - SaaS Template</div>
                        <div class="small fw-bold text-gray-500"><span>75 %</span></div>
                    </div>
                    <div class="progress mb-0">
                        <div class="progress-bar bg-success" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%;"></div>
                    </div>
                </div>
            </div>
        </div>
        Project 2
        <div class="row align-items-center mb-4">
            <div class="col-auto">
                <svg class="icon icon-sm text-gray-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path>
                    <path
                        fill-rule="evenodd"
                        d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z"
                        clip-rule="evenodd"
                    ></path>
                </svg>
            </div>
            <div class="col">
                <div class="progress-wrapper">
                    <div class="progress-info">
                        <div class="h6 mb-0">Themesberg - Design System</div>
                        <div class="small fw-bold text-gray-500"><span>60 %</span></div>
                    </div>
                    <div class="progress mb-0">
                        <div class="progress-bar bg-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
                    </div>
                </div>
            </div>
        </div>
        Project 3
        <div class="row align-items-center mb-4">
            <div class="col-auto">
                <svg class="icon icon-sm text-gray-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path>
                    <path
                        fill-rule="evenodd"
                        d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z"
                        clip-rule="evenodd"
                    ></path>
                </svg>
            </div>
            <div class="col">
                <div class="progress-wrapper">
                    <div class="progress-info">
                        <div class="h6 mb-0">Homepage Design in Figma</div>
                        <div class="small fw-bold text-gray-500"><span>45 %</span></div>
                    </div>
                    <div class="progress mb-0">
                        <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%;"></div>
                    </div>
                </div>
            </div>
        </div>
        Project 4
        <div class="row align-items-center mb-3">
            <div class="col-auto">
                <svg class="icon icon-sm text-gray-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path>
                    <path
                        fill-rule="evenodd"
                        d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z"
                        clip-rule="evenodd"
                    ></path>
                </svg>
            </div>
            <div class="col">
                <div class="progress-wrapper">
                    <div class="progress-info">
                        <div class="h6 mb-0">Backend for Themesberg v2</div>
                        <div class="small fw-bold text-gray-500"><span>34 %</span></div>
                    </div>
                    <div class="progress mb-0">
                        <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100" style="width: 34%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> -->
