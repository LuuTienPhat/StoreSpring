<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>${product.name}</title>
<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div class="main__new-product section px-32 my-5">
			<div class="product__detail">
				<div class="product-navigation font-bold mb-5">
					<a href="store/all"
						class="inline-block font-bold text-xl hover:text-indigo-500 transition-colors">Tất
						cả</a> > <a href="store/category/${product.category.id}"
						class="inline-block font-bold text-xl text-indigo-600 hover:text-indigo-500 transition-colors">${product.category.name}</a>
				</div>
				<div class="flex detail__wrapper">
					<a href="${applicationScope.productDetailPage}/${product.id}"
						class="product-detail__img-container"><img
						src="${product.images[0].image}" alt="${product.id}"></a>
					<div class="ml-5 flex-1 detail__desc">
						<div class="flex justify-between">
							<h3 class="text-3xl font-bold mb-2">${product.name}</h3>
							<a
								href="store/insert-to-favlist/${product.id}/product-detailseperator${product.id}">
								<c:set var="contains" value="false" /> <c:forEach var="fav"
									items="${listFavorite}">
									<c:if test="${fav.product.id eq product.id}">
										<c:set var="contains" value="true" />
									</c:if>
								</c:forEach> <c:if test="${contains==true}">
									<i
										class="fa text-2xl fa-heart text-white text-indigo-500 text-2xl transition-colors"></i>
								</c:if> <c:if test="${contains==false}">
									<i
										class="fa text-2xl fa-heart text-black  text-2xl transition-colors"></i>
								</c:if> <!-- <i
										class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i> -->
							</a>
						</div>
						<%-- <h3 class="text-3xl font-bold mb-2">${product.name}</h3> --%>
						<div class="flex justify-between">
							<h6 class="mb-2 text-gray-500">Mã sản phẩm: ${product.id}</h6>

							<div class="flex">
								<h6 class="mb-2 text-gray-500 mr-4">Tồn kho:
									${product.quantity}</h6>
								<h6 class="mb-2 text-gray-500">Lượt xem:
									${product.views}</h6>
								<!-- <div class="border-l-2 border-white h-7 mx-2"></div> -->
								<!-- <i
								class="fa fa-share-alt text-2xl hover:text-indigo-500 text-2xl mr-2 cursor-pointer"></i>
							<i
								class="fa fa-heart hover:text-indigo-500 text-2xl cursor-pointer"></i> -->
							</div>
						</div>
						<div>
							<%-- <span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${pd.price}" type="currency" /></span> --%>
							<h2 class="price my-4 text-3xl font-bold">
								<fmt:setLocale value="vi_VN" scope="session" />
								<fmt:formatNumber value="${product.price}" type="currency" />
							</h2>
							<c:if test="${product.quantity <= 0}">
								<span class="px-1 ml-1 bg-gray-500 text-white text-2xl">Hết
									hàng</span>
							</c:if>
						</div>
						<%-- <h2 class="price my-4 text-3xl font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${product.price}" type="currency" /></h2> --%>

						<!-- <div class="flex my-4 items-center">
						<h6 class="color mr-4">Màu sắc</h6>
						<div
							class="color-visual border-2 border-blue-400 rounded-full w-9 h-9 bg-yellow-300 cursor-pointer">
						</div>
					</div> -->
						<form>
							<!--  chưa cập nhật thêm vào giỏ -->
							<%-- <div class="flex my-4">
							<input type="text" value="${product.quantity}"
									name="product_id" class="hidden">
							<h6 class="mr-4">Số lượng</h6>
							<div class="input-group flex align-items-center">
								<button class="button-minus">-</button>
								<input type="number" step="1" max="${product.quantity}" min="1"
									value="1" name="quantity" class="quantity-field">

								<button class="button-plus">+</button>

							</div>

						</div> --%>
							<div class="flex my-4 border-gray-300 border-b-2 pb-5">
								<a
									href="store/shopping-cart/insert-into-cart/${product.id}/product-detailseperator${product.id}"
									class="w-full text-center py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md mr-4 add-to-cart">THÊM
									VÀO GIỎ HÀNG</a>
								<!-- <button
								class="w-full text-center py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md buy-now">MUA
								NGAY</button> -->
							</div>
						</form>
						<div class="delivery-policy">
							<div class="my-2">
								<div class="flex w-100 items-center mb-2">
									<i class="fas fa-truck mr-2"></i> <span class="font-bold">Giao
										hàng toàn quốc đơn hàng từ 100k</span>
								</div>
								<div class="flex w-1/2 items-center mb-2">
									<i class="fas fa-coins mr-2"></i> <span class="font-bold">COD
										nội thành HN, HCM</span>
								</div>
								<div class="flex w-1/2 items-center">
									<i class="fas fa-sync mr-2"></i> <span class="font-bold">Đổi
										trả trong 24h</span>
								</div>

							</div>
							<div class="flex items-center">
								<i class="fas fa-gift mr-2"></i>
								<div class="flex flex-col">
									<span class="font-bold">Freeship cho đơn hàng từ 200k
										nội thành HN, HCM</span> <span class="font-bold">Freeship cho
										đơn hàng từ 300k toàn quốc</span>
								</div>
							</div>
						</div>
					</div>
				</div>
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
											class="block overflow-hidden"> <img
											src="${p.images[0].image}" alt="${p.id}"
											class="transform hover:scale-110 transition-all " /></a>

										<div
											class="flex justify-center bg-indigo-300 items-center py-1 absolute item__menu w-full">
											<a
												href="store/insert-to-favlist/${p.id}/product-detailseperator${p.id}">
												<c:set var="contains" value="false" /> <c:forEach var="fav"
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
										class="fa text-2xl fa-heart text-white hover:text-indigo-500 transition-colors"></i> -->
											</a>
											<div class="border-l-2 border-white h-7 mx-2"></div>
											<a
												href="store/shopping-cart/insert-into-cart/${p.id}/product-detailseperator${p.id}"><i
												class="fa text-2xl fa-cart-plus text-white hover:text-indigo-200 transition-colors"></i></a>
										</div>
									</div>
									<a
										href="${applicationScope.productDetailPage}/${p.id}/product-detailseperator${p.id}"
										class="item__name block hover:text-indigo-400 transition-colors font-bold my-2">${p.name}</a>
								</div>
								<div>
									<span class="item__price font-bold"><fmt:setLocale
											value="vi_VN" scope="session" /> <fmt:formatNumber
											value="${p.price}" type="currency" /></span>
									<c:if test="${p.quantity <= 0}">
										<span class="p-1 ml-1 bg-gray-500 text-white">Hết
											hàng</span>
									</c:if>
								</div>
								<%-- <span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${p.price}" type="currency" /></span> --%>
							</div>
						</c:forEach>
					</c:if>


				</div>
			</div>
		</div>
	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/product-detail.js"></script> -->
	<script
		src="<c:url value='/resources/store/assets/js/product-detail.js'/>"></script>
</body>

</html>