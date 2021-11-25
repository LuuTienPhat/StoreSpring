<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>500 - Lỗi Server</title>
        <!-- ========== Meta Tags ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>
        <!-- ========== Favicon linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/favicon.jsp"%>

        <!-- ========== All CSS files linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/header/styles.jsp"%>
    </head>

<body>

    <!-- NOTICE: You can use the _analytics.html partial to include production code specific code & trackers -->
    

    <main>
        <section class="vh-100 d-flex align-items-center justify-content-center">
            <div class="container">
                <div class="row align-items-center ">
                    <div class="col-12 col-lg-5 order-2 order-lg-1 text-center text-lg-left">
                        <h1 class="mt-5">Đã xảy ra sự cố <span class="text-primary fw-bolder">nghiêm trọng</span>!</h1>
                        <p class="lead my-4">Hãy thư giãn một chút, đi uống cà phê hoặc làm gì đó. Hệ thống sẽ quay lại trong thời gian sớm thôi.</p>
                        <a href="${applicationScope.dashboardPage }" class="btn btn-gray-800 d-inline-flex align-items-center justify-content-center mb-4">
                            <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                            Quay lại trang trước
                        </a>
                    </div>
                    <div class="col-12 col-lg-7 order-1 order-lg-2 text-center d-flex align-items-center justify-content-center">
                        <img class="img-fluid w-75" src="<c:url value='/resources/admin/assets/img/illustrations/500.svg' />" alt="500 Server Error">
                    </div>
                </div>
            </div>
        </section>
    </main>

<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
</body>

</html>
