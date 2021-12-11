<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
      	<div class="mb-2">
      		<svg class="text-warning icon icon-xxl" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
      	</div>
      
        <h5 class="my-0 mb-2">Bạn có muốn xoá sản phẩm này?</h5>
        <!-- <small class="my-0 mt-4 text-wrap text-gray-500">Hãy chắc chắn danh mục này <span class="fw-bold">không tồn tại</span> sản phẩm nào</small> -->
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