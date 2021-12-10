<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Quên mật khẩu</title>
<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>

<body>
	<%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
	<main class="main">
		<div
			class="sign-up-form-container mx-auto my-10 border-2 border-gray-200 rounded-md">
			<%-- <div class="flex">
				<a href="${applicationScope.signInPage}"
					class="switch-to-sign-in w-full py-2 relative text-xl text-indigo-400 text-center active-show-after">ĐĂNG
					NHẬP</a><a href="${applicationScope.signUpPage}"
					class="switch-to-sign-up w-full py-2 relative text-xl text-indigo-400 text-center">ĐĂNG
					KÝ</a>
			</div> --%>
			<div class="pt-3 text-xl text-center text-indigo-400" >THÔNG TIN CỦA TÀI KHOẢN CẦN KHÔI PHỤC MẬT KHẨU</div>
			<f:form action="${applicationScope.forgotPassPage}" class="w-full  p-4" method="post"
				modelAttribute="account">
				<f:input type="text" path="username" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Nhập tên đăng nhập" />
				<f:errors path="username" cssClass="error" element="div" />
				<f:input type="text" path="email" id=""
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Nhập email" />
				<f:errors path="email" cssClass="error" element="div" />
				<f:input type="text" path="recoveryCode" id="recoveryCode"
					class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
					placeholder="Mã khôi phục" />
				<f:errors path="recoveryCode" cssClass="error" element="div" />
				
				<button id = "submit-button"
					class="w-full px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md mb-3">LẤY MÃ KHÔI PHỤC</button>
			</f:form>

		</div>

	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
	<!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
	<!-- <script src="./assets/js/sign-up.js"></script> -->
	<%-- <script src="<c:url value='/resources/store/assets/js/sign-up.js'/>"></script> --%>
	<script>
		/* const show = document.getElementById("showPassword");
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
		}); */
		const recoveryInput = document.getElementById("recoveryCode");
		recoveryInput.addEventListener("input", function(e) {
			console.log(1);
			console.log(recoveryInput.value);
			if(recoveryInput.value.trim()===""){
				const submitBtn = document.getElementById("submit-button");
				submitBtn.innerText = "LẤY MÃ KHÔI PHỤC";
			}else{
				const submitBtn = document.getElementById("submit-button");
				submitBtn.innerText = "XÁC NHẬN KHÔI PHỤC";
			}
			
		});
	</script>
</body>

</html>