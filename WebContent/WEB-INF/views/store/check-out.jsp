<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Thanh Toán</title>
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

@import
	url('https://fonts.googleapis.com/css2?family=Catamaran:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap')
	;

.main-container {
	width: 90%;
	max-width: 350px;
	margin: 50px auto;
}

.select-item {
	width: 100%;
	font-family: 'Montserrat', sans-serif;
	margin: 15px auto;
	position: relative;
}

.select-item>label {
	display: block;
	font-size: 18px;
}

.select-item>select {
	margin-top: 10px;
	width: 100%;
	font-family: 'Montserrat', sans-serif;
	font-size: 16px;
	line-height: 36px;
	height: 36px;
	border-radius: 3px;
	outline: none;
	background: none;
	box-shadow: none;
	border: 1px solid rgb(175, 175, 175);
}

.select-item>span {
	position: absolute;
	width: 22px;
	height: 22px;
	right: 22px;
	top: 38px;
	display: none;
	z-index: 5;
}

.select-item>span>img {
	width: 100%;
	height: 100%;
}
</style>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div class="main__new-product px-32 mb-12 mt-6">
			<div class="mb-5 font-bold text-xl">
				<a href="${applicationScope.shoppingCartPage}"
					class="hover:text-indigo-500 transition-colors">Giỏ hàng</a> > <span
					class="text-indigo-500">Thanh toán</span>
			</div>
			<div class="">

				<f:form action="store/shopping-cart/check-out"
					class="w-full flex flex-wrap check-out-wrapper" method="post"
					modelAttribute="order">
					<div
						class="sign-up-form-container border-2 border-gray-200 w-full flex-1">
						<div class="my-3 px-4 font-bold">1. THÔNG TIN NGƯỜI NHẬN</div>
						<div class="px-4">
							<hr class="">
						</div>
						<div class="p-4">
							<div class="flex input-wrapper">
								<label for="" class="mr-3">Họ tên: <span
									class="text-red-500">(*)</span></label>
								<div class="w-full">
									<f:input type="text" path="shipName" id=""
										class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
										placeholder="Họ (*)"
										value="${customerEntity.firstname} ${customerEntity.lastname}" />
									<f:errors path="shipName" cssClass="error" element="div" />
								</div>

							</div>

							<div class="flex input-wrapper">
								<label for="" class="mr-3">Điện thoại: <span
									class="text-red-500">(*)</span></label>
								<div class="w-full">
									<f:input type="text" path="shipPhone" id=""
										class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
										placeholder="Điện thoại (*)" value="${customerEntity.phone}" />
									<f:errors path="shipPhone" cssClass="error" element="div" />
								</div>

							</div>
							<div class="flex input-wrapper">
								<label for="" class="mr-3">Email: <span
									class="text-red-500">(*)</span></label>
								<div class="w-full">
									<f:input type="text" path="shipEmail" id=""
										class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
										placeholder="Email (*)" value="${customerEntity.email}" />
									<f:errors path="shipEmail" cssClass="error" element="div" />
								</div>

							</div>
							<%-- <div class="flex input-wrapper">
                                <label for="" class="mr-3">Tỉnh/Thành phố: <span
                                        class="text-red-500">(*)</span></label>
                                <div class="w-full">
                                    <f:select id="cityId" path="shipCity"
                                        class="w-full p-2 border-2 border-gray-300 rounded-md mb-3">
                                        <f:option value="NONE" label="Tỉnh/Thành phố *" />
                                        <f:option value="254" label="Hà Nội" />
                                        <f:option value="255" label="Hồ Chí Minh" />
                                        <f:option value="256" label="An Giang" />
                                        <f:option value="257" label="Bà Rịa - Vũng Tàu" />
                                        <f:option value="258" label="Bắc Ninh" />
                                        <f:option value="259" label="Bắc Giang" />
                                        <f:option value="260" label="Bình Dương" />
                                        <f:option value="261" label="Bình Định" />
                                        <f:option value="262" label="Bình Phước" />
                                        <f:option value="263" label="Bình Thuận" />
                                        <f:option value="264" label="Bến Tre" />
                                        <f:option value="265" label="Bắc Cạn" />
                                        <f:option value="266" label="Cần Thơ" />
                                        <f:option value="267" label="Khánh Hòa" />
                                        <f:option value="268" label="Thừa Thiên Huế" />
                                        <f:option value="269" label="Lào Cai" />
                                        <f:option value="270" label="Quảng Ninh" />
                                        <f:option value="271" label="Đồng Nai" />
                                        <f:option value="272" label="Nam Định" />
                                        <f:option value="273" label="Cà Mau" />
                                        <f:option value="274" label="Cao Bằng" />
                                        <f:option value="275" label="Gia Lai" />
                                        <f:option value="276" label="Hà Giang" />
                                        <f:option value="277" label="Hà Nam" />
                                        <f:option value="278" label="Hà Tĩnh" />
                                        <f:option value="279" label="Hải Dương" />
                                        <f:option value="280" label="Hải Phòng" />
                                        <f:option value="281" label="Hòa Bình" />
                                        <f:option value="282" label="Hưng Yên" />
                                        <f:option value="283" label="Kiên Giang" />
                                        <f:option value="284" label="Kon Tum" />
                                        <f:option value="285" label="Lai Châu" />
                                        <f:option value="286" label="Lâm Đồng" />
                                        <f:option value="287" label="Lạng Sơn" />
                                        <f:option value="288" label="Long An" />
                                        <f:option value="289" label="Nghệ An" />
                                        <f:option value="290" label="Ninh Bình" />
                                        <f:option value="291" label="Ninh Thuận" />
                                        <f:option value="292" label="Phú Thọ" />
                                        <f:option value="293" label="Phú Yên" />
                                        <f:option value="294" label="Quảng Bình" />
                                        <f:option value="295" label="Quảng Nam" />
                                        <f:option value="296" label="Quảng Ngãi" />
                                        <f:option value="297" label="Quảng Trị" />
                                        <f:option value="298" label="Sóc Trăng" />
                                        <f:option value="299" label="Sơn La" />
                                        <f:option value="300" label="Tây Ninh" />
                                        <f:option value="301" label="Thái Bình" />
                                        <f:option value="302" label="Thái Nguyên" />
                                        <f:option value="303" label="Thanh Hóa" />
                                        <f:option value="304" label="Tiền Giang" />
                                        <f:option value="305" label="Trà Vinh" />
                                        <f:option value="306" label="Tuyên Quang" />
                                        <f:option value="307" label="Vĩnh Long" />
                                        <f:option value="308" label="Vĩnh Phúc" />
                                        <f:option value="309" label="Yên Bái" />
                                        <f:option value="310" label="Đắk Lắk" />
                                        <f:option value="311" label="Đồng Tháp" />
                                        <f:option value="312" label="Đà Nẵng" />
                                        <f:option value="313" label="Đắc Nông" />
                                        <f:option value="314" label="Hậu Giang" />
                                        <f:option value="315" label="Bạc Liêu" />
                                        <f:option value="316" label="Điện Biên" />
                                    </f:select>
                                    <f:errors path="shipCity" cssClass="error" element="div" />
                                </div>

                            </div> --%>
							<%-- <div class="flex input-wrapper">
                                <label for="" class="mr-3">Quận/ Huyện: <span class="text-red-500">(*)</span></label>
                                <div class="w-full">
                                    <f:select id="districtId" path="district"
                                        class="w-full p-2 border-2 border-gray-300 rounded-md mb-3">
                                        <f:option value="None" label="Quận/ Huyện*" />
                                    </f:select>
                                    <f:errors path="district" cssClass="error" element="div" />
                                </div>


                            </div> --%>


							<div class="flex input-wrapper">
								<label for="" class="mr-3">Địa chỉ: <span
									class="text-red-500">(*)</span></label>
								<div class="w-full">
									<f:input type="text" path="shipAddress" id=""
										class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
										placeholder="Địa chỉ (*)"
										value="${customerEntity.address}" />
									<f:errors path="shipAddress" cssClass="error" element="div" />
								</div>

							</div>
							<div class="flex input-wrapper">
								<label for="" class="mr-3">Ghi chú: <!-- <span class="text-red-500">(*)</span> --></label>
								<div class="w-full">
									<f:textarea type="text" path="shipNote" id=""
										class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
										placeholder="Ghi chú (không bắt buộc)" value="" />
									<f:errors path="shipNote" cssClass="error" element="div" />
								</div>

							</div>
						</div>

					</div>


					<div class="border-2 border-gray-200 w-full flex-1">
						<div class="my-3 px-4 font-bold">2. THÔNG TIN GIỎ HÀNG</div>
						<div class="px-4">
							<hr class="">
						</div>
						<div class="w-full p-4">
							<table class="cart-list__table mb-4">
								<thead>
									<tr class="card-list__table-header font-bold">
										<th>Tên</th>
										<th>Số lượng</th>
										<th>Thành tiền</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${cartDetails}">
										<tr class="card-list__table-item">
											<!-- desc = tên sản phẩm + màu sắc + kích cỡ (nếu có) -->
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
							</table>
							<div class="flex justify-between border-t my-1 py-2">
								<span class="">Tạm tính</span> <span class="font-bold"><fmt:setLocale
										value="vi_VN" scope="session" /> <fmt:formatNumber
										value="${cartDetailsTotal}" type="currency" /></span>
							</div>
							<div class="flex justify-between border-t my-1 py-2">
								<span class="">Phí vận chuyển</span> <span class="font-bold"><fmt:setLocale
										value="vi_VN" scope="session" /> <fmt:formatNumber
										value="0" type="currency" /></span>
							</div>
							<div class="flex justify-between border-t my-1 py-2">
								<span class="">Tổng cộng</span> <span class="font-bold"><fmt:setLocale
										value="vi_VN" scope="session" /> <fmt:formatNumber
										value="${cartDetailsTotal + 0}" type="currency" /></span>
							</div>
						</div>
					</div>

					<div class="w-full flex justify-end">
						<button
							class="px-4 py-2 my-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md">Thanh
							toán</button>
					</div>

				</f:form>
				
			</div>

		</div>
	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<!-- <script src="https://unpkg.com/axios/dist/axios.min.js"></script> -->
	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
<%-- 	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script> --%>
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<%-- <script src="<c:url value='/resources/store/assets/js/check-out.js'/>"></script> --%>
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