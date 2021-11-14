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
                     <a href="">
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
                  <li class="breadcrumb-item">Hoá đơn</li>
                  <li class="breadcrumb-item active" aria-current="page">
                     <a href="${applicationScope.addInvoicePage }">Tạo hoá đơn</a>
                  </li>
               </ol>
            </nav>
            <div class="d-flex justify-content-between w-100 flex-wrap">
               <div class="mb-3 mb-lg-0">
                  <h1 class="h4">Thêm sản phẩm vào hoá đơn</h1>
                  <!-- <p class="mb-0"></p> -->
               </div>
               <div>
                  <!-- <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/forms/" class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Forms Docs</a> -->
               </div>
            </div>
         </div>

         <div class="row">
         
         <div class="col-12">
         <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden">
         <form action="${applicationScope.invoicePage }/add/update" method="post" >
            <table class="table table-hover table-responsive" id="datatable">
               <thead class="thead-dark">
                  <tr>
                     <th class="border-gray-200 rounded-start">#</th>
                     <th class="border-gray-200">Tên sản phẩm</th>
                     <th class="border-gray-200">Loại</th>
                     <th class="border-gray-200">Hình ảnh</th>
                     <!-- <th class="border-gray-200">Đơn vị tính</th> -->
                     <th class="border-gray-200">Số lượng tồn</th>
                     <th class="border-gray-200">Số lượng nhập</th>
                     <th class="border-gray-200">Đơn giá</th>
                     <!-- <th class="border-gray-200">Mô tả</th> -->
                     <th class="border-gray-200">Thành tiền</th>
                     <!-- <th class="border-gray-200">Ngày thêm</th> -->
                     
                     <th class="border-gray-200 rounded-end"></th>
                  </tr>
               </thead>
               <tbody>
                  <!-- Item -->
                  <c:forEach items="${products}" var="product" varStatus="i">
                   <%-- <c:forEach items="${invoice.invoiceDsetails}" var="invoiceDetail" varStatus="j"> --%>
                  	
                  <input class="form-control d-none" name="product_id" value="${product.id}"/>
                     <tr class="${invoice.hasProduct(product.id) ? 'table-active' : '' }">
                        <td>
                           <a href="${applicationScope.productPage}/${product.id}" class="fw-bold">
                              ${product.id}
                           </a>
                        </td>
                        <td><span class="fw-normal text-wrap">${product.name}</span></td>
                         <td><span class="fw-bold text-danger text-wrap">${product.category.name}</span></td>
                         <td>
                           <span class="fw-normal text-wrap">
                              <img src="${!product.images.isEmpty() ? product.images.get(0).image : ''}" width="100" height="100" alt="${product.name}" />
                           </span>
                        </td>
                        <td><span class="fw-bold text-wrap">${product.quantity}</span></td>
                        <td><span class="fw-bold text-wrap">
                        	<input class="form-control" name="quantity" id="quantity" value="${invoice.getQuantity(product.id) == 0 ? '' : invoice.getQuantity(product.id)}" autofocus/>
                        </span></td>
                        <%-- <td><span class="fw-normal text-wrap">${product.unit}</span></td> --%>
                        <td>
                           <span class="fw-bold text-wrap">
                              <input class="form-control" name="price" id="price" value="${invoice.getPrice(product.id) == 0 ? '' : invoice.getPrice(product.id)}" autofocus/>
                           </span>
                        </td>
                        <td>
                           <span class="fw-bold text-wrap">
                              <input class="form-control" name="price" id="price" value="${invoice.getPrice(product.id)*invoice.getQuantity(product.id) == 0 ? '' : invoice.getPrice(product.id)*invoice.getQuantity(product.id)}" autofocus/>
                           </span>
                        </td>
                        <%-- <td><span class="fw-normal text-wrap">${product.description}</span></td> --%>
                       
                        <%-- <td>
                           <span class="fw-normal text-wrap">
                              <fmt:formatDate value="${product.dateAdded}" pattern="dd/MM/yyyy" />
                           </span>
                        </td> --%>
                        
                        
                        <td>
                           <span class="fw-normal text-wrap">
                              <button class="dropdown-item rounded-top" type="submit">
                                    <i class="bi bi-plus-circle dropdown-icon text-gray-400 me-1 icon-sm"></i>
                                    Cập nhật
                                 </button>
                           </span>
                           <span class="fw-normal text-wrap">
                              <a class="dropdown-item rounded-top" href="${applicationScope.invoicePage }/add/update">
                                    <i class="bi bi-plus-circle dropdown-icon text-gray-400 me-1 icon-sm"></i>
                                    Xoá
                                 </a>
                           </span>
                        </td>
                        
                        <%-- <td class="text-center">
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
                                    Thêm
                                 </a>
                                 <a class="dropdown-item text-warning" href="${applicationScope.productPage}/edit/${product.id}">
                                    <i class="bi bi-pencil-square dropdown-icon me-2"></i>
                                    Chỉnh sửa
                                 </a>
                                 <a id="btnDelete" class="dropdown-item text-danger rounded-bottom" data-bs-toggle="modal" data-bs-target="#modal-add" data-id="${product.id}">
                                    <i class="bi bi-trash2-fill dropdown-icon me-2"></i>
                                    Xoá
                                 </a>
                              </div>
                           </div>
                        </td>
                      --%>
                      </tr>
                  	</c:forEach>
                  <%-- </c:forEach> --%>
               </tbody>
            </table>
            </form>

            <div>
               <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
            </div>
         </div>
         
         </div>
         </div>
         <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
      </main>
      
      <!-- Modal Content -->
       <div class="modal fade" id="modal-add" tabindex="-1" role="dialog" aria-labelledby="modal-add"
         aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
           <div class="modal-content">
             <div class="modal-header">
               <h2 class="h5 modal-title">Xác nhận</h2>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
             </div>
             <div class="modal-body text-center">
               <h5 class="my-0 ">Bạn có muốn xoá sản phẩm này?</h5>
               <!-- <small class="my-0 mt-4 text-wrap">Hãy chắc chắn sản phẩm đó không tồn tại trong các hoá đơn hoặc đơn hàng.</small> -->
             </div>
             <div class="modal-footer">
               <a type="button" class="btn btn-danger" id="btnConfirm" href="">Đồng ý</a>
               <button type="button" class="btn btn-link text-gray-600 ms-auto"
                 data-bs-dismiss="modal">Đóng</button>
             </div>
           </div>
         </div>
       </div>
       <!-- End of Modal Content -->
       
      <!-- ========== All JS files linkup ========= -->
      <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
   </body>
   
   <script>
   axios.get("/StoreSpring/admin/invoices/post").then(res=>console.log(res)).catch(err=>console.log(err));
   </script>
</html>
