<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>

<!-- ========== Meta Tags ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>
<title>${title }</title>

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
                            <a href="${applicationScope.dashboardPage }">
                                <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item"><a href="${applicationScope.addCategoryPage }">Danh mục</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thêm danh mục</li>
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
                            <div class="row mb-4">
                            	 <div class="col-lg-12 col-sm-12">
                            	 
           <form:form action = "${applicationScope.categoryPage }/add" method = "POST" enctype="multipart/form-data" modelAttribute="category">
                <div class="mb-4">
                  <label for="categoryName">Tên danh mục</label>
                  <form:input type="categoryName" class="form-control ${nameValid}" path = "name" id="categoryName" aria-describedby="categoryNameHelp" placeholder="Nhập tên danh mục" />
                  <form:errors path="name" class="invalid-feedback"/>
                </div>
                
                <div class="my-4">
                  <label for="textarea">Mô tả</label>
                  <form:textarea class="form-control" path = "description" placeholder="Nhập mô tả" id="textarea" rows="4" ></form:textarea>
                </div>
                
                <div class="mb-3">
                 	<img alt="Hình ảnh" src="" id="preview-image" class="img-thumbnail" width = "200" height="200">
                </div>
                
                <div class="mb-3">
                  <label for="formFile" class="form-label">Chọn file hình ảnh</label>
                  <form:input class="form-control" type="file" path = "image" id="image" />
                </div>
                <div class="mb-3">
                  <button class = "btn btn-primary" type="submit">Thêm danh mục</button>
                </div>
                
                <script>
                 	var previewImage = document.getElementById("preview-image");
                 	var imageUpload = document.getElementById("image");
                 	imageUpload.onchange = evt => {
                 		  const [file] = imageUpload.files
                 		  if (file) {
                 			  previewImage.src = URL.createObjectURL(file)
                 		  }
                 		}
                 </script>
                
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

<!-- ========== Notyf JS linkup ========= -->
<%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
    
</body>

</html>
