<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>

<!-- ========== Meta Tags ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>
<title>Add Category</title>

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
                            <a href="#">
                                <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item"><a href="#">Volt</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Forms</li>
                    </ol>
                </nav>
                <div class="d-flex justify-content-between w-100 flex-wrap">
                    <div class="mb-3 mb-lg-0">
                        <h1 class="h4">Forms</h1>
                        <p class="mb-0">Dozens of reusable components built to provide buttons, alerts, popovers, and more.</p>
                    </div>
                    <div>
                        <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/forms/" class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Forms Docs</a>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 mb-4">
                    <div class="card border-0 shadow components-section">
                        <div class="card-body">     
                            <div class="row mb-4">
                            	 <div class="col-lg-12 col-sm-12">
                            	 
           <form action = "${applicationScope.categoryPage }/add" method = "POST" enctype="multipart/form-data">
                <div class="mb-4">
                  <label for="categoryName">Tên danh mục</label>
                  <input type="categoryName" class="form-control" name = "name" id="categoryName" 
                  		aria-describedby="categoryNameHelp" value = "something else">
                </div>
                
                <div class="my-4">
                  <label for="textarea">Mô tả</label>
                  <textarea class="form-control" name = "description" 
                  placeholder="Nhập mô tả" id="textarea" rows="4" >I like it</textarea>
                </div>
                
                <div class="mb-3">
                  <label for="formFile" class="form-label">Chọn file hình ảnh</label>
                  <input class="form-control" type="file" id="formFile" name = "image">
                </div>
                <div class="mb-3">
                  <button class = "btn btn-primary" type="submit">Thêm danh mục</button>
                </div>
                </form>
              </div>
              
              
                            </div>
                       </div>
                    </div>
                </div>
            </div>
        </main>
<!-- ========== All JS files linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
    
</body>

</html>
