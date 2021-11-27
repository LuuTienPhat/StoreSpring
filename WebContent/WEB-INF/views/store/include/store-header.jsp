<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
</head>
<style>
.msg {
	position: fixed;
	top: 200px;
	right: 30px;
	transform: translateX(320px);
	transition: all .3s ease-out;
	z-index: 999999;
	visibility: hidden;
}

.msg-detail {
	color: white;
	width: 240px;
	/* padding: 12px; */
}

.msg.active {
	transform: translateX(0);
	transition: all .3s ease-out;
	visibility: visible;
}

@import
	url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap')
	;

* {
	font-family: 'Source Sans Pro', sans-serif;
}
</style>
<body>
	<div class="overcoat"></div>
	<c:if test="${message!=null}">
		<div class="msg rounded-md overflow-hidden">
			<div
				class="msg-detail flex justify-between items-center bg-indigo-500 h-full ">
				<span class="p-2">${message}</span>
				<div
					class="cursor-pointer p-2 hover:bg-indigo-400 self-stretch transition-all flex items-center">
					<i class="fas fa-times text-2xl "></i>
				</div>

			</div>
		</div>

		<script type="text/javascript">
        var a = document.querySelectorAll(".msg i");
        for (var i = 0; i < a.length; i++) {
            a[i].addEventListener("click", function (e) {
                e.target.parentNode.parentNode.parentNode.classList.remove("active");
            })
        }
        document.addEventListener('readystatechange', event => {
            setTimeout(function(){}, 3000);
            const msgs = document.querySelectorAll(".msg");
            for (var i = 0; i < msgs.length; i++) {
                msgs[i].classList.add("active");
            }
        });
        setTimeout(function(){
            const msgs = document.querySelectorAll(".msg");
            for (var i = 0; i < msgs.length; i++) {
                if(msgs[i].classList.contains("active")){
                    msgs[i].classList.remove("active");
                }
                
            }
         }, 10000);
    </script>
	</c:if>

	<header class="header">
		<ul class="nav__top flex justify-end bg-indigo-300">
			<li><a href="#store-address"
				class="px-4 py-1 block font-bold hover:text-indigo-500 transition-colors">HỆ
					THỐNG CỬA HÀNG</a></li>
			<li><a href="#"
				class="px-4 py-1 block font-bold hover:text-indigo-500 transition-colors">VỀ
					STORE SPRING 21</a></li>
			<!-- 			<li><a href="#"
				class="px-4 py-1 block font-bold hover:text-indigo-500 transition-colors">TUYỂN
					DỤNG</a></li> -->
		</ul>
		<div class="nav__middle flex justify-between px-32 items-center">
			<div class="nav__middle-left flex justify-between items-center">
				<div class="mobile-menu-button test-ani cursor-pointer hidden">
					<div class="bar-top bg-indigo-300"></div>
					<div class="bar-middle bg-indigo-300"></div>
					<div class="bar-bottom bg-indigo-300"></div>
				</div>
				<a href="${applicationScope.storeIndexPage}"
					class="logo inline-flex items-center mr-5 img-container"
					style="width: 160px; height: 47px;"> <img
					src="<c:url value='/resources/store/assets/img/new-logo_200x200 - 1.png' />">
				</a>
				<%-- <a href="${applicationScope.storeIndexPage}"
					class="logo inline-flex items-center mr-5 img-container" style="height:47px; max-width:190px !important;"> <span class="text-indigo-500 mr-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-asterisk" viewBox="0 0 16 16">
                            <path
                                d="M8 0a1 1 0 0 1 1 1v5.268l4.562-2.634a1 1 0 1 1 1 1.732L10 8l4.562 2.634a1 1 0 1 1-1 1.732L9 9.732V15a1 1 0 1 1-2 0V9.732l-4.562 2.634a1 1 0 1 1-1-1.732L6 8 1.438 5.366a1 1 0 0 1 1-1.732L7 6.268V1a1 1 0 0 1 1-1z"
                            />
                        </svg>
                    </span>
                    <span class="uppercase font-bold text-xl">Store Spring 21</span>
				</a> --%>
			</div>

			<div
				class="flex justify-between nav__middle-right flex-1 items-center">
				<div class="nav__middle-bottom flex-1 mt-8">
					<form action="store/search" method="get"
						class="flex border-2 border-indigo-500 rounded-r-lg rounded-l-lg overflow-hidden">
						<input type="text" name="keyword" id="keyword"
							placeholder="Tìm kiếm sản phẩm"
							class="flex-1 outline-none px-3 py-1" />
						<!-- <button><i
                                class="fa fa-search p-2 bg-indigo-400 hover:bg-indigo-500 text-white rounded-r-md hover:text-white"></i></button> -->
						<a href="" id="search-link"><i
							class="fa fa-search p-2 bg-indigo-400 hover:bg-indigo-500 text-white rounded-r-md hover:text-white"></i></a>
					</form>
					<ul class="flex" style="height: 30px">
						<%-- <c:forEach var="category" begin="2" end="4" step="1"
							items="${sessionScope.listCategory}">
							<li><a href="store/category/${category.id}"
								class="px-2 py-1 block hover:text-indigo-400 transition-colors">${category.name}</a></li>
						</c:forEach> --%>
						<li><span class="py-1 block"><i
								class="fas fa-history mr-1"></i>Tìm kiếm gần đây:</span></li>
						<c:if test="${sessionScope.listRecentSearch !=null}">
							<c:forEach var="key" items="${sessionScope.listRecentSearch}">
								<li><a href="store/search/${key}"
									class="px-2 py-1 block hover:text-indigo-400 italic transition-colors">${key}</a></li>
							</c:forEach>
						</c:if>

					</ul>
				</div>
				<div class="nav__log-in flex justify-between items-center">
					<div class="hidden mobile-user mr-3">
						<a href="${applicationScope.userInfoPage}"
							class="py-1 block hover:text-indigo-400 transition-colors font-bold"><i
							class="fas fa-user text-2xl"></i></a>
					</div>
					<div class="flex justify-between items-center sign-in-up">
						<c:if test="${sessionScope.customerUsername!=null}">
							<a href="${applicationScope.userInfoPage}"
								class="py-1 block hover:text-indigo-400 transition-colors font-bold mr-2 ml-5">${sessionScope.customerUsername}
								|</a>
							<a href="${applicationScope.logOutPage}"
								class="py-1 block hover:text-indigo-400 transition-colors font-bold mr-4">
								Thoát</a>
						</c:if>
						<c:if
							test="${sessionScope.customerUsername == null || sessionScope.customerUsername == '' }">
							<a href="${applicationScope.signInPage}"
								class="py-1 block hover:text-indigo-400 transition-colors font-bold mr-2 ml-5">Đăng
								nhập |</a>
							<a href="${applicationScope.signUpPage}"
								class="py-1 block hover:text-indigo-400 transition-colors font-bold mr-4">
								Đăng ký</a>
						</c:if>


					</div>
					<a href="${applicationScope.shoppingCartPage}"
						class="py-1 block transition-colors mr-2 relative"><i
						class="hover:text-indigo-400 fa fa-shopping-bag text-2xl"></i> <c:if
							test="${sessionScope.customerUsername!=null}">
							<div
								class="shopping-bag__count absolute bg-red-500 font-bold rounded-full -top-3 -right-3 px-2 text-md">
								${sessionScope.customerTotalQuantity}</div>
						</c:if> <c:if
							test="${sessionScope.customerUsername == null || sessionScope.customerUsername == '' }">
							<div
								class="shopping-bag__count absolute bg-red-500 font-bold rounded-full -top-3 -right-3 px-2 text-md">
								0</div>
						</c:if> </a>
				</div>
			</div>

		</div>
		<div
			class="nav__bottom flex items-center px-32 bg-indigo-300 uppercase">
			<div class="nav__bottom-header hidden w-full"></div>
			<ul class="flex items-center">
				<!-- <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-500 transition-colors">Idol</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-300 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-indigo-500 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-500b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-500b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-indigo-500b menu item</a></li>
                        </ul>
                    </div>
                </li> -->
				<li class="nav__submenu-container relative">
					<div
						class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
						<a href="store/all"
							class="block font-bold text-sm hover:text-indigo-200 transition-colors">Tất
							cả</a>
						<!-- <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i> -->
					</div>
				</li>
				<c:forEach var="category" items="${sessionScope.listCategory}">
					<li class="nav__submenu-container relative">
						<div
							class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
							<a href="store/category/${category.id}"
								class="block font-bold text-sm hover:text-indigo-200 transition-colors w-full">${category.name}</a>
							<!-- <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i> -->
						</div> <!-- <div class="submenu absolute">
                        <ul class="bg-indigo-300 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-indigo-500 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-500b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-500b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-indigo-500b menu item</a></li>
                        </ul>
                    </div> -->
					</li>
				</c:forEach>
			</ul>
		</div>
	</header>
	<script>
		const keywordInput = document.getElementById("keyword");
		keywordInput.addEventListener("input", function(e) {
			const searchLink = document.getElementById("search-link");
			searchLink.href = "store/search/" + this.value;
		});
	</script>
</body>
</html>