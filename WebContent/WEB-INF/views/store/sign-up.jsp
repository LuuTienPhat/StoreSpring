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
</style>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div
			class="sign-up-form-container mx-auto my-10 border-2 border-gray-200 rounded-md">
			<div class="flex">
				<a href="${applicationScope.signInPage}"
					class="switch-to-sign-in w-full py-2 relative text-xl text-indigo-300 text-center">ĐĂNG
					NHẬP</a><a href="${applicationScope.signUpPage}"
					class="switch-to-sign-up w-full py-2 relative text-xl text-indigo-300 text-center active-show-after">ĐĂNG
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
				<f:select id="cityId" path="city"
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
				<f:errors path="district" cssClass="error" element="div" />
				<f:input type="text" path="specificAddress" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Địa chỉ chi tiết (*)" />
				<f:errors path="specificAddress" cssClass="error" element="div" />
				<f:input type="password" path="password" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Mật khẩu của bạn (*)" />
				<f:errors path="password" cssClass="error" element="div" />
				<f:input type="password" path="confirmPassword" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Nhập lại mật khẩu (*)" />
				<f:errors path="confirmPassword" cssClass="error" element="div" />
				<button
					class="w-full px-4 py-2 font-bold bg-indigo-300 hover:bg-indigo-400 transition-colors text-white rounded-md">ĐĂNG
					KÝ</button>
			</f:form>
		</div>

	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/sign-up.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/sign-up.js'/>"></script>
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