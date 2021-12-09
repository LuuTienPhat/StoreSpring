<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>

  <!-- ========== Meta Tags ========= -->
  <%@include file="/WEB-INF/views/admin/includes/header/head.jsp" %>

  <!-- ========== Favicon linkup ========= -->
  <%@include file="/WEB-INF/views/admin/includes/header/favicon.jsp" %>

  <!-- ========== All CSS files linkup ========= -->
  <%@include file="/WEB-INF/views/admin/includes/header/styles.jsp" %>

</head>

<body>
    <main>

        <!-- Section -->
        <section class="vh-lg-100 mt-5 mt-lg-0 bg-soft d-flex align-items-center">
            <div class="container">
                <div class="row justify-content-center form-bg-image">
                    <p class="text-center"><a href="${applicationScope.loginPage }" class="d-flex align-items-center justify-content-center">
                        <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                        Quay lại trang đăng nhập
                        </a>
                    </p>
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="signin-inner my-3 my-lg-0 bg-white shadow border-0 rounded p-4 p-lg-5 w-100 fmxw-500">
                            <h1 class="h3">Bạn quên mật khẩu?</h1>
                            <p class="mb-4">Đừng lo lắng! Hãy điền đầy đủ thông tin dưới đây và chúng tôi sẽ gửi mã không phục mật khẩu cho bạn.</p>
                            <form:form action="${applicationScope.forgotPasswordPage }" modelAttribute="admin" method="post">
                                <!-- Form -->
                                <div class="mb-4">
                                    <label for="id">Admin ID</label>
                                    <div class="input-group">
                                        <form:input path="id" type="id" class="form-control ${idValid }" id="id" placeholder="Nhập mã admin..." autofocus="autofocus"  />
                                    	<form:errors path="id" class="invalid-feedback" />
                                    </div>  
                                </div>
                                
                                <div class="mb-4">
                                    <label for="username">Username</label>
                                    <div class="input-group">
                                        <form:input path="account.username" type="text" class="form-control ${usernameValid }" id="username" placeholder="Nhập tên đăng nhập..." autofocus="autofocus" />
                                    	<form:errors path="account.username" class="invalid-feedback" />
                                    </div>  
                                </div>
                                
                                <div class="mb-4">
                                    <label for="email">Email</label>
                                    <div class="input-group">
                                        <form:input path="email" type="email" class="form-control ${emailValid }" id="email" placeholder="john@company.com" autofocus="autofocus" />
                                    	<form:errors path="email" class="invalid-feedback" />
                                    </div>  
                                </div>
                                <!-- End of Form -->
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-gray-800">Lấy mã khôi phục</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp" %>

<!-- ========== Notyf JS linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
    
</body>

</html>
