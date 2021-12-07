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
                  <h1 class="h4">Tạo hoá đơn</h1>
                  <!-- <p class="mb-0"></p> -->
               </div>
               <div>
                  <!-- <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/forms/" class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Forms Docs</a> -->
               </div>
            </div>
         </div>
         <div class="row mb-4">
            <div class="col-12">
               <div class="card border-0 shadow components-section">
                  <div class="card-body">
                     <div class="row">
                        <div class="col-lg-12 col-sm-12">
                        
                           <form:form action="${requestScope['javax.servlet.forward.request_uri']}" method="POST" enctype="multipart/form-data" modelAttribute="invoice">
                               <div class="row mb-4">
                                 <div class="col-12">
                                    <label for="quantity">Mã hóa đơn</label>
                                    <form:input type="text" class="form-control ${idValid }" path="id" id="id" placeholder="Nhập mã hóa đơn"/>
                                 	<form:errors path="id" class="invalid-feedback"/>
                                 </div>
                              </div>
                               
                               <div class="row mb-4">
                               <div class="col-12">
                                 <label class="" for="invoice">Loại hoá đơn</label>
                                 <form:select path="invoiceType.id"  class="form-select ${invoiceTypeValid }" id="invoice-type">
                                     <form:option value="0">Chọn loại hoá đơn</form:option>
                                     <form:options items="${invoiceTypes}" itemLabel="name" itemValue="id"/>
                                 </form:select>
                                 <form:errors path = "invoiceType.id" class="invalid-feedback"/>
	                          	</div>
	                          </div>
                               
                               <div class="row mb-4">
                                 <div class="col-6">
                                    <label for="productName">Ngày lập</label>
                                    <form:input type="text" class="form-control ${dateValid }" path="date" id="date" placeholder="Nhập ngày lập hoá đơn" data-input="data-input"/>
                                 	<form:errors path="date" class="invalid-feedback"/>
                                 </div>
                                 <div class="col-6">
                                    <label for="quantity">Thời gian lập</label>
                                    <form:input type="text" class="form-control ${timeValid }" path="time" id="time" placeholder="Nhập giờ lập hoá đơn" data-input="data-input"/>
                                 	<form:errors path="time" class="invalid-feedback"/>
                                 </div>
                              </div>
                              
                             <%-- <div class="row mb-4">
	                              <div class="col-6">
	                                 <label for="unit">Đơn vị tính</label>
	                                 <form:input type="unit" value="cái" class="form-control" path="unit" id="unit" placeholder="Nhập đơn vị tính" />
	                              </div>
	                              <div class="col-6">
                                 <label for="price">Giá tiền</label>
                                 <form:input value="0" type="price" class="form-control ${priceValid }" path="price" id="price" aria-describedby="priceHelp" placeholder="50000" />
                              	<form:errors path="price" class="invalid-feedback"/>
                              </div>
	                              
                              </div>
                              
                              
                              
                              <div class="mb-4">
                                 <label for="textarea">Mô tả</label>
                                 <form:textarea class="form-control" placeholder="Nhập mô tả" id="textarea" rows="4" path="description"></form:textarea>
                              </div>
                              
                              <div class="mb-4 d-flex overflow-auto" id="preview-images" ></div>
                              
                              <div class="mb-4">
                                 <label for="formFile" class="form-label">Chọn file hình ảnh</label>
                                 <form:input class="form-control" type="file" id="images" path="images" accept="image/*" multiple="multiple" />
                                 <small class="form-text text-muted">Chỉ nhận file ảnh, kích thước tối đa 20MB</small>
                              </div>
                              
                              <script>
			                 	var previewImage = document.getElementById("preview-images");
			                 	var imageUpload = document.getElementById("images");
			                 	imageUpload.onchange = evt => {
			                 		  //const [file] = imageUpload.files
			                 		  let imgElement = "";
			                 		  for(let file of imageUpload.files) {
				                 		  if (file) {
				                 			  imgElement += "<img src='"+ URL.createObjectURL(file) + "' width='200' height='200' class='img-fluid img-thumbnail me-2' />";
				                 		  }
			                 		  }
			                 		 previewImage.innerHTML = imgElement;
			                 		}
			                 </script> --%>
                              <!-- <div class="">
                                 <button class="btn btn-primary my-0" type="submit">Chọn sản phẩm</button>
                              </div> -->
                           
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         	</div>  
         	
         	<%@include file="/WEB-INF/views/admin/pages/invoice/pageNavigation.jsp"%>
         	
         </form:form>
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
      
      <!-- ========== Notyf JS linkup ========= -->
  <%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
   </body>
   
   <script type="text/javascript">
   const datePicker = flatpickr("#date", {
	   locale: "vn",
	   allowInput: true,
	   enableTime: false,
	   firstDayOfWeek: 1,
	   dateFormat: "Y-m-d",
	   altInput: true,
	   altFormat: "d/m/Y",
   });
   
   const timePicker = flatpickr("#time", {
	   locale: "vn",
	   allowInput: true,
	   noCalendar: true,
	   enableTime: true,
	   altInput: true,
	   altFormat: "H:i:S",
	   dateFormat: "H:i:S",
	   time_24hr: true,
	   enableSeconds: true,
   });
   
   </script>
</html>
