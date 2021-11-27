<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Đăng ký</title>
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

.select-item {
	width: 100%;
	position: relative;
}

.select-item>span {
	position: absolute;
	width: 22px;
	height: 22px;
	right: 22px;
	top: 12px;
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
		<div
			class="sign-up-form-container mx-auto my-10 border-2 border-gray-200 rounded-md">
			<div class="flex">
				<a href="${applicationScope.signInPage}"
					class="switch-to-sign-in w-full py-2 relative text-xl text-indigo-400 text-center">ĐĂNG
					NHẬP</a><a href="${applicationScope.signUpPage}"
					class="switch-to-sign-up w-full py-2 relative text-xl text-indigo-400 text-center active-show-after">ĐĂNG
					KÝ</a>
			</div>



			<f:form action="store/sign-up" class="w-full p-4" method="post"
				modelAttribute="customer">
				<f:input type="text" path="username" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Tên đăng nhập (*)" />
				<f:errors path="username" cssClass="error" element="div" />
				<f:input type="text" path="firstName" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Họ (*)" />
				<f:errors path="firstName" cssClass="error" element="div" />
				<f:input type="text" path="lastName" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Tên (*)" />
				<f:errors path="lastName" cssClass="error" element="div" />
				<%-- <f:input type="date" path="dateofbirth" id="datePicker"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Ngày sinh (*)" />
				<f:errors path="dateofbirth" cssClass="error" element="div" /> --%>
				<f:input type="text" path="telephone" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Điện thoại (*)" />
				<f:errors path="telephone" cssClass="error" element="div" />
				<f:input type="text" path="email" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Email (*)" />
				<f:errors path="email" cssClass="error" element="div" />
				<%-- 				<div class="select-item">
					<f:select
						class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
						id="city-province" path="city">
						<f:option value='0' label="Chọn Tỉnh/Thành Phố (*)" />
						<f:option value='01' label="Thành phố Hà Nội" />
						<f:option value='79' label="Thành phố Hồ Chí Minh" />
						<f:option value='31' label="Thành phố Hải Phòng" />
						<f:option value='48' label="Thành phố Đà Nẵng" />
						<f:option value='92' label="Thành phố Cần Thơ" />
						<f:option value='02' label="Tỉnh Hà Giang" />
						<f:option value='04' label="Tỉnh Cao Bằng" />
						<f:option value='06' label="Tỉnh Bắc Kạn" />
						<f:option value='08' label="Tỉnh Tuyên Quang" />
						<f:option value='10' label="Tỉnh Lào Cai" />
						<f:option value='11' label="Tỉnh Điện Biên" />
						<f:option value='12' label="Tỉnh Lai Châu" />
						<f:option value='14' label="Tỉnh Sơn La" />
						<f:option value='15' label="Tỉnh Yên Bái" />
						<f:option value='17' label="Tỉnh Hoà Bình" />
						<f:option value='19' label="Tỉnh Thái Nguyên" />
						<f:option value='20' label="Tỉnh Lạng Sơn" />
						<f:option value='22' label="Tỉnh Quảng Ninh" />
						<f:option value='24' label="Tỉnh Bắc Giang" />
						<f:option value='25' label="Tỉnh Phú Thọ" />
						<f:option value='26' label="Tỉnh Vĩnh Phúc" />
						<f:option value='27' label="Tỉnh Bắc Ninh" />
						<f:option value='30' label="Tỉnh Hải Dương" />
						<f:option value='33' label="Tỉnh Hưng Yên" />
						<f:option value='34' label="Tỉnh Thái Bình" />
						<f:option value='35' label="Tỉnh Hà Nam" />
						<f:option value='36' label="Tỉnh Nam Định" />
						<f:option value='37' label="Tỉnh Ninh Bình" />
						<f:option value='38' label="Tỉnh Thanh Hóa" />
						<f:option value='40' label="Tỉnh Nghệ An" />
						<f:option value='42' label="Tỉnh Hà Tĩnh" />
						<f:option value='44' label="Tỉnh Quảng Bình" />
						<f:option value='45' label="Tỉnh Quảng Trị" />
						<f:option value='46' label="Tỉnh Thừa Thiên Huế" />
						<f:option value='49' label="Tỉnh Quảng Nam" />
						<f:option value='51' label="Tỉnh Quảng Ngãi" />
						<f:option value='52' label="Tỉnh Bình Định" />
						<f:option value='54' label="Tỉnh Phú Yên" />
						<f:option value='56' label="Tỉnh Khánh Hòa" />
						<f:option value='58' label="Tỉnh Ninh Thuận" />
						<f:option value='60' label="Tỉnh Bình Thuận" />
						<f:option value='62' label="Tỉnh Kon Tum" />
						<f:option value='64' label="Tỉnh Gia Lai" />
						<f:option value='66' label="Tỉnh Đắk Lắk" />
						<f:option value='67' label="Tỉnh Đắk Nông" />
						<f:option value='68' label="Tỉnh Lâm Đồng" />
						<f:option value='70' label="Tỉnh Bình Phước" />
						<f:option value='72' label="Tỉnh Tây Ninh" />
						<f:option value='74' label="Tỉnh Bình Dương" />
						<f:option value='75' label="Tỉnh Đồng Nai" />
						<f:option value='77' label="Tỉnh Bà Rịa - Vũng Tàu" />
						<f:option value='80' label="Tỉnh Long An" />
						<f:option value='82' label="Tỉnh Tiền Giang" />
						<f:option value='83' label="Tỉnh Bến Tre" />
						<f:option value='84' label="Tỉnh Trà Vinh" />
						<f:option value='86' label="Tỉnh Vĩnh Long" />
						<f:option value='87' label="Tỉnh Đồng Tháp" />
						<f:option value='89' label="Tỉnh An Giang" />
						<f:option value='91' label="Tỉnh Kiên Giang" />
						<f:option value='93' label="Tỉnh Hậu Giang" />
						<f:option value='94' label="Tỉnh Sóc Trăng" />
						<f:option value='95' label="Tỉnh Bạc Liêu" />
						<f:option value='96' label="Tỉnh Cà Mau" />
					</f:select>
				</div>
				<f:errors path="city" cssClass="error" element="div" />
				<div class="select-item district-town-select">
					<f:select
						class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
						path="district" id="district-town">
						<f:option value='0' label="Chọn Quận/Huyện (*)" />
					</f:select>
					<span><img
						src="https://firebasestorage.googleapis.com/v0/b/qtv-music-shop.appspot.com/o/loading-icon%2Floading-icon-small.gif?alt=media&token=769f1086-0302-4e17-852e-e1409ec215b4"
						alt="loading-icon"></span>
				</div>
				<f:errors path="district" cssClass="error" element="div" />
				<div class="select-item ward-commune-select">
					<f:select
						class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
						path="commune" id="ward-commune">
						<f:option value='0' label="Chọn Phường/Xã (*)" />
					</f:select>
					<span><img
						src="https://firebasestorage.googleapis.com/v0/b/qtv-music-shop.appspot.com/o/loading-icon%2Floading-icon-small.gif?alt=media&token=769f1086-0302-4e17-852e-e1409ec215b4"
						alt="loading-icon"></span>
				</div>
				<f:errors path="commune" cssClass="error" element="div" />
 --%>
				<%-- <f:select id="cityId" path="city"
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
				<f:errors path="city" cssClass="error" element="div" />
				<f:select id="districtId" path="district"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3">
					<f:option value="None" label="Quận/ Huyện*" />
				</f:select>
				<f:errors path="district" cssClass="error" element="div" /> --%>
				<%-- 				<f:input type="text" path="specificAddress" id="specific-address"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Địa chỉ chi tiết (*)" />
				<f:errors path="specificAddress" cssClass="error" element="div" /> --%>

				<%-- 				<f:input type="text" path="fullAddress" id="full-address"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" /> --%>
				<f:input type="text" path="fullAddress" id="full-address"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Địa chỉ (*)" />
				<f:errors path="fullAddress" cssClass="error" element="div" />
				<!-- <script>
					const fullAddressInput = document.querySelector("#full-address");
					const citySelect = document.querySelector("#city-province");
					const districtSelect = document.querySelector("#district-town");
					const communeSelect = document.querySelector("#ward-commune");
					const specificInput = document.querySelector("#specific-address");
					const updateFullAddress = function() {
						fullAddressInput.value = specificInput.value + ", "
								+ communeSelect.options[communeSelect.selectedIndex].innerHTML + ", "
								+ districtSelect.options[districtSelect.selectedIndex].innerHTML + ", "
								+ citySelect.options[citySelect.selectedIndex].innerHTML;
					}
					citySelect.addEventListener("change", updateFullAddress);
					districtSelect.addEventListener("change", updateFullAddress);
					communeSelect.addEventListener("change", updateFullAddress);
					specificInput.addEventListener("input", updateFullAddress);
				</script> -->

				<f:input type="password" path="password" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Mật khẩu của bạn (*)" />
				<f:errors path="password" cssClass="error" element="div" />
				<f:input type="password" path="confirmPassword" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Nhập lại mật khẩu (*)" />
				<f:errors path="confirmPassword" cssClass="error" element="div" />
				<div class="mb-2 flex justify-end">
					<label for="showPassword" class=""><input type="checkbox"
						class="mr-1" id="showPassword">Hiện mật khẩu</label>
				</div>
				<button
					class="w-full px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md">ĐĂNG
					KÝ</button>
			</f:form>
		</div>

	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
<!-- 	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
<%-- 	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script> --%>
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<%-- <script src="<c:url value='/resources/store/assets/js/check-out.js'/>"></script> --%>
	<!-- <script src="./assets/js/sign-up.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/sign-up.js'/>"></script>
	<script type="text/javascript">
		var a = document.getElementsByClassName("error");
		for (var i = 0; i < a.length; i++) {
			a[i].addEventListener("click", function(e) {
				e.target.style.display = "none";
			})
		}
		const show = document.getElementById("showPassword");
		const inputPasswordField = document
				.querySelectorAll('input[type="password"]');
		show.addEventListener("click", function(e) {
			if (this.checked) {
				for (var i = 0; i < inputPasswordField.length; i++) {
					inputPasswordField[i].type = "text";
				}
			} else {
				for (var i = 0; i < inputPasswordField.length; i++) {
					inputPasswordField[i].type = "password";
				}
			}
		});
	</script>
</body>

</html>