<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Giỏ hàng</title>
<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div class="cart-list__container main__new-product px-32 my-16">
			<form action="store/shopping-cart/update" method="post">
				<table class="cart-list__table mb-4">
					<thead>
						<tr class="card-list__table-header font-bold">
							<th>Sản phẩm</th>
							<th>Mô tả</th>
							<th>Đơn giá</th>
							<th>Số lượng</th>
							<th>Tổng</th>
							<th>Thao tác</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="c" items="${listCartDetail}">
							<tr class="card-list__table-item">
								<input type="text" name="product_id" value="${c.product.id}"
									class="hidden" />
								<td class="card-list__table-image"><a
									href="${applicationScope.productDetailPage}"
									class="table-image__container"> <img
										src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>"
										alt="">
								</a></td>
								<!-- desc = tên sản phẩm + màu sắc + kích cỡ (nếu có) -->
								<td class="card-list__table-desc"><a
									href="${applicationScope.productDetailPage}"
									class="hover:text-pink-400">${c.product.name}</a></td>
								<td class="cart-list__price font-bold">${c.product.price}đ</td>
								<td class="cart-list__quantity">
									<div class="input-group flex align-items-center">
										<button class="button-minus">-</button>
										<input type="number" step="1" max="${c.product.quantity}" min="1"
											value="${c.quantity}" name="quantity" class="quantity-field">

										<button class="button-plus">+</button>

									</div>
								</td>
								<td class="card-list__total font-bold">${c.quantity*c.product.price}đ</td>
								<td class="card-list__action"><a
									href="store/shopping-cart/delete/${c.product.id}"
									class="hover:text-pink-400">Xóa</a></td>
							</tr>
						</c:forEach>
					</tbody>



				</table>
				<div class="flex justify-end mb-4">
					<button
						class="px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md"
						type="submit">Cập nhật</button>
						<a href="store/shopping-cart/delete-all"
						class="ml-2 px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md"
						>Xóa tất cả</a>
						<a href="store/shopping-cart/check-out"
						class="ml-2 px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md"
						>Thanh toán</a>
				</div>
			</form>
			<p>Hỗ trợ ship 20k cho đơn hàng từ 300k nội thành HN, HCM</p>
			<p>Hỗ trợ ship 30k cho đơn hàng từ 500k toàn quốc</p>
			<p>Đơn hàng trên website được xử lý trong giờ hành chính</p>

			<h3 class="text-right text-pink-300 mt-4 text-3xl font-bold">
				Tổng: <span class="cart-total">000</span>đ
			</h3>
			<div class="section__heading mb-8  mt-16">
				<h3>
					<a href="#"
						class="hover:text-pink-300 transition-colors text-3xl font-bold">Các
						sản phẩm đã xem</a>
				</h3>
			</div>


			<div class="visited-product flex flex-wrap">
				<div class="item w-1/5 px-3 mb-4">
					<div class="relative item-menu-container overflow-hidden">
						<a href="#" class="block overflow-hidden"> <img
							src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>"
							alt="" class="transform hover:scale-110 transition-all "></a>

						<div
							class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
							<a href="#"><i
								class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
							<div class="border-l-2 border-white h-7 mx-2"></div>
							<a href="#"><i
								class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
						</div>
					</div>
					<a href="#"
						class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy
						MJ Momo duck nháy mắt 7cm</a> <span class="item__price font-bold">50000đ</span>
				</div>
				<div class="item w-1/5 px-3 mb-4">
					<div class="relative item-menu-container overflow-hidden">
						<a href="#" class="block overflow-hidden"> <img
							src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>"
							alt="" class="transform hover:scale-110 transition-all "></a>

						<div
							class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
							<a href="#"><i
								class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
							<div class="border-l-2 border-white h-7 mx-2"></div>
							<a href="#"><i
								class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
						</div>
					</div>
					<a href="#"
						class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy
						MJ Momo duck nháy mắt 7cm</a> <span class="item__price font-bold">50000đ</span>
				</div>
				<div class="item w-1/5 px-3 mb-4">
					<div class="relative item-menu-container overflow-hidden">
						<a href="#" class="block overflow-hidden"> <img
							src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>"
							alt="" class="transform hover:scale-110 transition-all "></a>

						<div
							class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
							<a href="#"><i
								class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
							<div class="border-l-2 border-white h-7 mx-2"></div>
							<a href="#"><i
								class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
						</div>
					</div>
					<a href="#"
						class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy
						MJ Momo duck nháy mắt 7cm</a> <span class="item__price font-bold">50000đ</span>
				</div>
				<div class="item w-1/5 px-3 mb-4">
					<div class="relative item-menu-container overflow-hidden">
						<a href="#" class="block overflow-hidden"> <img
							src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>"
							alt="" class="transform hover:scale-110 transition-all "></a>

						<div
							class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
							<a href="#"><i
								class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
							<div class="border-l-2 border-white h-7 mx-2"></div>
							<a href="#"><i
								class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
						</div>
					</div>
					<a href="#"
						class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy
						MJ Momo duck nháy mắt 7cm</a> <span class="item__price font-bold">50000đ</span>
				</div>
			</div>
		</div>
	</main>

	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/cart.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/cart.js'/>"></script>
</body>
</html>