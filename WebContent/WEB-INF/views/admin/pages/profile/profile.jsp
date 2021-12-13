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
           
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center py-4">
                <div>
                    <div class="dropdown">
					  <button class="btn btn-secondary d-inline-flex align-items-center me-3 dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
					    </svg>
					    Thêm mới
					  </button>
					  <div class="dropdown-menu dashboard-dropdown dropdown-menu-start mt-2 py-1">
					    <a class="dropdown-item d-flex align-items-center" href="${applicationScope.addCategoryPage }">
					      <svg class="dropdown-icon text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"></path>
					      </svg>
					      Danh mục
					    </a>
					    <a class="dropdown-item d-flex align-items-center" href="${applicationScope.addProductPage }">
					      <svg class="dropdown-icon text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
					      </svg>
					      Sản phẩm
					    </a>
					    <a class="dropdown-item d-flex align-items-center" href="${applicationScope.addInvoicePage }">
					      <svg class="dropdown-icon text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
					        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 14l6-6m-5.5.5h.01m4.99 5h.01M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16l3.5-2 3.5 2 3.5-2 3.5 2zM10 8.5a.5.5 0 11-1 0 .5.5 0 011 0zm5 5a.5.5 0 11-1 0 .5.5 0 011 0z"></path>
					      </svg>
					      Hoá đơn
					    </a>
					    <div role="separator" class="dropdown-divider my-1"></div>
					    <a class="dropdown-item d-flex align-items-center" href="${applicationScope.registerPage }">
					      <svg class="dropdown-icon text-danger me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
					        <path d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z"></path>
					      </svg>
					      Quản trị viên
					    </a>
					  </div>
					</div>
                </div>
                <!-- <div>
                    <button type="button" class="btn btn-gray-800 d-inline-flex align-items-center me-2">
                        <svg class="icon icon-xs" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                    </button>
                    <button class="btn btn-gray-800 d-inline-flex align-items-center dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path><path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"></path></svg>
                        Reports
                        <svg class="icon icon-xs ms-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                    </button>
                    <div class="dropdown-menu dashboard-dropdown dropdown-menu-start mt-2 py-1">
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M4 3a2 2 0 100 4h12a2 2 0 100-4H4z"></path><path fill-rule="evenodd" d="M3 8h14v7a2 2 0 01-2 2H5a2 2 0 01-2-2V8zm5 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
                            Products
                        </a>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"></path></svg>                            
                            Customers
                        </a>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zm2 5V6a2 2 0 10-4 0v1h4zm-6 3a1 1 0 112 0 1 1 0 01-2 0zm7-1a1 1 0 100 2 1 1 0 000-2z" clip-rule="evenodd"></path></svg>
                            Orders
                        </a>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11 4a1 1 0 10-2 0v4a1 1 0 102 0V7zm-3 1a1 1 0 10-2 0v3a1 1 0 102 0V8zM8 9a1 1 0 00-2 0v2a1 1 0 102 0V9z" clip-rule="evenodd"></path></svg>
                            Console
                        </a>
                        <div role="separator" class="dropdown-divider my-1"></div>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <svg class="dropdown-icon text-gray-800 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"></path><path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"></path></svg>
                            All Reports
                        </a>
                    </div>
                </div> -->
            </div>
            
            <div class="row">
                <div class="col-12 col-xl-8">
                    <div class="card card-body border-0 shadow mb-4">
                        <h2 class="h5 mb-4">Thông tin chung</h2>
                        <form:form action="${applicationScope.profilePage }" method="post" modelAttribute="modifiedAdmin" enctype="multipart/form-data">
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
                            <div class="row align-items-center">
                                <div class="col-md-6 mb-3">
                                    <label for="birthday">Ngày sinh</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <svg class="icon icon-xs" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                                        </span>
                                        <form:input type="text" class="form-control ${birthdayValid }" path="birthday" id="birthday" placeholder="Nhập ngày tháng năm sinh" data-input="data-input"/>                                    
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
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <form:input class="form-control ${emailValid }" path="email" id="email" type="email" placeholder="name@company.com" />
                                    	<form:errors path="email" class="invalid-feedback" />
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="form-group">
                                        <label for="phone">Số điện thoại</label>
                                        <form:input class="form-control ${phoneValid }" path="phone" id="phone" type="text" placeholder="Nhập số điện thoại" />
                                    	<form:errors path="phone" class="invalid-feedback" />
                                    </div>
                                </div>
                            </div>
                            <!-- <h2 class="h5 my-4">Địa chỉ</h2> -->
                            <div class="row">
                                <div class="col-sm-12 mb-3">
                                    <div class="form-group">
                                        <label for="address">Địa chỉ</label>
                                        <form:input class="form-control" path="address" id="address" type="text" placeholder="Nhập địa chỉ nhà" />
                                    </div>
                                </div>
                                <!-- <div class="col-sm-3 mb-3">
                                    <div class="form-group">
                                        <label for="number">Number</label>
                                        <input class="form-control" id="number" type="number" placeholder="No." required>
                                    </div>
                                </div> -->
                            </div>
                            <!-- <div class="row">
                                <div class="col-sm-4 mb-3">
                                    <div class="form-group">
                                        <label for="city">City</label>
                                        <input class="form-control" id="city" type="text" placeholder="City" required>
                                    </div>
                                </div>
                                <div class="col-sm-4 mb-3">
                                    <label for="state">State</label>
                                    <select class="form-select w-100 mb-0" id="state" name="state" aria-label="State select example">
                                        <option selected>State</option>
                                        <option value="AL">Alabama</option>
                                        <option value="AK">Alaska</option>
                                        <option value="AZ">Arizona</option>
                                        <option value="AR">Arkansas</option>
                                        <option value="CA">California</option>
                                        <option value="CO">Colorado</option>
                                        <option value="CT">Connecticut</option>
                                        <option value="DE">Delaware</option>
                                        <option value="DC">District Of Columbia</option>
                                        <option value="FL">Florida</option>
                                        <option value="GA">Georgia</option>
                                        <option value="HI">Hawaii</option>
                                        <option value="ID">Idaho</option>
                                        <option value="IL">Illinois</option>
                                        <option value="IN">Indiana</option>
                                        <option value="IA">Iowa</option>
                                        <option value="KS">Kansas</option>
                                        <option value="KY">Kentucky</option>
                                        <option value="LA">Louisiana</option>
                                        <option value="ME">Maine</option>
                                        <option value="MD">Maryland</option>
                                        <option value="MA">Massachusetts</option>
                                        <option value="MI">Michigan</option>
                                        <option value="MN">Minnesota</option>
                                        <option value="MS">Mississippi</option>
                                        <option value="MO">Missouri</option>
                                        <option value="MT">Montana</option>
                                        <option value="NE">Nebraska</option>
                                        <option value="NV">Nevada</option>
                                        <option value="NH">New Hampshire</option>
                                        <option value="NJ">New Jersey</option>
                                        <option value="NM">New Mexico</option>
                                        <option value="NY">New York</option>
                                        <option value="NC">North Carolina</option>
                                        <option value="ND">North Dakota</option>
                                        <option value="OH">Ohio</option>
                                        <option value="OK">Oklahoma</option>
                                        <option value="OR">Oregon</option>
                                        <option value="PA">Pennsylvania</option>
                                        <option value="RI">Rhode Island</option>
                                        <option value="SC">South Carolina</option>
                                        <option value="SD">South Dakota</option>
                                        <option value="TN">Tennessee</option>
                                        <option value="TX">Texas</option>
                                        <option value="UT">Utah</option>
                                        <option value="VT">Vermont</option>
                                        <option value="VA">Virginia</option>
                                        <option value="WA">Washington</option>
                                        <option value="WV">West Virginia</option>
                                        <option value="WI">Wisconsin</option>
                                        <option value="WY">Wyoming</option>
                                    </select>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="zip">ZIP</label>
                                        <input class="form-control" id="zip" type="tel" placeholder="ZIP" required>
                                    </div>
                                </div>
                            </div>
                             -->
                             <div class="mt-3">
                                <button class="btn btn-gray-800 mt-2 animate-up-2" type="submit">Lưu thông tin</button>
                            </div>
                        
                    </div>
                    <div class ="row">
                    <div class="col-6">
                            <div class="card card-body border-0 shadow mb-4">
                                <h2 class="h5 mb-4">Chọn hình đại diện</h2>
                                <div class="d-flex align-items-center">
                                    <!-- <div class="me-3">
                                        Avatar
                                        <img class="rounded avatar-xl" src="../assets/img/team/profile-picture-3.jpg" alt="change avatar">
                                    </div> -->
                                    <div class="file-field">
                                        <div class="d-flex justify-content-xl-center ms-xl-3">
                                            <div class="d-flex">
                                                <svg class="icon text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd"></path></svg>
                                                <form:input type="file" path = "image" id="upload-image"/>
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
                        
                        <div class="col-6">
                            <div class="card card-body border-0 shadow">
                                <h2 class="h5 mb-4">Chọn hình bìa</h2>
                                <div class="d-flex align-items-center">
                                    <!-- <div class="me-3">
                                        Avatar
                                        <img class="rounded avatar-xl" src="../assets/img/profile-cover.jpg" alt="change cover">
                                    </div> -->
                                    <div class="file-field">
                                        <div class="d-flex justify-content-xl-center ms-xl-3">
                                            <div class="d-flex">
                                                <svg class="icon text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd"></path></svg>
                                                <form:input type="file" path = "cover" id="upload-cover" />
                                                <div class="d-md-block text-left">
                                                    <div class="fw-normal text-dark mb-1">Chọn hình </div>
                                                    <div class="text-gray small">JPG, GIF hoặc PNG. Tối đa 2MB</div>
                                                </div>
                                            </div>
                                        </div>
                                     </div>                         
                                </div>
                            </div>
                        </div>
                        </div>
                        </form:form>
                    <!-- <div class="card card-body border-0 shadow mb-4 mb-xl-0">
                        <h2 class="h5 mb-4">Cảnh báo & Thông báo</h2>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex align-items-center justify-content-between px-0 border-bottom">
                                <div>
                                    <h3 class="h6 mb-1">Company News</h3>
                                    <p class="small pe-4">Get Rocket news, announcements, and product updates</p>
                                </div>
                                <div>
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="user-notification-1">
                                        <label class="form-check-label" for="user-notification-1"></label>
                                    </div>
                                </div>
                            </li>
                            <li class="list-group-item d-flex align-items-center justify-content-between px-0 border-bottom">
                                <div>
                                    <h3 class="h6 mb-1">Account Activity</h3>
                                    <p class="small pe-4">Get important notifications about you or activity you've missed</p>
                                </div>
                                <div>
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="user-notification-2" checked>
                                        <label class="form-check-label" for="user-notification-2"></label>
                                    </div>                                            
                                </div>
                            </li>
                            <li class="list-group-item d-flex align-items-center justify-content-between px-0">
                                <div>
                                    <h3 class="h6 mb-1">Meetups Near You</h3>
                                    <p class="small pe-4">Get an email when a Dribbble Meetup is posted close to my location</p>
                                </div>
                                <div>
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" id="user-notification-3" checked>
                                        <label class="form-check-label" for="user-notification-3"></label>
                                    </div> 
                                </div>
                            </li>
                        </ul>
                    </div> -->
                </div>
                <div class="col-12 col-xl-4">
                    <div class="row">
                        <div class="col-12 mb-4">
                            <div class="card shadow border-0 text-center p-0">
                                <%-- <div class="profile-cover rounded-top" data-background="${admin.cover } " id = "preview-cover"></div> --%>
                                <div class="rounded-top profile-cover overflow-hidden">
                                	<img src="${admin.cover}" class="image-fluid" alt="${admin.firstname}" id="preview-cover">
                                </div>
                                <div class="card-body">
                                    <img src="${admin.image}" id="preview-image" class="avatar-xl rounded-circle mx-auto mt-n7 mb-4" alt="${admin.firstname }">
                                    <h4 class="h3">${admin.lastname } ${admin.firstname }</h4>
                                    <h5 class="fw-normal">Quản trị viên</h5>
                                    <p class="text-gray my-0">${admin.email }</p>
                                    <p class="text-gray mb-4">${admin.phone }</p>
                                   <!--  <a class="btn btn-sm btn-gray-800 d-inline-flex align-items-center me-2" href="#">
                                        <svg class="icon icon-xs me-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z"></path></svg>
                                        Connect
                                    </a>-->
                                    <!-- <a class="btn btn-sm btn-secondary" href="#">Send Message</a>  -->
                                </div>
                             </div>
                        </div>
                        
                        
                    </div>
                </div>
            </div>
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
var uploadImage= document.getElementById("upload-image");
uploadImage.onchange = evt => {
	  const [file] = uploadImage.files
	  if (file) {
		  previewImage.src = URL.createObjectURL(file)
	  }
	}

var previewCover = document.getElementById("preview-cover");
var uploadCover = document.getElementById("upload-cover");
uploadCover.onchange = evt => {
	  const [file] = uploadCover.files
	  if (file) {
		  previewCover.src = URL.createObjectURL(file)
	  }
	}
</script>      

</body>

</html>
