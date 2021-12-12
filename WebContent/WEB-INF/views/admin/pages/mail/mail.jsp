<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    <script src="<c:url value='/resources/admin/vendor/ckeditor/ckeditor.js' />"></script>
  </head>

  <body>
    <%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>
    <main class="content">
      <%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>

      <div class="py-4">
        <nav aria-label="breadcrumb" class="d-none d-md-inline-block">
          <ol class="breadcrumb breadcrumb-dark breadcrumb-transparent">
            <li class="breadcrumb-item">
              <a href="${applicationScope.dashboardPage }">
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
            <li class="breadcrumb-item active">Mail</li>
            <!-- <li class="breadcrumb-item active" aria-current="page">Thêm
						danh mục</li> -->
          </ol>
        </nav>
        <div class="d-flex justify-content-between w-100 flex-wrap">
          <div class="mb-3 mb-lg-0">
            <h1 class="h4">${title }</h1>
            <p class="mb-0 text-gray-400"></p>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-12">
          <div class="card border-0 shadow components-section">
            <div class="card-body">
              <div class="row">
                <div class="col-lg-12 col-sm-12">
                  <form:form action="${applicationScope.mailPage }/send" modelAttribute="mail" method="POST" enctype="multipart/form-data">
                    <div class="mb-4">
                      <label for="email">Người nhận</label>
                      <div class="input-group">
                        <span class="input-group-text">
                          <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                          </svg>
                        </span>
                        <form:input class="form-control ${emailValid }" label="${email}" type="email" path="email" placeholder="Nhập địa chỉ email nhận" id="email" aria-describedby="emailHelp" />
                        <form:errors path="email" class="invalid-feedback"></form:errors>
                      </div>
                    </div>

                    <div class="mb-4">
                      <label for="subject">Tựa đề</label>
                      <form:input type="text" path="subject" placeholder="Nhập tựa đề" class="form-control ${subjectValid }" id="subject" />
                      <form:errors path="subject" class="invalid-feedback"></form:errors>
                    </div>

                    <div class="mb-4">
                      <label for="body">Nội dung</label>
                      <form:textarea class="form-control ${bodyValid }" rows="6" path="body"></form:textarea>
                      <form:errors path="body" class="invalid-feedback"></form:errors>
                    </div>

                    <div class="">
                      <button class="btn btn-primary d-inline-flex align-items-center" type="submit">
                        Gửi
                        <svg class="icon icon-xs ms-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7"></path>
                        </svg>
                      </button>
                    </div>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
    </main>
    <!-- ========== All JS files linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

    <script>
      CKEDITOR.replace("body", {
        language: "vi",
      });
    </script>

    <!-- ========== Notyf JS linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
  </body>
</html>
