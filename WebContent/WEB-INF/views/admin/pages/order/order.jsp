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

<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<body>

<%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

<jsp:useBean id="pagedListHolder" scope="request"
	type="org.springframework.beans.support.PagedListHolder" />
	

<c:url
	value= "${pagedLink}"
	var="pagedLink">
	<c:param name="p" value="~" />
</c:url>

<main class="content">
	<%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>
	
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center py-4">
                <div class="d-block mb-4 mb-md-0">
                    <nav aria-label="breadcrumb" class="d-none d-md-inline-block">
                        <ol class="breadcrumb breadcrumb-dark breadcrumb-transparent">
                            <li class="breadcrumb-item">
                                <a href="#">
                                    <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                                    </svg>
                                </a>
                            </li>
                            <li class="breadcrumb-item">Đơn hàng</a></li>
                            <li class="breadcrumb-item active" aria-current="page"><a href="${requestScope['javax.servlet.forward.request_uri']}">Quản lý đơn hàng</a></li>
                        </ol>
                    </nav>
                    <h2 class="h4">Đơn hàng</h2>
                    <!-- <p class="mb-0">Trang sản phẩm</p> -->
                </div>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <%-- <a href="${applicationScope.addCategoryPage }" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                        <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                        Thêm danh mục
                    </a> --%>
                    <!-- <div class="btn-group ms-2 ms-lg-3">
                        <button type="button" class="btn btn-sm btn-outline-gray-600">Chia sẻ</button>
                        <button type="button" class="btn btn-sm btn-outline-gray-600">Xuất file</button>
                    </div> -->
                </div>
            </div>
            
            
            <!-- START FROM HERE -->
            <div class="table-settings mb-4">
                <div class="row justify-content-between align-items-center">
                    <div class="col-9 col-lg-8 d-md-flex">
                    
                    <!-- SEARCH -->
                        <form action = "${requestScope['javax.servlet.forward.request_uri']}" method="get">
                        <div class="input-group me-2 me-lg-3 fmxw-300">
                            <input type="text" class="form-control" placeholder="Tìm kiếm" name = "search" value="${search }"/>
                        	<a class="input-group-text" href = "${requestScope['javax.servlet.forward.request_uri']}">
                        		<svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                                </a>

                                <button class="input-group-text" type="submit">
                                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                </button>
                        </div>
                     </form>
                            
                        <select id="state-selection" class="form-select fmxw-300 d-none d-md-inline" aria-label="Message select example 2">
                            <option selected value="">Tất cả</option>
                            <option value="0" ${state == 0 ? 'selected' : '' }>Mới tiếp nhận</option>
                            <option value="1" ${state == 1 ? 'selected' : '' }>Xác nhận với khách hàng</option>
                            <option value="2" ${state == 2 ? 'selected' : '' }>Đang xử lý</option>
                            <option value="3" ${state == 3 ? 'selected' : '' }>Đã hoàn thành</option>
                            <option value="-1" ${state == -1 ? 'selected' : '' }>Đơn hàng đã hủy</option>
                        </select>
                    </div>
                    <!-- <div class="col-3 col-lg-4 d-flex justify-content-end">
                        <div class="btn-group">
                            <div class="dropdown me-1">
                                <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <svg class="icon icon-sm" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M5 4a1 1 0 00-2 0v7.268a2 2 0 000 3.464V16a1 1 0 102 0v-1.268a2 2 0 000-3.464V4zM11 4a1 1 0 10-2 0v1.268a2 2 0 000 3.464V16a1 1 0 102 0V8.732a2 2 0 000-3.464V4zM16 3a1 1 0 011 1v7.268a2 2 0 010 3.464V16a1 1 0 11-2 0v-1.268a2 2 0 010-3.464V4a1 1 0 011-1z"/>
                                    </svg>
                                    <span class="visually-hidden">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-end pb-0">
                                    <span class="small ps-3 fw-bold text-dark">Show</span>
                                    <a class="dropdown-item d-flex align-items-center fw-bold" href="#">10
                                        <svg class="icon icon-xxs ms-auto" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                        </svg>
                                    </a>
                                    <a class="dropdown-item fw-bold" href="#">20</a>
                                    <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <svg class="icon icon-sm" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"/>
                                    </svg>
                                    <span class="visually-hidden">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0">
                                    <span class="small ps-3 fw-bold text-dark">Show</span>
                                    <a class="dropdown-item d-flex align-items-center fw-bold" href="#">10
                                        <svg class="icon icon-xxs ms-auto" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                        </svg>
                                    </a>
                                    <a class="dropdown-item fw-bold" href="#">20</a>
                                    <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
                                </div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
            <div class="card card-body shadow border-0 table-wrapper table-responsive overflow-hidden">
                <!-- <div class="d-flex mb-3">
                    <select class="form-select fmxw-200" aria-label="Message select example">
                        <option selected="selected">Bulk Action</option>
                        <option value="1">Send Email</option>
                        <option value="2">Change Group</option>
                        <option value="3">Delete User</option>
                    </select>
                    <button class="btn btn-sm px-3 btn-secondary ms-3">Apply</button>
                </div> -->
                <table class="table user-table table-hover align-items-center">
                    <thead class="thead-dark">
                        <tr>
                            <!-- <th class="border-bottom rounded-start">
                                <div class="form-check dashboard-check"><input class="form-check-input" type="checkbox" value id="userCheck55">
                                    <label class="form-check-label" for="userCheck55"></label>
                                </div>
                            </th> -->
                            <th class="border-bottom text-wrap rounded-start">#</th>
                            <th class="border-bottom text-wrap">Tên người đặt</th>
                            <th class="border-bottom text-wrap">Ngày đặt</th>
                            <th class="border-bottom text-wrap">Giờ đặt</th>
                            <th class="border-bottom text-wrap">Địa chỉ</th>
                            <th class="border-bottom text-wrap">SL</th>
                            <th class="border-bottom text-wrap">Tổng tiền</th>
                            <th class="border-bottom text-wrap">Trạng thái</th>
                            <th class="border-bottom rounded-end"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pagedListHolder.pageList}" var="order">
                        <tr>
                            <!-- <td>
                                <div class="form-check dashboard-check"><input class="form-check-input" type="checkbox" value id="userCheck1">
                                    <label class="form-check-label" for="userCheck1"></label>
                                </div>
                            </td> -->
                            <td>
                               <!--  <a href="#" class="d-flex align-items-center"><img src="images/profile-picture-1.jpg" class="avatar rounded-circle me-3" alt="Avatar">
                                     --><div class="d-block">
                                     <a href="${applicationScope.ordersPage }/${order.id}">
                                        <span class="fw-bold">${order.id}</span></a>
                                        <!-- <div class="small text-gray">
                                            <span class="__cf_email__" data-cfemail="fd94939b92bd98859c908d9198d39e9290">[email&#160;protected]</span>
                                        </div> -->
                                    </div>
                                </a>
                            </td>
                            <td>
                                <span class="fw-normal">${order.shipName}</span>
                            </td>
                            <td>
                                <span class="fw-normal d-flex align-items-center text-wrap">
                                    <!-- <svg class="icon icon-xxs text-success me-1" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                    </svg> -->
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                    </span>
                            </td>
                            
                            <td>
                                <span class="fw-normal text-wrap">
                                
                                <fmt:formatDate value="${order.orderDate}" pattern="HH:mm:ss" />
                                
                                </span>
                            </td>
                            
                            <td>
                                <span class="fw-normal text-wrap">
                                
                                <span class="d-inline-block text-truncate" style="max-width: 150px;">
								  ${order.shipAddress}
								</span>
                                
                                </span>
                            </td>
                            <td>
                           <%--  <span class="fw-normal text-wrap">${order.orderDetails}</span> --%>
                           <span class="fw-normal text-wrap">
                            	${order.getTotalQuantity()}
                               </span>
                            </td>
                            <td>
                                <span class="fw-normal">
                                
                                 <fmt:setLocale value="vi_VN" scope="session" />
                                 <fmt:formatNumber value="${order.getTotalPrice()}" type="currency" />
                                
                                </span>
                            </td>
                            <td>
                                <span class="fw-normal text-wrap">
                                <c:choose>
                                <c:when test="${order.state == -1}">
								  	<span class="text-danger">Đơn hàng đã hủy</span>  
								  </c:when>
								  <c:when test="${order.state == 0}">
								  	<span class="text-info">Đơn hàng mới</span>  
								  </c:when>
								   <c:when test="${order.state == 1}">
								  		<span class="text-tertiary">Đơn hàng đã xác nhận</span>
								  </c:when>
								  <c:when test="${order.state == 2}">
								  		<span class="text-secondary">Đơn hàng đang xử lý</span>
								  </c:when>
								  <c:otherwise>
								    <span class="text-success">Đơn hàng hoàn thành</span>
								  </c:otherwise>
								</c:choose>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <svg class="icon icon-xs" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z"/>
                                        </svg>
                                        <span class="visually-hidden">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu dashboard-dropdown dropdown-menu-start mt-2 py-1">
                                        <!-- <a class="dropdown-item d-flex align-items-center" href="#">
                                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M10 1.944A11.954 11.954 0 012.166 5C2.056 5.649 2 6.319 2 7c0 5.225 3.34 9.67 8 11.317C14.66 16.67 18 12.225 18 7c0-.682-.057-1.35-.166-2.001A11.954 11.954 0 0110 1.944zM11 14a1 1 0 11-2 0 1 1 0 012 0zm0-7a1 1 0 10-2 0v3a1 1 0 102 0V7z" clip-rule="evenodd"/>
                                            </svg>
                                            Reset Pass
                                        </a> -->
                                        <a class="dropdown-item d-flex align-items-center" href="${applicationScope.ordersPage }/${order.id}">
                                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                                                <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                                            </svg>
                                            Chi tiết đơn hàng
                                        </a>
                                        <!-- <a class="dropdown-item d-flex align-items-center" href="#">
                                            <svg class="dropdown-icon text-danger me-2" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M11 6a3 3 0 11-6 0 3 3 0 016 0zM14 17a6 6 0 00-12 0h12zM13 8a1 1 0 100 2h4a1 1 0 100-2h-4z"/>
                                            </svg>
                                            Suspend</a> -->
                                    </div>
                                </div>
                                <!-- <svg class="icon icon-xs text-danger ms-1" title="Delete" data-bs-toggle="tooltip" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                </svg> -->
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                </table>
                 <div>
               		<tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
           		</div>
            </div>
            
       
         <!-- ========== All JS files linkup ========= -->
		<%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
</main>

<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

<!-- ========== Notyf JS linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>

</body>

<script type="text/javascript">
	const stateSelection = document.getElementById("state-selection");
	stateSelection.addEventListener('change', () => {
		console.log(stateSelection.value);
		const url = "${requestScope['javax.servlet.forward.request_uri']}?state=" + stateSelection.value;
		window.location.href = url;
	})
</script>
</html>
