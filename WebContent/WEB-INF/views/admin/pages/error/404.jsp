<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>404 - Không tìm thấy trang</title>
        <!-- ========== Meta Tags ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>
		
        <!-- ========== Favicon linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/favicon.jsp"%>

        <!-- ========== All CSS files linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/styles.jsp"%>
    </head>

<body>
    <main>
        <section class="vh-100 d-flex align-items-center justify-content-center">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center d-flex align-items-center justify-content-center">
                        <div>
                            <img class="img-fluid w-75" src="<c:url value='/resources/admin/assets/img/illustrations/404.svg' />" alt="404 not found">
                            <h1 class="mt-5"><span class="fw-bolder text-primary">Không</span> tìm thấy trang!</h1>
                            <p class="lead my-4">Oops! Có vẻ như bạn đã truy cập vào một liên kết không hợp lệ.</p>
                            <a href="${applicationScope.dashboardPage }" class="btn btn-gray-800 d-inline-flex align-items-center justify-content-center mb-4">
                                <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                                Quay lại trang trước
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
</body>

</html>
