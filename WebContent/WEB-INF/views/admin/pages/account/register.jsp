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
      
	<form:form action="${applicationScope.registerPage }" method="post" modelAttribute="newAdmin" enctype="multipart/form-data">
      <div class="row">
        <div class="col-12 col-xl-8">
          <div class="card card-body border-0 shadow mb-4">
            <h2 class="h5 mb-4">Thông tin chung</h2>
			
            <div class="row">
              <div class="col-md-6 mb-3">
                <div>
                  <label for="lastname">Họ</label>
                  <form:input path="lastname" class="form-control ${lastnameValid }" id="lastname" type="text" placeholder="Nhập họ" />
                  <form:errors path="lastname" class="invalid-feedback" />
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <div>
                  <label for="firstname">Tên</label>
                  <form:input class="form-control ${firstnameValid }" path="firstname" id="firstname" type="text" placeholder="Nhập tên" />
                  <form:errors path="firstname" class="invalid-feedback" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="birthday">Ngày sinh</label>
                <div class="input-group">
                  <span class="input-group-text">
                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                  </span>
                  <form:input type="text" class="form-control ${birthdayValid }" path="birthday" id="birthday" placeholder="Nhập ngày tháng năm sinh" data-input="data-input" />
                  <form:errors path="birthday" class="invalid-feedback" />
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="gender">Giới tính</label>
                <form:select class="form-select mb-0 ${genderValid }" id="gender" path="gender" aria-label="Gender select example">
                  <form:option value="">...</form:option>
                  <form:option value="0" selected="${admin.gender.equals('0') ? 'selected' : '' }">Nam</form:option>
                  <form:option value="1" selected="${admin.gender.equals('1') ? 'selected' : '' }">Nữ</form:option>
                </form:select>
                <form:errors path="gender" class="invalid-feedback" />
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 mb-3">
                  <label for="email">Email</label>
                  <div class="input-group">
                  <span class="input-group-text">
                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path></svg>
                  </span>
                  <form:input class="form-control ${emailValid }" path="email" id="email" type="email" placeholder="name@company.com" />
                  <form:errors path="email" class="invalid-feedback" />
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="phone">Số điện thoại</label>
                <div class="input-group">
                	<span class="input-group-text">
                    <svg class="icon icon-xs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path></svg>
                  </span>
                	<form:input class="form-control ${phoneValid }" path="phone" id="phone" type="text" placeholder="Nhập số điện thoại" />
                  <form:errors path="phone" class="invalid-feedback" />
                </div>
              
              </div>
            </div>

            <div class="row">
              <div class="col-sm-12 mb-3">
                <div class="form-group">
                  <label for="address">Địa chỉ</label>
                  <form:input class="form-control" path="address" id="address" type="text" placeholder="Nhập địa chỉ nhà" />
                </div>
              </div>
            </div>
          </div>
          
          <div class="card card-body border-0 shadow">
            <h2 class="h5 mb-4">Tài khoản</h2>
			
            <div class="row">
              <div class="col-md-12 mb-3">
                <div>
                  <label for="lastname">Tên đăng nhập</label>
                  <form:input path="account.username" class="form-control ${usernameValid }" id="lastname" type="text" placeholder="Nhập tên đăng nhập" />
                  <form:errors path="account.username" class="invalid-feedback" />
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <div>
                  <label for="firstname">Mật khẩu</label>
                  <form:input class="form-control ${passwordValid }" path="account.password" id="firstname" type="text" placeholder="Nhập mật khẩu" />
                  <form:errors path="account.password" class="invalid-feedback" />
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <div>
                  <label for="firstname">Nhập lại mật khẩu</label>
                  <input class="form-control ${rePasswordValid }" name="rePassword" id="firstname" type="text" placeholder="Nhập lại mật khẩu" />
                  <div class="invalid-feedback">Mật khẩu không trùng khớp</div>
                </div>
              </div>
            </div>
            <div class="mt-3">
              <button class="btn btn-gray-800 mt-2 animate-up-2" type="submit">Lưu thông tin</button>
            </div>
          </div>
          
        </div>
        <div class="col-12 col-xl-4">
          <div class="row">
            <div class="col-12 mb-4">
              <div class="card shadow border-0 text-center p-0">
                <div class="rounded-top profile-cover overflow-hidden">
                  <img src="${newAdmin.cover}" class="image-fluid" alt="${admin.firstname}" id="preview-cover" />
                </div>
                <div class="card-body">
                  <img src="${newAdmin.image}" id="preview-image" class="avatar-xl rounded-circle mx-auto mt-n7 mb-4" alt="${admin.firstname }" />
                  <h4 class="h3">${newAdmin.lastname } ${newAdmin.firstname }</h4>
                  <h5 class="fw-normal">Quản trị viên</h5>
                  <p class="text-gray my-0">${newAdmin.email }</p>
                  <p class="text-gray mb-4">${newAdmin.phone }</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-12">
              <div class="card card-body border-0 shadow mb-4">
                <h2 class="h5 mb-4">Chọn hình đại diện</h2>
                <div class="d-flex align-items-center">

                  <div class="file-field">
                    <div class="d-flex justify-content-xl-center ms-xl-3">
                      <div class="d-flex">
                        <svg class="icon text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                          <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd"></path>
                        </svg>
                        <form:input type="file" path="image" id="upload-image" />
                        <div class="d-md-block text-left">
                          <div class="fw-normal text-dark mb-1">Chọn hình</div>
                          <div class="text-gray small">JPG, GIF hoặc PNG. Tối đa 2MB</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-12">
              <div class="card card-body border-0 shadow">
                <h2 class="h5 mb-4">Chọn hình bìa</h2>
                <div class="d-flex align-items-center">
                  <div class="file-field">
                    <div class="d-flex justify-content-xl-center ms-xl-3">
                      <div class="d-flex">
                        <svg class="icon text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                          <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd"></path>
                        </svg>
                        <form:input type="file" path="cover" id="upload-cover" />
                        <div class="d-md-block text-left">
                          <div class="fw-normal text-dark mb-1">Chọn hình</div>
                          <div class="text-gray small">JPG, GIF hoặc PNG. Tối đa 2MB</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      </form:form>
      <!-- ========== footer ========= -->
      <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
    </main>

    <script type="text/javascript">
      const datePicker = flatpickr("#birthday", {
        locale: "vn",
        allowInput: true,
        enableTime: false,
        firstDayOfWeek: 1,
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "d/m/Y",
      });
    </script>

    <!-- ========== All JS files linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>

    <!-- ========== Notyf JS linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>

    <script>
      var previewImage = document.getElementById("preview-image");
      var uploadImage = document.getElementById("upload-image");
      uploadImage.onchange = (evt) => {
        const [file] = uploadImage.files;
        if (file) {
          previewImage.src = URL.createObjectURL(file);
        }
      };

      var previewCover = document.getElementById("preview-cover");
      var uploadCover = document.getElementById("upload-cover");
      uploadCover.onchange = (evt) => {
        const [file] = uploadCover.files;
        if (file) {
          previewCover.src = URL.createObjectURL(file);
        }
      };
    </script>
  </body>
</html>
