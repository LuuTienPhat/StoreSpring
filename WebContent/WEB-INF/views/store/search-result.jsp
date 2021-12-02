<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Kết quả tìm kiếm</title>
<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tg"%>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div class="main__new-product section px-32 my-6">
		<div class="section__heading mb-8">
				<div class="product-navigation font-bold mb-5">
					<h3 class="text-indigo-500 font-bold text-xl">Kết quả tìm kiếm cho: ${keyword}</h3>
					
				</div>
				<hr class="border-none bg-indigo-500" style="height: 1px;">
				<c:if test="${pagedListHolder.pageList.size()==0}">
							<p class="mt-5">Có vẻ không có sản phẩm phù hợp với từ khóa.</p>
							<p class="mb-2">Nhấn vào <a href="${applicationScope.storeIndexPage}"
							class="inline-block font-bold text-indigo-500 hover:text-indigo-300 transition-colors">đây</a> để quay lại trang chủ.</p>
						</c:if>
			</div>
			
			<div class="new-product__list flex flex-wrap">
				<jsp:useBean id="pagedListHolder" scope="request"
					type="org.springframework.beans.support.PagedListHolder" />
				<c:url
					value="store/search/${keyword}/"
					var="pagedLink">
					<c:param name="p" value="~" />
				</c:url>

				<%-- <c:forEach var="p" items="${list}"> --%>
				<c:forEach var="pd" items="${pagedListHolder.pageList}">
					<div class="item w-1/4 px-3 mb-4 flex flex-col justify-between">
						<div>
							<div class="relative item-menu-container overflow-hidden">
								<a href="${applicationScope.productDetailPage}/${pd.id}"
									class="block overflow-hidden"> <img
									src="${pd.images[0].image}"
									alt="${pd.id}" class="transform hover:scale-110 transition-all" /></a>

								<div
									class="flex justify-center bg-indigo-300 items-center py-1 absolute item__menu w-full">
									<a href="store/insert-to-favlist/${pd.id}/searchseperator${keyword}seperatorquestionmarkp=${pagedListHolder.page}"> <c:set var="contains"
											value="false" /> <c:forEach var="fav"
											items="${listFavorite}">
											<c:if test="${fav.product.id eq pd.id}">
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
									<a href="store/shopping-cart/insert-into-cart/${pd.id}/searchseperator${keyword}seperatorquestionmarkp=${pagedListHolder.page}"><i
										class="fa text-2xl fa-cart-plus text-white hover:text-indigo-200 transition-colors"></i></a>
								</div>
							</div>
							<a href="${applicationScope.productDetailPage}/${pd.id}"
								class="item__name block hover:text-indigo-400 transition-colors font-bold my-2">${pd.name}</a>
						</div>
						<div>
						<span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${pd.price}" type="currency" /></span>
                              <c:if test="${pd.quantity <= 0}">
                              <span class="p-1 ml-1 bg-gray-500 text-white">Hết hàng</span>
                              </c:if>
						</div>
						<%-- <span class="item__price font-bold"><fmt:setLocale value="vi_VN" scope="session" />
                              <fmt:formatNumber value="${pd.price}" type="currency" /></span> --%>
					</div>
				</c:forEach>

			</div>
			<div>
				<tg:paging pagedListHolder="${pagedListHolder}"
					pagedLink="${pagedLink}" />
			</div>
			
		</div>
	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>

</body>

</html>