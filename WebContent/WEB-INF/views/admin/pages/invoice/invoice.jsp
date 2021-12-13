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

<jsp:useBean id="pagedListHolder" scope="request"
	type="org.springframework.beans.support.PagedListHolder" />
<c:url
	value="${pagedLink}"
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
                            <li class="breadcrumb-item">Hoá đơn</li>
                            <li class="breadcrumb-item active" aria-current="page"><a href="${requestScope['javax.servlet.forward.request_uri']}">Quản lý</a></li>
                        </ol>
                    </nav>
                    <h2 class="h4">Danh sách hoá đơn</h2>
                    <!-- <p class="mb-0">Trang sản phẩm</p> -->
                </div>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <a href="${applicationScope.addCategoryPage }" class="btn btn-sm btn-secondary d-inline-flex align-items-center">
                        <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                        Thêm hoá đơn
                    </a>
                    <!-- <div class="btn-group ms-2 ms-lg-3">
                        <button type="button" class="btn btn-sm btn-outline-gray-600">Chia sẻ</button>
                        <button type="button" class="btn btn-sm btn-outline-gray-600">Xuất file</button>
                    </div> -->
                </div>
            </div>
            
            <div class="table-settings mb-4">
                <div class="row align-items-center justify-content-between">
                    <div class="col col-md-6 col-lg-3 col-xl-4 ">
                    <form action = "${requestScope['javax.servlet.forward.request_uri']}" method="get">
                        <div class="input-group me-2 me-lg-3 fmxw-300">
                            <input type="text" class="form-control" placeholder="Tìm kiếm" name = "search"/>
                        	<a class="input-group-text" href = "${applicationScope.invoicePage}">
                        		<svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                                </a>

                                <button class="input-group-text" type="submit">
                                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                </button>
                        </div>
                     </form>
                      
                    </div>
                    <!-- <div class="col-4 col-md-2 col-xl-1 ps-md-0 text-end">
                        <div class="dropdown">
                            <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path></svg>
                                <span class="visually-hidden">Toggle Dropdown</span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0">
                                <span class="small ps-3 fw-bold text-dark">Show</span>
                                <a class="dropdown-item d-flex align-items-center fw-bold" href="#">10 <svg class="icon icon-xxs ms-auto" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg></a>
                                <a class="dropdown-item fw-bold" href="#">20</a>
                                <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
				
            <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden">
                <table class="table table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th class="border-gray-200 rounded-start">#</th>
                            <th class="border-gray-200">Loại hoá đơn</th>
                            <th class="border-gray-200">Ngày tạo</th>
                            <th class="border-gray-200">Giờ tạo</th>
                            <th class="border-gray-200">Nhân viên tạo</th>
                            <th class="border-gray-200">Tổng sản phẩm</th>							
                            <th class="border-gray-200">Tổng thành tiền</th>
                            <th class="border-gray-200 rounded-end"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Item -->
                        <c:forEach items="${pagedListHolder.pageList}" var="invoice" varStatus="i">
                        <tr>
                            <td>
                                <a href="${applicationScope.invoicePage}/${invoice.id}" class="fw-bold">
                                    ${invoice.id}
                                </a>
                            </td>
                            <td><span class="fw-normal">${invoice.invoiceType.name}</span></td>
                            <%-- <td><img src="${invoice.image}" width=100 height=100 alt="${invoice.admin.name}"/></td> --%>
                             <td>
	                             <span class="fw-normal text-wrap">
	                            	<fmt:setLocale value="vi_VN" scope="session"/>
	                            	<fmt:parseDate  value="${invoice.date}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
	                            	<fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
	                            </span>
                            </td>
                            <td>
	                             <span class="fw-normal text-wrap">
	                            	<fmt:setLocale value="vi_VN" scope="session"/>
	                            	<fmt:parseDate  value="${invoice.time}"  type="date" pattern="HH:mm:ss" var="parsedTime" />
	                            	<fmt:formatDate value="${parsedTime}" pattern="HH:mm:ss"/>
	                            </span>
                            </td>
                            <td><span class="fw-normal text-wrap">${invoice.admin.firstname}</span></td>
                            <td><span class="fw-normal text-wrap">${invoice.getTotalQuantity()}</span></td>
                            <td><span class="fw-normal">
                            	<fmt:setLocale value="vi_VN" scope="session" />
                              	<fmt:formatNumber value="${invoice.getTotalPrice() }" type="currency" />
                            </span></td>
                            <%-- <td><span class="fw-normal text-wrap">${invoice.admin.name}</span></td> --%>
                            <td class = "text-center">
                                <div class="btn-group">
                                    <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                      	<svg class="icon icon-xxs" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
                                       
                                        <span class="visually-hidden">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu py-0">
                                    	
										<a class="dropdown-item rounded-top" href="${applicationScope.invoicePage}/${invoice.id}">
										<i class="bi bi-eye-fill dropdown-icon text-gray-400 me-2 icon-sm"></i>
										Chi tiết</a>
                                    
                                        
                                        <a class="dropdown-item text-warning" href="${applicationScope.categoryPage}/edit/${category.id}">
	                                        <i class="bi bi-pencil-square dropdown-icon me-2"></i>
	                                        Chỉnh sửa
                                        </a>
                                        
                                        <a id="btnDelete" class="dropdown-item text-danger rounded-bottom" data-bs-toggle="modal" data-bs-target="#modal-warning" data-id="${category.id}">
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
                	<tg:adminPaging pagedListHolder="${pagedListHolder}"
					pagedLink="${pagedLink}" />
                </div>
                
                
            </div>
            
            <!-- Modal Content -->
       <div class="modal fade" id="modal-warning" tabindex="-1" role="dialog" aria-labelledby="modal-warning"
         aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
           <div class="modal-content">
             <div class="modal-header">
               <h2 class="h5 modal-title">Xác nhận</h2>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
             </div>
             <div class="modal-body text-center">
               <h5 class="my-0 mb-2">Bạn có muốn xoá danh mục này?</h5>
               <small class="my-0 mt-4 text-wrap text-gray-500">Hãy chắc chắn danh mục này <span class="fw-bold">không tồn tại</span> sản phẩm nào</small>
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
