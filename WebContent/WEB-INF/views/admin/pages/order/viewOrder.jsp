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
                <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                  ></path>
                </svg>
              </a>
            </li>
            <li class="breadcrumb-item">Đơn hàng</li>
            <li class="breadcrumb-item active" aria-current="page"><a href="${requestScope['javax.servlet.forward.request_uri']}">${order.id }</a></li>
          </ol>
        </nav>
      </div>

      <div class="row">
        <div class="col-lg-6">
          <div class="card border-0 shadow">
            <div class="card-body">
              <div class="mb-3 mb-lg-0">
                <h1 class="h4">Thông tin đơn hàng</h1>
              </div>
              <div class="row">
                <div class="col-12">
                  <h3 class="fw-extrabold mb-0">${invoice.id }</h3>
                  <ul>
                    <li>
                      <small>Ngày đặt:</small>
                      <span class="fw-bold">
                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                      </span>
                    </li>
                    <li>
                      <small>Giờ đặt:</small>
                      <span class="fw-bold">
                        <fmt:formatDate value="${order.orderDate}" pattern="HH:mm:ss" />
                      </span>
                    </li>
                    <li><small>Tổng số sản phẩm:</small> <span class="fw-bold text-secondary">${order.getTotalQuantity() }</span></li>
                    <li>
                      <small>Tổng thành tiền:</small>
                      <span class="fw-bold text-success">
                        <fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${order.getTotalPrice() }" type="currency" />
                      </span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-6 mt-lg-0 mt-4">
          <div class="card border-0 shadow">
            <div class="card-body">
              <div class="mb-3 mb-lg-0">
                <h1 class="h4">Thông tin người đặt</h1>
              </div>

              <div class="row">
                <div class="col-12">
                  <ul>
                    <li><small>Họ tên:</small> <span class="fw-bold">${order.shipName }</span></li>
                    <li>
                      <p class="text-truncate my-0">
                        <small>Địa chỉ:</small>
                        <span class="ms-1 fw-bold text-info">
                          ${order.shipAddress }
                        </span>
                      </p>
                    </li>
                    <li><small>Số điện thoại:</small> <span class="fw-bold text-danger">${order.shipPhone }</span></li>
                    <li><small>Ghi chú:</small> <span class="fw-bold text-gray-400">${order.shipNote }</span></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <hr class="mt-4" />
      
      <div class="row mt-4">
        <div class="mb-2 d-flex justify-content-between w-100 flex-wrap">
          <div class="mb-3 mb-lg-0">
            <h1 class="h4">Danh sách các sản phẩm</h1>
            <!-- <p class="mb-0 text-gray-400">Các sản phẩm thuộc danh mục</p> -->
          </div>
        </div>

        <!-- <div class="table-settings mb-4">
          <div class="row align-items-center justify-content-between">
            <div class="col col-md-6 col-lg-3 col-xl-4">
              <div class="input-group me-2 me-lg-3 fmxw-400">
                <span class="input-group-text">
                  <svg class="icon icon-xs" x-description="Heroicon name: solid/search" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                  </svg>
                </span>
                <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm" />
              </div>
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
                  <span class="small ps-3 fw-bold text-dark">Show</span>
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
        </div> -->
      </div>

      <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden">
        <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder" />
        <c:url value="${pagedLink }" var="pagedLink">
          <c:param name="p" value="~" />
        </c:url>

        <table class="table table-hover table-responsive" id="datatable">
          <thead class="thead-dark">
            <tr>
              <th class="border-gray-200 rounded-start">STT</th>
              <th class="border-gray-200">#</th>
              <th class="border-gray-200">Tên sản phẩm</th>
              <th class="border-gray-200">Loại</th>
              <!-- <th class="border-gray-200">Hình ảnh</th> -->
              <th class="border-gray-200">Đơn vị tính</th>
              <!-- <th class="border-gray-200">Mô tả</th> -->

              <!-- <th class="border-gray-200">Ngày thêm</th> -->

              <th class="border-gray-200">SL tồn</th>
              <th class="border-gray-200">SL yêu cầu</th>
              <th class="border-gray-200">Giá</th>
              <th class="border-gray-200">Thành tiền</th>
              <!-- <th class="border-gray-200 rounded-end"></th> -->
            </tr>
          </thead>
          <tbody>
            <!-- Item -->
            <c:forEach items="${pagedListHolder.pageList}" var="invoiceDetail" varStatus="i">
              <tr>
                <td><span class="fw-normal text-wrap">${i.count}</span></td>
                <td>
                  <a href="${applicationScope.productPage}/${product.id}" class="fw-bold">
                    ${invoiceDetail.getProduct().id}
                  </a>
                </td>
                <td><span class="fw-normal text-wrap">${invoiceDetail.getProduct().name}</span></td>
                <td><span class="fw-bold text-danger text-wrap">${invoiceDetail.getProduct().category.name}</span></td>

                <td><span class="fw-normal text-wrap">${invoiceDetail.getProduct().unit}</span></td>
                <td><span class="fw-normal text-wrap">${invoiceDetail.getProduct().quantity}</span></td>
                <td><span class="fw-bold text-wrap">${invoiceDetail.quantity}</span></td>
                <td>
                  <span class="fw-bold text-wrap">
                    <fmt:setLocale value="vi_VN" scope="session" />
                    <fmt:formatNumber value="${invoiceDetail.getProduct().price}" type="currency" />
                  </span>
                </td>
                <td>
                  <span class="fw-bold text-wrap">
                    <fmt:setLocale value="vi_VN" scope="session" />
                    <fmt:formatNumber value="${invoiceDetail.getProduct().price * invoiceDetail.quantity}" type="currency" />
                  </span>
                </td>
                <%--
                <td class="text-center">
                  <div class="btn-group">
                    <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <svg class="icon icon-xxs" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path>
                      </svg>

                      <span class="visually-hidden">Toggle Dropdown</span>
                    </button>
                    <div class="dropdown-menu py-0">
                      <a class="dropdown-item rounded-top" href="${applicationScope.productPage}/${product.id}">
                        <i class="bi bi-eye-fill dropdown-icon text-gray-400 me-2 icon-sm"></i>
                        Chi tiết
                      </a>
                      <a class="dropdown-item text-warning" href="${applicationScope.productPage}/edit/${product.id}">
                        <i class="bi bi-pencil-square dropdown-icon me-2"></i>
                        Chỉnh sửa
                      </a>
                      <a id="btnDelete" class="dropdown-item text-danger rounded-bottom" data-bs-toggle="modal" data-bs-target="#modal-warning" data-id="${product.id}">
                        <i class="bi bi-trash2-fill dropdown-icon me-2"></i>
                        Xoá
                      </a>
                    </div>
                  </div>
                </td>
                --%>
              </tr>
            </c:forEach>
          </tbody>
        </table>

        <div>
          <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
        </div>
      </div>

      <footer class="bg-white rounded shadow py-3 px-4 mb-4 mt-4">
        <div class="row d-flex align-items-center">
          <div class="col-12 col-md-2 col-xl-2 mb-4 mb-md-0">
            <h6 class="mb-0 text-center text-lg-start">Trạng thái đơn hàng</h6>
            <!-- <p class="mb-0 text-center text-lg-start">© 2019-<span class="current-year"></span> <a class="text-primary fw-normal" href="https://themesberg.com" target="_blank">Themesberg</a></p> -->
          </div>
          <div class="col-12 col-md-10 col-xl-10 text-center text-lg-start">
            <!-- List -->
            <form action="${applicationScope.ordersPage }/${order.id}" method="post">
              <ul class="list-inline list-group-flush list-group-borderless text-md-end mb-0">
              	<li class="list-inline-item px-0 px-sm-2">
                  <button class="btn ${order.state == -1 ? 'btn-danger' : '' }" name="state" value="-1">Hủy đơn hàng</button>
                </li>
              
                <li class="list-inline-item px-0 px-sm-2">
                  <button class="btn ${order.state == 0 ? 'btn-info' : '' }" name="state" value="0">Đơn hàng mới đến</button>
                </li>

                <li class="list-inline-item px-0 px-sm-2">
                  <button class="btn ${order.state == 1 ? 'btn-tertiary' : '' }" name="state" value="1">Khách hàng đã xác nhận</button>
                </li>
                <li class="list-inline-item px-0 px-sm-2">
                  <button class="btn ${order.state == 2 ? 'btn-secondary' : '' }" name="state" value="2">Đang xử lý</button>
                </li>
                <li class="list-inline-item px-0 px-sm-2">
                  <button class="btn ${order.state == 3 ? 'btn-success' : '' }" name="state" value="3">Đã hoàn thành</button>
                </li>

                <!--  <li class="list-inline-item px-0 px-sm-2">
	                    <a href="https://themesberg.com/contact">Contact</a>
	                </li> -->
              </ul>
            </form>
          </div>
        </div>
      </footer>

      <!-- ========== All JS files linkup ========= -->
      <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
    </main>

    <!-- ========== All JS files linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

    <!-- ========== Notyf JS linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
  </body>
</html>
