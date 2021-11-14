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
            <div class="py-4">
                <nav aria-label="breadcrumb" class="d-none d-md-inline-block">
                    <ol class="breadcrumb breadcrumb-dark breadcrumb-transparent">
                        <li class="breadcrumb-item">
                            <a href="">
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
                        <li class="breadcrumb-item">Sản phẩm</li>
                        <li class="breadcrumb-item active" aria-current="page"><a href="${applicationScope.addProductPage }">Thêm sản phẩm</a></li>
                    </ol>
                </nav>
                <div class="d-flex justify-content-between w-100 flex-wrap">
                    <div class="mb-3 mb-lg-0">
                        <h1 class="h4">Thêm sản phẩm</h1>
                        <!-- <p class="mb-0"></p> -->
                    </div>
                    <div>
                        <!-- <a href="https://themesberg.com/docs/volt-bootstrap-5-dashboard/components/forms/" class="btn btn-outline-gray"><i class="far fa-question-circle me-1"></i> Forms Docs</a> -->
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card border-0 shadow components-section">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-12 col-sm-12">
                                    <form:form action="${applicationScope.productPage }/add" method="POST" enctype="multipart/form-data" modelAttribute="product">
                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <label for="productName">Tên sản phẩm</label>
                                                <form:input type="productName" class="form-control ${nameValid }" path="name" id="productName" placeholder="Nhập tên sản phẩm" />
                                                <form:errors path="name" class="invalid-feedback" />
                                            </div>
                                            <div class="col-6">
                                                <label for="quantity">Số lượng</label>
                                                <form:input value="0" type="quantity" class="form-control ${quantityValid }" path="quantity" id="quantity" placeholder="Nhập số lượng" />
                                                <form:errors path="quantity" class="invalid-feedback" />
                                            </div>
                                        </div>
                                        <div class="row mb-4">
                                            <div class="col-6">
                                                <label for="unit">Đơn vị tính</label>
                                                <form:input type="unit" class="form-control" path="unit" id="unit" placeholder="Nhập đơn vị tính" />
                                            </div>
                                            <div class="col-6">
                                                <label for="price">Giá tiền</label>
                                                <form:input value="0" type="price" class="form-control ${priceValid }" path="price" id="price" aria-describedby="priceHelp" placeholder="50000" />
                                                <form:errors path="price" class="invalid-feedback" />
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <label class="my-1 me-2" for="category">Loại sản phẩm</label>
                                            <form:select path="category.id" class="form-select ${categoryValid }" id="category" aria-describedby="catgoryHelp">
                                                <form:option value="">Chọn danh mục của sản phẩm</form:option>
                                                <form:options items="${categories}" itemLabel="name" itemValue="id" />
                                            </form:select>
                                            <form:errors path="category" class="invalid-feedback" />
                                        </div>

                                        <div class="mb-4">
                                            <label for="textarea">Mô tả</label>
                                            <form:textarea class="form-control" placeholder="Nhập mô tả" id="textarea" rows="4" path="description"></form:textarea>
                                        </div>

                                        <div class="mb-4 d-flex overflow-auto" id="preview-images"></div>

                                        <div class="mb-4">
                                            <label for="formFile" class="form-label">Chọn file hình ảnh</label>
                                            <form:input class="form-control" type="file" id="images" path="images" accept="image/*" multiple="multiple" />
                                            <small class="form-text text-muted">Chỉ nhận file ảnh, kích thước tối đa 20MB</small>
                                        </div>

                                        <script>
                                            var previewImage = document.getElementById("preview-images");
                                            var imageUpload = document.getElementById("images");
                                            imageUpload.onchange = (evt) => {
                                                //const [file] = imageUpload.files
                                                let imgElement = "";
                                                for (let file of imageUpload.files) {
                                                    if (file) {
                                                        imgElement += "<img src='" + URL.createObjectURL(file) + "' width='200' height='200' class='img-fluid img-thumbnail me-2' />";
                                                    }
                                                }
                                                previewImage.innerHTML = imgElement;
                                            };
                                        </script>
                                        <div class="">
                                            <button class="btn btn-primary my-0" type="submit">Thêm sản phẩm</button>
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

        <!-- ========== Notyf JS linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/footer/notyf.jsp"%>
    </body>
</html>
