<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Sản phẩm đã thích</title>
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
				> <span class="text-indigo-500">Sản phẩm đã thích</span>
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
						<span href="${applicationScope.userFavoritePage}"
							class="text-indigo-500 transition-colors">Sản phẩm đã
							thích</span>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.orderHistoryPage}"
							class="hover:text-indigo-500 transition-colors">Lịch sử mua
							hàng</a>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.logOutPage}"
							class="hover:text-indigo-500 transition-colors">Đăng xuất</a>
					</div>
				</div>
				<div class="sign-up-form-container border-2 border-gray-200 flex-1">
					<div class="my-3 px-4 font-bold">SẢN PHẨM ĐÃ THÍCH</div>
					<div class="px-4">
						<hr class="">
					</div>
					<div class="px-4 ordered-list">
						<c:if test="${listFavorite.size()==0}">
							<p>Bạn chưa có sản phẩm yêu thích nào nào.</p>
							<p class="mb-2">
								<a href="${applicationScope.storeIndexPage}"
									class="inline-block font-bold text-indigo-500 hover:text-indigo-300 transition-colors">Quay
									lại trang chủ</a> để mua sắm.
							</p>
						</c:if>
						<div class="new-product__list flex flex-wrap py-4">
							<c:forEach var="fav" items="${listFavorite}" varStatus="loop">
								<div class="item w-1/3 px-3 mb-4 flex flex-col justify-between">
									<div>
										<div class="relative item-menu-container overflow-hidden">
											<a
												href="${applicationScope.productDetailPage}/${fav.product.id}"
												class="block overflow-hidden"> <img
												src="${fav.product.images[0].image}" alt="${fav.product.id}"
												class="transform hover:scale-110 transition-all " /></a>

											<div
												class="flex justify-center bg-indigo-300 items-center py-1 absolute item__menu w-full">
												<a href="store/insert-to-favlist/${fav.product.id}/user-fav"> <c:set
														var="contains" value="false" /> <%-- <c:forEach var="fav"
											items="${listFavorite}">
											<c:if test="${fav.product.id eq p.id}">
												<c:set var="contains" value="true" />
											</c:if>
										</c:forEach> <c:if test="${contains==true}"> --%> <i
													class="fa text-2xl fa-heart text-white text-indigo-500 transition-colors"></i>
													<%-- </c:if> <c:if test="${contains==false}">
											<i
												class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i>
										</c:if> --%> <!-- <i
										class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i> --></a>
												<div class="border-l-2 border-white h-7 mx-2"></div>
												<a
													href="store/shopping-cart/insert-into-cart/${fav.product.id}/user-fav"><i
													class="fa text-2xl fa-cart-plus text-white hover:text-indigo-200 transition-colors"></i></a>
											</div>
										</div>
										<a href="${applicationScope.productDetailPage}/${fav.product.id}"
											class="item__name block hover:text-indigo-400 transition-colors font-bold my-2">${fav.product.name}</a>
									</div>
									<div>
										<span class="item__price font-bold"><fmt:setLocale
												value="vi_VN" scope="session" /> <fmt:formatNumber
												value="${fav.product.price}" type="currency" /></span>
										<c:if test="${fav.product.quantity <= 0}">
											<span class="p-1 ml-1 bg-gray-500 text-white">Hết
												hàng</span>
										</c:if>
									</div>
									<%-- <span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${p.price}" type="currency" /></span> --%>
								</div>
							</c:forEach>
						</div>
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