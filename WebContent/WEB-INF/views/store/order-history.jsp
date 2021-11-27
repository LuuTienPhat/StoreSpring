<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Lịch sử mua hàng</title>
<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
<style type="text/css">
.error::before {
	content: '';
	display: block;
	width: 0;
	height: 0;
	border-left: 8px solid transparent;
	border-right: 8px solid transparent;
	border-bottom: 8px solid #FB3F3F;
	position: absolute;
	top: -8px;
	left: 10px;
}

.error {
	cursor: pointer;
	position: relative;
	background-color: #FB3F3F;
	padding: 2px 8px;
	width: fit-content;
	border-radius: 4px;
	transform: translateY(-8px);
	color: white;
}

.ordered-list {
	height: 660px;
	overflow-y: scroll;
}
</style>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div class="main__new-product px-32 mb-12 mt-6">
			<div class="mb-5 font-bold text-xl">
				<a href="${applicationScope.userInfoPage}"
					class="hover:text-indigo-500 transition-colors">Hồ sơ cá nhân</a>
				> <span class="text-indigo-500">Lịch sử mua hàng</span>
			</div>
			<div class="flex justify-between info-wrapper">
				<div class="p-4 pt-0 border-2 mr-4 border-gray-200 user-info-nav">
					<div
						class="my-2 mt-3 text-center text-indigo-500 text-xl font-bold">${customerEntity.firstname}
						${customerEntity.lastname}</div>
					<div class="mb-1">
						<a href="${applicationScope.userInfoPage}"
							class="hover:text-indigo-500 transition-colors">Thông tin
							tài khoản</a>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.changePasswordPage}"
							class="hover:text-indigo-500 transition-colors">Đổi mật
							khẩu</a>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.shoppingCartPage}"
							class="hover:text-indigo-500 transition-colors">Giỏ hàng</a>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.userFavoritePage}"
							class="hover:text-indigo-500 transition-colors">Sản phẩm đã thích</a>
					</div>
					<div class="mb-1">
						<span href="${applicationScope.orderHistoryPage}"
							class="text-indigo-500 transition-colors">Lịch sử mua
							hàng</span>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.logOutPage}"
							class="hover:text-indigo-500 transition-colors">Đăng xuất</a>
					</div>
				</div>
				<div class="sign-up-form-container border-2 border-gray-200 flex-1">
					<div class="my-3 px-4 font-bold">ĐƠN HÀNG ĐÃ MUA</div>
					<div class="px-4">
						<hr class="">
					</div>
					<div class="px-4 ordered-list">
						<c:if test="${listOrder.size()==0}">
							<p>Bạn chưa có đơn hàng nào.</p>
							<p class="mb-2">
								<a href="${applicationScope.storeIndexPage}"
									class="inline-block font-bold text-indigo-500 hover:text-indigo-300 transition-colors">Quay
									lại trang chủ</a> để mua sắm.
							</p>
						</c:if>
						<%-- <table class="cart-list__table mb-4">
							<thead>
								<tr class="card-list__table-header font-bold">
									<th>Tên</th>
									<th>Số lượng</th>
									<th>Thành tiền</th>
								</tr>
							</thead>
							<c:forEach var="order" items="${listOrder}" varStatus="loop">
								<p class="">${loop.index+1}.</p>
								<tbody>
									<c:forEach var="c" items="${order.orderDetails}">
										<tr class="card-list__table-item">
											<td class="card-list__table-desc"
												style="text-align: left !important;"><a
												href="${applicationScope.productDetailPage}/${c.product.id}"
												class="hover:text-indigo-500">${c.product.name}</a> <br>
												<div class="cart-list__price">
													Đơn giá: <span class="font-bold"><fmt:setLocale
															value="vi_VN" scope="session" /> <fmt:formatNumber
															value="${c.product.price}" type="currency" /></span>
												</div></td>
											<td class="cart-list__quantity">${c.quantity}</td>
											<td class="card-list__total font-bold"><fmt:setLocale
													value="vi_VN" scope="session" /> <fmt:formatNumber
													value="${c.quantity*c.product.price}" type="currency" /></td>
										</tr>
									</c:forEach>
								</tbody>

								<div class="w-full flex justify-between border-t my-1 py-2">
									<span class="">Tổng cộng</span> <span class="font-bold"><fmt:setLocale
											value="vi_VN" scope="session" /> <fmt:formatNumber
											value="${order.orderTotal}" type="currency" /></span>
								</div>
								<div class="w-full border-b border-black"></div>
							</c:forEach>
						</table> --%>
						<div class="order-row flex justify-between">
							<div class="order-cell flex-1 p-2 border font-bold">Sản phẩm</div>
							<div class="order-cell w-1/6 p-2 border text-center align-middle font-bold">Số lượng</div>
							<div class="order-cell w-1/5 p-2 border text-center align-middle font-bold">Thành tiền</div>
						</div>
						<c:forEach var="order" items="${listOrder}" varStatus="loop">
							<p class="p-2 text-indigo-500 font-bold">${loop.index+1}.</p>
							
								<c:forEach var="c" items="${order.orderDetails}">
								<div class="order-row flex">
									<div class="order-cell flex-1 p-2 border"><a
												href="${applicationScope.productDetailPage}/${c.product.id}"
												class="hover:text-indigo-500">${c.product.name}</a><br>
												<div class="cart-list__price text-sm">
													Đơn giá: <span class="font-bold"><fmt:setLocale
															value="vi_VN" scope="session" /> <fmt:formatNumber
															value="${c.product.price}" type="currency" /></span>
												</div></div>
									<div class="order-cell w-1/6 p-2 border text-center align-middle">${c.quantity}</div>
									<div class="order-cell w-1/5 p-2 border text-center align-middle"><fmt:setLocale
													value="vi_VN" scope="session" /> <fmt:formatNumber
													value="${c.quantity*c.product.price}" type="currency" /></div>
								</div>
								</c:forEach>
							
							<div class="w-full flex justify-between my-1 p-2">
									<span class="">Tổng cộng:</span><span class="font-bold"><fmt:setLocale
											value="vi_VN" scope="session" /><fmt:formatNumber
											value="${order.totalPrice}" type="currency" /></span>
								</div>
								<div class="w-full border-b border-black"></div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
	<!-- <script src="./assets/js/main.js"></script> -->
	<script
		src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/sign-up.js"></script> -->
	<%-- 	<script src="<c:url value='/resources/store/assets/js/sign-up.js'/>"></script> --%>
	<script type="text/javascript">
		var a = document.getElementsByClassName("error");
		for (var i = 0; i < a.length; i++) {
			a[i].addEventListener("click", function(e) {
				e.target.style.display = "none";
			})
		}
	</script>
</body>

</html>