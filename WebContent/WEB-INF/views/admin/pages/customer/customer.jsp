<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<jsp:useBean id="pagedListHolder" scope="request"
	type="org.springframework.beans.support.PagedListHolder" />
<c:url
	value="${pagedLink }"
	var="pagedLink">
	<c:param name="p" value="~" />
</c:url>

<%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>
    
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
                            <li class="breadcrumb-item">Khách hàng</li>
                            <li class="breadcrumb-item active" aria-current="page"><a href="${applicationScope.customerPage }">${title}</a></li>
                        </ol>
                    </nav>
                    <h2 class="h4">Khách hàng</h2>
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
                    <div class="col col-md-6 col-lg-3 col-xl-4 ">
                    <form action = "${requestScope['javax.servlet.forward.request_uri']}" method="get">
                        <div class="input-group me-2 me-lg-3 fmxw-300">
                            <input type="text" class="form-control" placeholder="Tìm kiếm" name = "search"/>
                        	<a class="input-group-text" href = "${applicationScope.customerPage}">
                        		<svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                                </a>

                                <button class="input-group-text" type="submit">
                                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                </button>
                        </div>
                     </form>
                      
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
                        <option value="1">Gửi Email</option>
                        <option value="2">Change Group</option>
                        <option value="3">Xoá khách hàng</option>
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
                            <th class="border-bottom">#</th>
                            <th class="border-bottom">Họ và tên</th>
                            <!-- <th class="border-bottom">Tên khách hàng</th> -->
                            <th class="border-bottom">Số điện thoại</th>
                            <th class="border-bottom">Địa chỉ</th>
                            <th class="border-bottom">Email</th>
                            <th class="border-bottom">Ngày đăng ký</th>
                            <!-- <th class="border-bottom">Trạng thái</th> -->
                            <th class="border-bottom rounded-end"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pagedListHolder.pageList}" var="customer">
                        <tr>
                            <!-- <td>
                                <div class="form-check dashboard-check"><input class="form-check-input" type="checkbox" value id="userCheck1">
                                    <label class="form-check-label" for="userCheck1"></label>
                                </div>
                            </td> -->
                            <td>
                               <!--  <a href="#" class="d-flex align-items-center"><img src="images/profile-picture-1.jpg" class="avatar rounded-circle me-3" alt="Avatar">
                                     --><div class="d-block">
                                        <span class="fw-bold"><a href="${applicationScope.customerPage }/${customer.id}">${customer.id}</a></span>
                                        <!-- <div class="small text-gray">
                                            <span class="__cf_email__" data-cfemail="fd94939b92bd98859c908d9198d39e9290">[email&#160;protected]</span>
                                        </div> -->
                                    </div>
                                </a>
                            </td>
                            <td>
                                <span class="fw-normal">${customer.firstname} ${customer.lastname}</span>
                            </td>
                            <td>
                                <span class="fw-normal d-flex align-items-center text-wrap">
                                    <svg class="icon icon-xxs text-success me-1" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                    </svg>
                                    ${customer.phone}</span>
                            </td>
                            <td>
                                <span class="fw-normal text-wrap">${customer.address}</span>
                            </td>
                           <%--  <td>
                           <span class="fw-normal text-wrap">
                               <c:forEach items="${order.orderDetails }" var="detail">
                               		${detail.product.name},
                               </c:forEach>
                               </span>
                            </td> --%>
                            <td>
                                <span class="fw-normal">${customer.email}</span>
                            </td>
                            <td>
                                <span class="fw-normal">
                                	<fmt:setLocale value="vi_VN" scope="session"/>
                                	<fmt:parseDate  value="${customer.dateAdded }"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
	                            	<fmt:formatDate value="${parsedDate }" pattern="dd/MM/yyyy"/>
                                </span>
                            </td>
                            <%-- <td>
                                <span class="fw-normal">
                                <c:choose>
								  <c:when test="${order.state == 0}">
								  	<span class="text-warning">Khách mới đặt</span>  
								  </c:when>
								   <c:when test="${order.state == 1}">
								  		<span class="text-info">Đang xử lý</span>
								  </c:when>
								  <c:otherwise>
								    <span class="text-success">Đã giao cho khách hàng</span>
								  </c:otherwise>
								</c:choose>
                                </span>
                            </td> --%>
                            <td>
                                <div class="btn-group">
                                    <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <svg class="icon icon-xs" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z"/>
                                        </svg>
                                        <span class="visually-hidden">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu dashboard-dropdown dropdown-menu-start mt-2 py-1">
                                    	<form action="${applicationScope.mailPage }" method="post">
                                    		<input class="d-none" name="email" value="${customer.email }" />
	                                        <button class="dropdown-item d-flex align-items-center" type="submit">
	                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope dropdown-icon text-info me-2" viewBox="0 0 16 16">
											  <path fill-rule="evenodd" d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
											</svg>
	                                            Gửi E-Mail
	                                        </button>
                                        </form>
                                        <a class="dropdown-item d-flex align-items-center" href="${applicationScope.customerPage }/${customer.id}">
                                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"/>
                                                <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
                                            </svg>
                                            Xem chi tiết
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
                	<tg:adminPaging pagedListHolder="${pagedListHolder}"
					pagedLink="${pagedLink}" />
                </div>
            </div>
         <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
</main>

<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

</body>
</html>
