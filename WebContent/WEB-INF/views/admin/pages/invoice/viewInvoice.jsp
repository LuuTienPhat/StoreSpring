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
	/* .table td, .table thead th {
        font-size: 11px;
    } */
    /* .card .table td, .card .table th {
    	padding-right: 10px;
    	padding-left: 10px;
    }  */
</style>
</head>

<body>
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
                            <li class="breadcrumb-item">Hoá đơn</li>
                            <li class="breadcrumb-item active" aria-current="page"><a href="${requestScope['javax.servlet.forward.request_uri']}">Hoá đơn ${invoice.id}</a></li>
                        </ol>
                    </nav>
                    <!-- <h2 class="h4">Danh mục sản phẩm</h2> -->
                    <!-- <p class="mb-0">Trang sản phẩm</p> -->
                </div>
                <%-- <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="${applicationScope.addCategoryPage }" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                        <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                        Thêm danh mục
                    </a>
                    <div class="btn-group ms-2 ms-lg-3">
                        <!-- <button type="button" class="btn btn-sm btn-outline-gray-600">Chia sẻ</button> -->
                        <button type="button" class="btn btn-sm btn-outline-gray-600">Xuất file</button>
                    </div>
                </div> --%>
            </div>
            
            <div class="row justify-content-center mb-5">
      <div class="col-12 col-xl-10">
        <div class="card shadow border-0 p-4 p-md-5 position-relative">
          <div class="
                d-flex
                justify-content-between
                pb-4 pb-md-5
                mb-4 mb-md-5
                border-bottom border-light
              ">
            <!-- <img class="image-md" src="fonts/light.svg" height="30" width="30" alt="Rocket Logo" /> -->
            <span class="text-warning">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-asterisk" viewBox="0 0 16 16">
			  <path d="M8 0a1 1 0 0 1 1 1v5.268l4.562-2.634a1 1 0 1 1 1 1.732L10 8l4.562 2.634a1 1 0 1 1-1 1.732L9 9.732V15a1 1 0 1 1-2 0V9.732l-4.562 2.634a1 1 0 1 1-1-1.732L6 8 1.438 5.366a1 1 0 0 1 1-1.732L7 6.268V1a1 1 0 0 1 1-1z"/>
			</svg>
          </span>
            <div>
              <h4>SPRING STORE 21.</h4>
              <ul class="list-group simple-list">
                <!-- <li class="list-group-item fw-normal">
                  7 Le Loi
                </li>
                <li class="list-group-item fw-normal">Quận 1, TPHCM</li> -->
                <li class="list-group-item fw-normal">
                  <a class="fw-bold text-primary" href="#">
                  <span class="__cf_email__"
                      data-cfemail="97f4f8fae7f6f9eed7e3fff2faf2e4f5f2e5f0b9f4f8fa">storespring21@gmail.com</span></a>
                </li>
              </ul>
            </div>
          </div>
          <div class="mb-6 d-flex align-items-center justify-content-center">
            <h2 class="h1 mb-0">Hoá đơn #${invoice.id }</h2>
            <!-- <span class="badge badge-lg bg-success ms-4">Paid</span> -->
          </div>
          <div class="row justify-content-between mb-4 mb-md-5">
            <!-- <div class="col-sm">
              <h5>Thông tin người giao:</h5>
              <div>
                <ul class="list-group simple-list">
                  <li class="list-group-item fw-normal">Henry M. Pike</li>
                  <li class="list-group-item fw-normal">Themesberg LLC</li>
                  <li class="list-group-item fw-normal">
                    311 West Mechanic Lane Middletown, NY 10940
                  </li>
                  <li class="list-group-item fw-normal">
                    <a class="fw-bold text-primary" href="#"><span class="__cf_email__"
                        data-cfemail="9bf5faf6fedbf8f4f6ebfaf5e2b5f8f4f6">[email&#160;protected]</span></a>
                  </li>
                </ul>
              </div>
            </div> -->
            
            <div class="col-sm col-lg-4">
              <dl class="row text-sm-right">
                <dt class="col-6"><strong>Số hoá đơn.</strong></dt>
                <dd class="col-6">${invoice.id }</dd>
                <dt class="col-6"><strong>Ngày lập:</strong></dt>
                <dd class="col-6">
                	<fmt:setLocale value="vi_VN" scope="session"/>
                	<fmt:parseDate  value="${invoice.date}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
	                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                </dd>
                <dt class="col-6"><strong>Giờ tạo:</strong></dt>
                <dd class="col-6">
                	<fmt:setLocale value="vi_VN" scope="session"/>
                	<fmt:parseDate  value="${invoice.time}"  type="date" pattern="HH:mm:ss" var="parsedTime" />
	                <fmt:formatDate value="${parsedTime}" pattern="HH:mm:ss"/>
                </dd>
                
                <!-- <dt class="col-6"><strong>Date Due:</strong></dt>
                <dd class="col-6">30/04/2020</dd> -->
              </dl>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="table-responsive" style=''>
                <table class="table mb-0 table-sm" >
                  <thead class="bg-light border-top">
                    <tr>
                      <th scope="row" class="border-0 text-right">STT</th>
                      <th scope="row" class="border-0">Mã SP</th>
                      <th scope="row" class="border-0">Tên SP</th>
                      <th scope="row" class="border-0 text-right">ĐVT</th>
                      <th scope="row" class="border-0 text-right">SL</th>
                      <th scope="row" class="border-0 text-right">Đơn giá</th>
                      <!-- <th scope="row" class="border-0">%VAT</th> -->
                      <th scope="row" class="border-0">Thành tiền</th>
                      <!-- <th scope="row" class="border-0">Ghi chú</th> -->
                    </tr>
                  </thead>
                  <tbody>
                   <c:forEach items="${invoice.invoiceDetails}" var="invoiceDetail" varStatus="i">
                  	<tr>
                  		<td>${i.count }</td>
                      <td scope="row" class="text-left fw-bold">
                        ${invoiceDetail.product.id }
                      </td>
                      
                      <td class="text-wrap">${invoiceDetail.product.name }</td>
                      <td>${invoiceDetail.product.unit }</td>
                      <td>${invoiceDetail.quantity }</td>
                      <td>
                      	<fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${invoiceDetail.price }" type="currency" />
                      </td>
                      <!-- <td>1</td> -->
                      <td>
                      	<fmt:setLocale value="vi_VN" scope="session" />
                        <fmt:formatNumber value="${invoiceDetail.price * invoiceDetail.quantity }" type="currency" />
                      </td>
                      <!-- <td></td> -->
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
              <div class="d-flex justify-content-end text-right mb-4 py-4">
                <div class="mt-4">
                  <table class="table table-clear">
                    <tbody>
                      <!-- <tr>
                        <td class="left"><strong>Subtotal</strong></td>
                        <td class="right">$8.497,00</td>
                      </tr> -->
                      <!-- <tr>
                        <td class="left"><strong>Discount (20%)</strong></td>
                        <td class="right">$1,699,40</td>
                      </tr> -->
                      <!-- <tr>
                        <td class="left"><strong>VAT (10%)</strong></td>
                        <td class="right">$679,76</td>
                      </tr> -->
                      <tr>
                        <td class="left"><strong>Tổng tiền</strong></td>
                        <td class="right"><strong>
	                        <fmt:setLocale value="vi_VN" scope="session" />
	                        <fmt:formatNumber value="${invoice.getTotalPrice() }" type="currency" />
                        </strong></td>
                      </tr>
                      
                    </tbody>
                  </table>
                </div>
              </div>
              <!-- <h4>Payments to:</h4>
              <span><a href="/cdn-cgi/l/email-protection" class="__cf_email__"
                  data-cfemail="f585948c98909b81b5839a9981db969a98">[email&#160;protected]</a></span> -->
            </div>
          </div>
        </div>
      </div>
             </div>  
             
             <c:if test="${type.equals('preview')}">
             	<%@include file="/WEB-INF/views/admin/pages/invoice/pageNavigation.jsp"%>
             </c:if>
		<%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>

</main>

<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

</body>

<script type="text/javascript">
   		const btnDeletes = document.querySelectorAll("#btnDelete");
   		
   		btnDeletes.forEach(btnDelete => {
   			btnDelete.addEventListener('click', () => {
   	   			let categoryId = btnDelete.dataset.id;
   	   			const btnConfirm = document.querySelector("#btnConfirm");
   	   			btnConfirm.href = "<c:out value='${applicationScope.categoryPage}'/>/delete/" + categoryId;
   	   		})
   		})
   		
   		
   		
   </script>
</html>
