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

<style type="text/css">
	.box {
		width: 100%;
		height: 100%;
		display: flex;
		/* align-items: flex-start;
		justify-content: center; */
		flex-direction: column;
	}

</style>

</head>

<body>
<%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

  <main class="content">
  	<%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>
  
    <div class="py-4">
      <nav aria-label="breadcrumb" class="d-none d-md-inline-block">
        <ol class="breadcrumb breadcrumb-dark breadcrumb-transparent">
          <li class="breadcrumb-item">
            <a href="#">
              <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6">
                </path>
              </svg>
            </a>
          </li>
          <li class="breadcrumb-item">Khách hàng</li>
          <li class="breadcrumb-item active" aria-current="page"><a href="${applicationScope.customerPage }/${customer.id }">${customer.id }</a></li>
        </ol>
      </nav>
      <div class="d-flex justify-content-between w-100 flex-wrap">
        <div class="mb-3 mb-lg-0">
          <h1 class="h4">Thông tin khách hàng </h1>
          <!-- <p class="mb-0">Dozens of reusable components built to provide buttons, alerts, popovers, and more.</p> -->
        </div>
        <!-- <div>
          <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/modals/"
            class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Modals Docs</a>
        </div> -->
      </div>
    </div>

     <div class="row">
        <div class="col-lg-6 mt-lg-0 mt-4">
          <div class="box card border-0 shadow">
            <div class="card-body">
              <div class="mb-3 mb-lg-0">
                <h1 class="h4">
                	Thông tin khách hàng
                </h1>
              </div>

              <div class="row">
                <div class="col-12">
                  <ul class="">
                  	 <li><small>#</small> <span class="fw-bold text-danger">${customer.id }</span></li>
                    <li><small>Họ tên:</small> <span class="fw-bold">${customer.lastname } ${customer.firstname }</span></li>
                    <li>
                      <p class="text-truncate my-0">
                        <small>Địa chỉ:</small>
                        <span class="ms-1 fw-bold text-primary">
                          ${customer.address}
                        </span>
                      </p>
                    </li>
                    <li><small>Số điện thoại:</small> <span class="fw-bold text-primary">${customer.phone }</span></li>
                    <li><small>Email:</small> <span class="fw-bold text-primary">${customer.email }</span></li>
                    <li><small>Ngày đăng ký:</small> <span class="fw-bold text-primary">${customer.dateAdded }</span></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-lg-6">
          <div class="box card border-0 shadow">
            <div class="card-body">
              <div class="mb-3 mb-lg-0">
                <h1 class="h4">Thông tin khác</h1>
              </div>
              <div class="row">
                <div class="col-12">
                  <ul class="">
                    <li class="">
                    <div class="d-flex align-items-center">
                      <small>Sản phẩm yêu thích:</small>
                      <span class="fw-normal text-danger d-flex align-items-center">
                      	<svg class="icon icon-xxs me-1 ms-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
                        ${customer.favoriteProducts.size()}
                      </span>
                      </div>
                    </li>
                    
                    <li><small>Tổng số đơn hàng:</small> <span class="fw-bold text-bold">${customer.orders.size()}</span></li>
                    
                    <li>
                      <small>Lần đặt hàng cuối:</small>
                      <span class="fw-bold">
                        <fmt:formatDate value="${customer.orders.get(0).orderDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                      </span>
                    </li>
                    <li>
                      <small>Tổng số tiền đặt hàng:</small>
                      <span class="fw-bold text-success">
                        <fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${customer.getTotalAmountOfOrders() }" type="currency" />
                      </span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    
    <hr class="mt-4">

	<div class="row mt-4">

      <div class="py-4 d-flex justify-content-between w-100 flex-wrap">
        <div class="mb-3 mb-lg-0">
          <h1 class="h4">Danh sách các đơn hàng</h1>
          <p class="mb-0 text-gray-400">Đơn hàng do khách hàng đặt</p>
        </div>
      </div>

	<%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

      <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder" />
      <c:url value="${requestScope['javax.servlet.forward.request_uri']}" var="pagedLink">
         <c:param name="p" value="~" />
      </c:url>

	 <%-- <div class="table-settings mb-4">
            <div class="row align-items-center justify-content-between">
               <div class="col col-md-6 col-lg-3 col-xl-4">
                  <form action="${applicationScope.productPage }" method="get">
                     <div class="input-group me-2 me-lg-3 fmxw-300">
                        <input type="text" class="form-control" placeholder="Tìm kiếm" name="search" />

                        <a class="input-group-text" href="${applicationScope.productPage}">
                           <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
                              <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z" />
                              <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z" />
                           </svg>
                        </a>

                        <button class="input-group-text" type="submit">
                           <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                              <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                           </svg>
                        </button>
                     </div>
                  </form>
               </div>
               <div class="col-4 col-md-2 col-xl-1 ps-md-0 text-end">
                  <div class="dropdown">
                     <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                           <path
                              fill-rule="evenodd"
                              d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                              clip-rule="evenodd"
                           ></path>
                        </svg>
                        <span class="visually-hidden">Toggle Dropdown</span>
                     </button>
                     <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0">
                        <span class="small ps-3 fw-bold text-dark">Hiển thị</span>
                        <a class="dropdown-item d-flex align-items-center fw-bold" href="#">
                           10
                           <svg class="icon icon-xxs ms-auto" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                           </svg>
                        </a>
                        <a class="dropdown-item fw-bold" href="#">20</a>
                        <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
                     </div>
                  </div>
               </div>
            </div>
         </div> --%>

         
    </div>
	
	<div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden">
            <table class="table table-hover table-responsive" id="datatable">
               <thead class="thead-dark">
                  <tr>
                     <th class="border-gray-200 rounded-start">#</th>
                            <th class="border-gray-200">Ngày đặt</th>						
                            <th class="border-gray-200">Địa chỉ</th>
                            <th class="border-gray-200">Tổng số tiền</th>
                            <th class="border-gray-200">Sản phẩm</th>
                            <th class="border-gray-200">Trạng thái</th>
                           <!--  <th class="border-gray-200">Loại</th>
                            <th class="border-gray-200">Ngày thêm</th>
                            <th class="border-gray-200">Hình ảnh</th> -->
                            <th class="border-gray-200 rounded-end"></th>
                  </tr>
               </thead>
               <tbody>
                  <!-- Item -->
                  <c:forEach items="${customer.orders}" var="order">
                        <tr>
                            <td>
                                <a href="${applicationScope.ordersPage}/${order.id}" class="fw-bold">
                                    ${order.id}
                                </a>
                            </td>
	                            <td>
	                            <span class="fw-normal text-wrap">
	                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
	                            
	                            </span>
	                            </td>
                            <td><span class="fw-bold text-wrap">
                            ${order.shipAddress}
                            
                            </span></td>
                                                    
                            <td><span class="fw-normal text-wrap">
                            	<fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${order.getTotalPrice()}" type="currency" />
                            </span></td>
                            <%-- <td><span class="fw-bold text-wrap" >${product.price}</span></td>
                            <td><span class="fw-normal text-wrap">${product.description}</span></td> --%>
                            
                            <td><span class="fw-bold text-wrap">${order.getTotalQuantity()}</span></td>
                            <td><span class="fw-bold text-info text-wrap">
                            	${order.state == 0 ? 'Đơn hàng mới' : order.state == 1 ? 'Khách đã xác nhận' : order.state == 2 ? 'Đang xử lý' : 'Đơn hàng hoàn thành'}
                            </span></td>
                            <%-- <td><span class="fw-normal text-wrap">${product.dateAdded}</span></td> --%>
                            
					        <%-- <td>
					        	<span class="text-wrap">
						        	<img src="${product.images.isEmpty() ? '' : product.images.get(0).image}" width=100 height=100 alt="${product.name}"/>
						        </span>
					        </td> --%>
                            
                            
                            <td class = "text-center">
                                <div class="btn-group">
                                    <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                      	<svg class="icon icon-xxs" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
                                       
                                        <span class="visually-hidden">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu py-0">
                                        <a class="dropdown-item rounded-top" href="${applicationScope.ordersPage}/${order.id}">
	                                        <i class="bi bi-eye-fill dropdown-icon text-gray-400 me-2 icon-sm"></i>
	                                        Chi tiết
	                                    </a>
                                       <%--  <a class="dropdown-item text-warning" href="${applicationScope.productPage}/edit/${product.id}">
	                                       <i class="bi bi-pencil-square dropdown-icon me-2"></i>
	                                        Chỉnh sửa
                                        </a>
                                        <a class="dropdown-item text-danger rounded-bottom" href="${applicationScope.productPage}/delete/${product.id}">
											<i class="bi bi-trash2-fill dropdown-icon me-2"></i>
											Xoá
										</a> --%>
                                    </div>
                                </div>
                            </td>
                        </tr>   
                      </c:forEach>
               </tbody>
            </table>

            <div>
               <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
            </div>
         </div>
	     
	<hr class="mt-4">
	
	<%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
     </main>
	
	<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

</body>

</html>