<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Thay đổi mật khẩu</title>
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
		<div class="main__new-product px-32 mb-12 mt-6">
			<div class="mb-5 font-bold text-xl">
				<a href="${applicationScope.storeIndexPage}"
					class="hover:text-indigo-500 transition-colors">Trang chủ</a> > <a
					href="${applicationScope.userInfoPage}"
					class="hover:text-indigo-500 transition-colors">Hồ sơ cá nhân</a>
				> <span class="text-indigo-500">Thay đổi mật khẩu</span>
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
						<span href="${applicationScope.changePasswordPage}"
							class="text-indigo-500 transition-colors">Đổi mật khẩu</span>
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
						<a href="${applicationScope.orderHistoryPage}"
							class="hover:text-indigo-500 transition-colors">Lịch sử mua hàng</a>
					</div>
					<div class="mb-1">
						<a href="${applicationScope.logOutPage}"
							class="hover:text-indigo-500 transition-colors">Đăng xuất</a>
					</div>
				</div>
				<div class="sign-up-form-container border-2 border-gray-200 flex-1">
					<div class="my-3 px-4 font-bold">THAY ĐỔI MẬT KHẨU</div>
					<div class="px-4">
						<hr class="">
					</div>
					<f:form action="store/user-info/change-password" class="w-full p-4"
						method="post" modelAttribute="customer">
						<div class="flex input-wrapper">
							<label for="" class="mr-3">Mật khẩu cũ: <span
								class="text-red-500">(*)</span></label>
							<div class="w-full">
								<f:input type="password" path="oldPassword" id=""
									class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
									placeholder="Mật khẩu cũ (*)" />
								<f:errors path="oldPassword" cssClass="error" element="div" />
							</div>

						</div>
						<div class="flex input-wrapper">
							<label for="" class="mr-3">Mật khẩu mới: <span
								class="text-red-500">(*)</span></label>
							<div class="w-full">
								<f:input type="password" path="newPassword" id=""
									class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
									placeholder="Mật khẩu mới (*)" />
								<f:errors path="newPassword" cssClass="error" element="div" />
							</div>

						</div>

						<div class="flex input-wrapper">
							<label for="" class="mr-3">Xác nhận mật khẩu mới: <span
								class="text-red-500">(*)</span></label>
							<div class="w-full">
								<f:input type="password" path="confirmNewPassword" id=""
									class="w-full p-2 border-2 border-gray-300 rounded-md mb-3"
									placeholder="Xác nhận mật khẩu mới (*)" />
								<f:errors path="confirmNewPassword" cssClass="error"
									element="div" />
							</div>

						</div>
						<div class="mb-2 flex justify-end">
							<label for="showPassword" class=""><input type="checkbox"
								class="mr-1" id="showPassword">Hiện mật khẩu</label>
						</div>
						<button
							class="w-full px-4 py-2 font-bold bg-indigo-400 hover:bg-indigo-500 transition-colors text-white rounded-md">THAY
							ĐỔI MẬT KHẨU</button>
					</f:form>
				</div>
			</div>
		</div>
	</main>
	<%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>
<script src="<c:url value='/resources/store/assets/js/swiper-bundle.min.js'/>"></script>
	<!-- <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script> -->
	<!-- <script src="./assets/js/main.js"></script> -->
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