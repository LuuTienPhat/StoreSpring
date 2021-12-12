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
          <li class="breadcrumb-item"><a href="${applicationScope.productPage }">Sản phẩm</a></li>
          <li class="breadcrumb-item active" aria-current="page">${product.id}</li>
        </ol>
      </nav>
      <div class="d-flex justify-content-between w-100 flex-wrap">
        <div class="mb-3 mb-lg-0">
          <h1 class="h4">Thông tin sản phẩm</h1>
          <!-- <p class="mb-0">Dozens of reusable components built to provide buttons, alerts, popovers, and more.</p> -->
        </div>
        <!-- <div>
          <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/modals/"
            class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Modals Docs</a>
        </div> -->
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <div class="card border-0 shadow">
          <div class="card-body">
            <div class="row d-flex">
              <!-- <div class="icon-shape icon-shape-tertiary rounded me-4 me-sm-0">
                  <svg class="icon" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z"
                      clip-rule="evenodd"></path>
                  </svg>
                </div> -->
              <div class=" col-md-3 col-sm-4 col-12">
                <c:choose>
                	<c:when test="${product.images.size() != 0 }">
              			<img src="${product.images[0].image }" class="img-fluid" style="height: 100%;" alt="${product.name}" />  		
                	</c:when>
                	<c:otherwise>
                		<img src="" class="img-fluid" alt="${product.name}" style="height: 100%;" />  		
                	</c:otherwise>
                </c:choose>
              </div>

              <div class="d-flex col-md-9 flex-md-row col-sm-8 flex-column mt-2">
                <div class="col-md-10 col-12 d-flex flex-column justify-content-center">
                  <div class="">
                    <h3 class="fw-extrabold  mb-0"> ${product.name }</h3>
                    <p class="text-gray-400 mb-2">
                    	${!product.description ? "Không có mô tả cho sản phẩm" : product.description}
                    </p>
                  </div>
                  
                  <div class="d-flex mt-1">
                  <div>
                  <span class="small text-info">Lượt xem:</span>
                  <span class="fw-normal">
                  	${product.views }
                  </span>
                  </div>
                  </div>
                  
                  <div class="d-flex mt-1">
                  <div>
                  <span class="small text-danger">Yêu thích:</span>
                  <span class="fw-normal">
                  	${product.favoriteProducts.size() }
                  </span>
                  </div>
                  </div>
                  
                  <div class="d-flex mt-1">
                  <div>
                  <span class="small text-gray-500">Ngày thêm:</span>
                  <span class="fw-normal">
                  	<fmt:setLocale value="vi_VN" scope="session"/>
                     	<fmt:formatDate value="${product.dateAdded}" pattern="dd/MM/yyyy"/>
                  </span>
                  </div>
                  </div>
                  
                  <div class=" d-flex mt-1">
                    <div>
                    <span class="small text-gray-500">Số lượng sản phẩm thuộc danh mục:</span>
                    <span class="text-success fw-bolder fs-6"></span>
                    </div>
                  </div>
                </div>

                <div class="col-md-2 col-12 mt-2 d-flex flex-column">
                  <a href="${applicationScope.productPage }/edit/${product.id}" class="btn btn-block btn-gray-800 mb-3 d-inline-flex align-items-center justify-content-center">
                  <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
	                                 
                    Chỉnh sửa
                  </a>

                  <!-- Button Delete -->
                  <button id="btn-delete" data-id="${product.id }" class="btn btn-block btn-danger mb-3 d-inline-flex align-items-center justify-content-center" data-bs-toggle="modal" data-bs-target="#modal-warning">
                     <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>           
                    Xoá
                  </button>
                  <!-- Modal Content -->
                  <!-- <div class="modal fade" id="modal-warning" tabindex="-1" role="dialog" aria-labelledby="modal-warning"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h2 class="h5 modal-title">Bạn có muốn xoá không</h2>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <p>Nếu bạn xoá danh mục thì các sản phẩm có thể bị <span class="fw-bolder">ảnh hưởng</span>.
                          </p>
                          <p>Hãy chắc chắn danh mục đó không tồn tại sản phẩm nào!</p>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-danger">Đồng ý</button>
                          <button type="button" class="btn btn-link text-gray-600 ms-auto"
                            data-bs-dismiss="modal">Close</button>
                        </div>
                      </div>
                    </div>
                  </div> -->
                  <!-- End of Modal Content -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <hr class="mt-4">

    <!-- <div class="row mt-4">

      <div class="py-4 d-flex justify-content-between w-100 flex-wrap">
        <div class="mb-3 mb-lg-0">
          <h1 class="h4">Danh sách các sản phẩm</h1>
          <p class="mb-0 text-gray-400">Các sản phẩm thuộc danh mục</p>
        </div>
      </div>

      <div class="table-settings mb-4">
        <div class="row align-items-center justify-content-between">
          <div class="col col-md-6 col-lg-3 col-xl-4">
            <div class="input-group me-2 me-lg-3 fmxw-400">
              <span class="input-group-text">
                <svg class="icon icon-xs" x-description="Heroicon name: solid/search" xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                  <path fill-rule="evenodd"
                    d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                    clip-rule="evenodd"></path>
                </svg>
              </span>
              <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm">
            </div>
          </div>
          <div class="col-4 col-md-2 col-xl-1 ps-md-0 text-end">
            <div class="dropdown">
              <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1"
                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd"
                    d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                    clip-rule="evenodd"></path>
                </svg>
                <span class="visually-hidden">Toggle Dropdown</span>
              </button>
              <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0">
                <span class="small ps-3 fw-bold text-dark">Show</span>
                <a class="dropdown-item d-flex align-items-center fw-bold" href="#">10 <svg
                    class="icon icon-xxs ms-auto" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                      clip-rule="evenodd"></path>
                  </svg></a>
                <a class="dropdown-item fw-bold" href="#">20</a>
                <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="card card-body border-0 shadow table-wrapper table-responsive">
        <table class="table table-hover">
          <thead class="thead-dark">
            <tr>
              <th class="border-0 rounded-start">#</th>
              <th class="border-0">Bill For</th>
              <th class="border-0">Issue Date</th>
              <th class="border-0">Due Date</th>
              <th class="border-0">Total</th>
              <th class="border-0 ">Status</th>
              <th class="border-0 rounded-end"></th>
            </tr>
          </thead>
          <tbody>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456478
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 May 2020</span></td>
              <td><span class="fw-normal">1 Jun 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-warning">Due</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456423
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Apr 2020</span></td>
              <td><span class="fw-normal">1 May 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456420
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Mar 2020</span></td>
              <td><span class="fw-normal">1 Apr 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456421
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Feb 2020</span></td>
              <td><span class="fw-normal">1 Mar 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456420
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Jan 2020</span></td>
              <td><span class="fw-normal">1 Feb 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456479
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Dec 2019</span></td>
              <td><span class="fw-normal">1 Jan 2020</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456478
                </a>
              </td>
              <td>
                <span class="fw-normal">Platinum Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Nov 2019</span></td>
              <td><span class="fw-normal">1 Dec 2019</span></td>
              <td><span class="fw-bold">$799,00</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  453673
                </a>
              </td>
              <td>
                <span class="fw-normal">Gold Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Oct 2019</span></td>
              <td><span class="fw-normal">1 Nov 2019</span></td>
              <td><span class="fw-bold">$533,42</span></td>
              <td><span class="fw-bold text-danger">Cancelled</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456468
                </a>
              </td>
              <td>
                <span class="fw-normal">Gold Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Sep 2019</span></td>
              <td><span class="fw-normal">1 Oct 2019</span></td>
              <td><span class="fw-bold">$533,42</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
            Item
            <tr>
              <td>
                <a href="#" class="fw-bold">
                  456478
                </a>
              </td>
              <td>
                <span class="fw-normal">Flexible Subscription Plan</span>
              </td>
              <td><span class="fw-normal">1 Aug 2019</span></td>
              <td><span class="fw-normal">1 Sep 2019</span></td>
              <td><span class="fw-bold">$233,42</span></td>
              <td><span class="fw-bold text-success">Paid</span></td>
              <td>
                <div class="btn-group">
                  <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0"
                    data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="icon icon-sm">
                      <span class="fas fa-ellipsis-h icon-dark"></span>
                    </span>
                    <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <div class="dropdown-menu py-0">
                    <a class="dropdown-item rounded-top" href="#"><span class="fas fa-eye me-2"></span>View Details</a>
                    <a class="dropdown-item" href="#"><span class="fas fa-edit me-2"></span>Edit</a>
                    <a class="dropdown-item text-danger rounded-bottom" href="#"><span
                        class="fas fa-trash-alt me-2"></span>Remove</a>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div
          class="card-footer px-3 border-0 d-flex flex-column flex-lg-row align-items-center justify-content-between">
          <nav aria-label="Page navigation example">
            <ul class="pagination mb-0">
              <li class="page-item">
                <a class="page-link" href="#">Previous</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="#">2</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">3</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">4</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">5</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="#">Next</a>
              </li>
            </ul>
          </nav>
          <div class="fw-normal small mt-4 mt-lg-0">Showing <b>5</b> out of <b>25</b> entries</div>
        </div>
      </div>

    </div> -->
	<%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
     </main>
	
	<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

<!-- ========== Modal warning linkup ========= -->
 <%@include file="/WEB-INF/views/admin/pages/product/deleteProductModal.jsp"%>
 
  <script type="text/javascript">
	const btnDelete = document.querySelector("#btn-delete");
	
	btnDelete.addEventListener('click', () => {
			let id = btnDelete.dataset.id;
			const btnConfirm = document.querySelector("#btnConfirm");
			btnConfirm.href = "<c:out value='${applicationScope.productPage}'/>/delete/" + id;
		})
 </script>

</body>

</html>