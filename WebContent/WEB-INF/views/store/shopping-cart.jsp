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
		<div class="cart-list__container main__new-product px-32 my-6">
		<h3 class="text-indigo-500 font-bold mb-4 text-xl">GIỎ HÀNG CỦA BẠN</h3>
				<hr class="border-none bg-indigo-500 mb-4" style="height: 1px;">
					<c:if test="${listCartDetail.size()==0}">
							<p>Bạn không có sản phẩm nào trong giỏ hàng.</p>
							<p class="mb-2"><a href="${applicationScope.storeIndexPage}"
							class="inline-block font-bold text-indigo-500 hover:text-indigo-300 transition-colors">Quay lại trang chủ</a> để mua sắm.</p>
						</c:if>
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
									href="${applicationScope.productDetailPage}/${c.product.id}"
									class="table-image__container"> <img
										<%-- src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" --%>
										src="${c.product.images[0].image}" alt="${c.product.id}"/>
										<!-- alt=""> -->
								</a></td>
								<!-- desc = tên sản phẩm + màu sắc + kích cỡ (nếu có) -->
								<td class="card-list__table-desc"  style="text-align: left;"><a
									href="${applicationScope.productDetailPage}/${c.product.id}"
									class="hover:text-indigo-500">${c.product.name}</a>
									<div>Tồn kho: ${c.product.quantity}</div>
									</td>
								<td class="cart-list__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${c.product.price}" type="currency" /></td>
								<td class="cart-list__quantity">
									<div class="input-group flex align-items-center">
										<button class="button-minus">-</button>
										<input type="number" step="1" max="${c.product.quantity}" min="1"
											value="${c.quantity}" name="quantity" class="quantity-field">

										<button class="button-plus">+</button>

									</div>
								</td>
								<td class="card-list__total font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${c.quantity*c.product.price}" type="currency" /></td>
								<td class="card-list__action"><a
									href="store/shopping-cart/delete/${c.product.id}"
									class="hover:text-indigo-500">Xóa</a></td>
							</tr>
						</c:forEach>
					</tbody>



				</table>
				<div class="flex justify-end mb-4">
					<button
						class="px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md"
						type="submit">Cập nhật</button>
						<!-- <a href="store/shopping-cart/delete-all"
						class="ml-2 px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md"
						>Xóa tất cả</a> -->
						<a href="store/shopping-cart/check-out"
						class="ml-2 px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md"
						>Thanh toán</a>
				</div>
			</form>
			<p>Hỗ trợ ship 20k cho đơn hàng từ 300k nội thành HN, HCM</p>
			<p>Hỗ trợ ship 30k cho đơn hàng từ 500k toàn quốc</p>
			<p>Đơn hàng trên website được xử lý trong giờ hành chính</p>

			<h3 class="text-right text-indigo-400 mt-4 text-3xl font-bold">
				Tổng: <span class="cart-total">000</span>
			</h3>
			<div class="section__heading mb-8  mt-16">
				<h3>
					<span href="#"
						class="<!-- hover:text-indigo-400 --> transition-colors text-3xl font-bold">Các
						sản phẩm đã xem</span>
				</h3>
			</div>


			<div class="visited-product flex flex-wrap">
				<c:if test="${sessionScope.listRecentViewProducts != null}">
					<c:forEach var="p" items="${sessionScope.listRecentViewProducts}">
						<div class="item w-1/5 px-3 mb-4 flex flex-col justify-between">
						<div>
							<div class="relative item-menu-container overflow-hidden">
								<a href="${applicationScope.productDetailPage}/${p.id}"
									class="block overflow-hidden">
									<img src="${p.images[0].image}"
									alt="${p.id}" class="transform hover:scale-110 transition-all " /></a>

								<div
									class="flex justify-center bg-indigo-300 items-center py-1 absolute item__menu w-full">
									<a href="store/insert-to-favlist/${p.id}/user-cart"> <c:set var="contains"
											value="false" /> <c:forEach var="fav"
											items="${listFavorite}">
											<c:if test="${fav.product.id eq p.id}">
												<c:set var="contains" value="true" />
											</c:if>
										</c:forEach> <c:if test="${contains==true}">
											<i
												class="fa text-2xl fa-heart text-white text-indigo-500 transition-colors"></i>
										</c:if> <c:if test="${contains==false}">
											<i
												class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i>
										</c:if> <!-- <i
										class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i> --></a>
										<div class="border-l-2 border-white h-7 mx-2"></div>
											<a
												href="store/shopping-cart/insert-into-cart/${p.id}/user-cart"><i
												class="fa text-2xl fa-cart-plus text-white hover:text-indigo-200 transition-colors"></i></a>
								</div>
							</div>
							<a href="${applicationScope.productDetailPage}/${p.id}"
								class="item__name block hover:text-indigo-400 transition-colors font-bold my-2">${p.name}</a>
						</div>
						<div>
						<span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${p.price}" type="currency" /></span>
                              <c:if test="${p.quantity <= 0}">
                              <span class="p-1 ml-1 bg-gray-500 text-white">Hết hàng</span>
                              </c:if>
						</div>
						<%-- <span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${p.price}" type="currency" /></span> --%>
					</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</main>

	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/cart.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/cart.js?version=51'/>"></script>
</body>
</html>