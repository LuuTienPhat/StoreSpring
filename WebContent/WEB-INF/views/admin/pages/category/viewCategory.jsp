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
          <li class="breadcrumb-item">Danh mục</li>
          <li class="breadcrumb-item active" aria-current="page"><a href="${requestScope['javax.servlet.forward.request_uri']}" >${category.id }</a></li>
        </ol>
      </nav>
      <div class="d-flex justify-content-between w-100 flex-wrap">
        <div class="mb-3 mb-lg-0">
          <h1 class="h4">Thông tin danh mục </h1>
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
                <img src="${category.image }" class="img-fluid" style="height: 100%;" />
              </div>

              <div class="d-flex col-md-9 flex-md-row col-sm-8 flex-column mt-2">
                <div class="col-md-10 col-12 d-flex flex-column justify-content-center">
                  <div class="">
                    <h3 class="fw-extrabold  mb-0"> ${category.name }</h3>
                    <p class="text-gray-400 mb-2">
                    	${!category.description ? "Không có mô tả cho danh mục" : category.description}
                    </p>
                  </div>
                  
                  <div class="d-flex mt-1">
                  <div>
                  <span class="small text-gray-500">Ngày thêm:</span>
                  <span class="fw-normal">18/10/2021</span>
                  </div>
                  </div>
                  
                  <div class=" d-flex mt-1">
                    <div>
                    <span class="small text-gray-500">Số lượng sản phẩm thuộc danh mục:</span>
                    <span class="text-success fw-bolder fs-6">${category.products.size() }</span>
                    </div>
                  </div>
                </div>

                <div class="col-md-2 col-12 mt-2 d-flex flex-column">
                  <button class="btn btn-block btn-gray-800 mb-3 ">
                    Chỉnh sửa <i class="icon i"></i>
                  </button>

                  <!-- Button Delete -->
                  <button class="btn btn-block btn-danger mb-3" data-bs-toggle="modal" data-bs-target="#modal-warning">
                    Xoá
                  </button>
                  
                  <!-- Modal Content -->
                  <div class="modal fade" id="modal-warning" tabindex="-1" role="dialog" aria-labelledby="modal-warning"
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
                  </div>
                  <!-- End of Modal Content -->
                  
                </div>
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
          <h1 class="h4">Danh sách các sản phẩm</h1>
          <p class="mb-0 text-gray-400">Các sản phẩm thuộc danh mục</p>
        </div>
      </div>

	<%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

      <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder" />
      <c:url value="${requestScope['javax.servlet.forward.request_uri']}" var="pagedLink">
         <c:param name="p" value="~" />
      </c:url>

	 <div class="table-settings mb-4">
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
         </div>

         <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden">
            <table class="table table-hover table-responsive" id="datatable">
               <thead class="thead-dark">
                  <tr>
                     <th class="border-gray-200 rounded-start">#</th>
                     <th class="border-gray-200">Tên sản phẩm</th>
                     <th class="border-gray-200">Số lượng</th>
                     <th class="border-gray-200">Đơn vị tính</th>
                     <th class="border-gray-200">Giá</th>
                     <th class="border-gray-200">Mô tả</th>
                     <th class="border-gray-200">Loại</th>
                     <th class="border-gray-200">Ngày thêm</th>
                     <th class="border-gray-200">Hình ảnh</th>
                     <th class="border-gray-200 rounded-end"></th>
                  </tr>
               </thead>
               <tbody>
                  <!-- Item -->
                  <c:forEach items="${category.products}" var="product">
                     <tr>
                        <td>
                           <a href="${applicationScope.productPage}/${product.id}" class="fw-bold">
                              ${product.id}
                           </a>
                        </td>
                        <td><span class="fw-normal text-wrap">${product.name}</span></td>
                        <td><span class="fw-bold text-wrap">${product.quantity}</span></td>
                        <td><span class="fw-normal text-wrap">${product.unit}</span></td>
                        <td>
                           <span class="fw-bold text-wrap">
                              <fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${product.price}" type="currency" />
                           </span>
                        </td>
                        <td><span class="fw-normal text-wrap">${product.description}</span></td>
                        <td><span class="fw-bold text-danger text-wrap">${product.category.name}</span></td>
                        <td>
                           <span class="fw-normal text-wrap">
                              <fmt:formatDate value="${product.dateAdded}" pattern="dd/MM/yyyy" />
                           </span>
                        </td>
                        <td>
                           <span class="fw-normal text-wrap">
                              <img src="${!product.images.isEmpty() ? product.images.get(0).image : ''}" width="100" height="100" alt="${product.name}" />
                           </span>
                        </td>
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
                     </tr>
                  </c:forEach>
               </tbody>
            </table>

            <div>
               <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
            </div>
         </div>
	     
    </div>
		
		<%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
     </main>
	
	<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

</body>

</html>