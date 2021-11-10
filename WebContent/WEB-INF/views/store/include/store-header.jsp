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
        transform: translateX(300px);
        transition: all .3s ease-out;
        z-index: 999999;
    }
    .msg-detail{
        color: white;
        width: 220px;
        padding: 12px;
    }
    .msg.active {
        transform: translateX(0);
        transition: all .3s ease-out;
    }
</style>
<body>
	<div class="overcoat"></div>
	<c:if test="${message!=null}">
	<div class="msg">
        <div class="msg-detail flex justify-between items-center bg-indigo-400 mb-4">
            <span class="block mr-2">${message}</span>
            <i class="fas fa-times cursor-pointer text-2xl"></i>
        </div>
    </div>
    
    <script type="text/javascript">
        var a = document.querySelectorAll(".msg i");
        for (var i = 0; i < a.length; i++) {
            a[i].addEventListener("click", function (e) {
                e.target.parentNode.style.display = "none";
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
         }, 20000);
    </script>
	</c:if>
	
	<header class="header">
		<ul class="nav__top flex justify-end bg-indigo-300">
			<li><a href="#"
				class="px-4 py-1 block font-bold hover:text-indigo-400 transition-colors">HỆ
					THỐNG CỬA HÀNG</a></li>
			<li><a href="#"
				class="px-4 py-1 block font-bold hover:text-indigo-400 transition-colors">VỀ
					MOJI</a></li>
			<li><a href="#"
				class="px-4 py-1 block font-bold hover:text-indigo-400 transition-colors">TUYỂN
					DỤNG</a></li>
		</ul>
		<div class="nav__middle flex justify-between px-32 items-center">
			<div class="nav__middle-left flex justify-between items-center">
				<div class="mobile-menu-button test-ani cursor-pointer hidden">
					<div class="bar-top bg-indigo-300"></div>
					<div class="bar-middle bg-indigo-300"></div>
					<div class="bar-bottom bg-indigo-300"></div>
				</div>
				<a href="${applicationScope.storeIndexPage}"
					class="logo inline-flex items-center mr-5 img-container"> <img
					src="<c:url value='/resources/store/assets/img/logo_200x200 copy.png' />">
				</a>
			</div>

			<div
				class="flex justify-between nav__middle-right flex-1 items-center">
				<div class="nav__middle-bottom flex-1 mt-8">
					<form action="store/search" method="get"
						class="flex border-2 border-indigo-400 rounded-r-lg rounded-l-lg overflow-hidden">
						<input type="text" name="keyword" id="keyword"
							placeholder="Tìm kiếm sản phẩm"
							class="flex-1 outline-none px-3 py-1" />
						<!-- <button><i
                                class="fa fa-search p-2 bg-indigo-300 hover:bg-indigo-400 text-white rounded-r-md hover:text-white"></i></button> -->
						<a href="" id="search-link"><i
							class="fa fa-search p-2 bg-indigo-300 hover:bg-indigo-400 text-white rounded-r-md hover:text-white"></i></a>
					</form>
					<ul class="flex">
						<!-- <li><a href="#" class="pr-2 py-1 block hover:text-indigo-300 transition-colors">Gấu bông</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-indigo-300 transition-colors">Văn phòng phẩm</a>
                        </li>
                        <li><a href="#" class="px-2 py-1 block hover:text-indigo-300 transition-colors">Vòng tay</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-indigo-300 transition-colors">Kẹp tóc</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-indigo-300 transition-colors">Ví</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-indigo-300 transition-colors">Idol</a></li> -->
						<c:forEach var="category" begin="2" end="4" step="1"
							items="${sessionScope.listCategory}">
							<li><a href="store/category/${category.id}"
								class="px-2 py-1 block hover:text-indigo-300 transition-colors">${category.name}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="nav__log-in flex justify-between items-center">
					<div class="hidden mobile-user mr-3">
						<a href="${applicationScope.userInfoPage}"
							class="py-1 block hover:text-indigo-300 transition-colors font-bold"><i
							class="fas fa-user text-2xl"></i></a>
					</div>
					<div class="flex justify-between items-center sign-in-up">
						<c:if test="${sessionScope.customerUsername!=null}">
							<a href="${applicationScope.userInfoPage}"
								class="py-1 block hover:text-indigo-300 transition-colors font-bold mr-2 ml-5">${sessionScope.customerUsername}
								|</a>
							<a href="${applicationScope.logOutPage}"
								class="py-1 block hover:text-indigo-300 transition-colors font-bold mr-4">
								Thoát</a>
						</c:if>
						<c:if
							test="${sessionScope.customerUsername == null || sessionScope.customerUsername == '' }">
							<a href="${applicationScope.signInPage}"
								class="py-1 block hover:text-indigo-300 transition-colors font-bold mr-2 ml-5">Đăng
								nhập |</a>
							<a href="${applicationScope.signUpPage}"
								class="py-1 block hover:text-indigo-300 transition-colors font-bold mr-4">
								Đăng ký</a>
						</c:if>


					</div>
					<a href="${applicationScope.shoppingCartPage}"
						class="py-1 block transition-colors mr-2 relative"><i
						class="hover:text-indigo-300 fa fa-shopping-bag text-2xl"></i> 
						<c:if
							test="${sessionScope.customerUsername!=null}">
							<div
								class="shopping-bag__count absolute bg-red-500 font-bold rounded-full -top-3 -right-3 px-2 text-md">
								${sessionScope.customerTotalQuantity}</div>
						</c:if> 
						<c:if
							test="${sessionScope.customerUsername == null || sessionScope.customerUsername == '' }">
							<div
								class="shopping-bag__count absolute bg-red-500 font-bold rounded-full -top-3 -right-3 px-2 text-md">
								0</div>
						</c:if> </a>
				</div>
			</div>

		</div>
		<div class="nav__bottom flex items-center px-32 bg-indigo-300">
			<div class="nav__bottom-header hidden w-full"></div>
			<ul class="flex items-center">
				<!-- <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Tất cả</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>

                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Gấu bông</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Túi ví</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Văn phòng phẩm</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Điện tử</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Phụ kiện thời trang</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Đồ gia dụng</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Trang điểm</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Du lịch</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Đồ chơi</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Trang trí</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-indigo-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-indigo-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-indigo-400 transition-colors">Idol</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-indigo-400 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-indigo-400b menu item</a></li>
                        </ul>
                    </div>
                </li> -->
				<li class="nav__submenu-container relative">
					<div
						class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
						<a href="store/all"
							class="block font-bold text-sm hover:text-indigo-400 transition-colors">Tất
							cả</a>
						<!-- <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i> -->
					</div>
				</li>
				<c:forEach var="category" items="${sessionScope.listCategory}">
					<li class="nav__submenu-container relative">
						<div
							class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
							<a href="store/category/${category.id}"
								class="block font-bold text-sm hover:text-indigo-400 transition-colors w-full">${category.name}</a>
							<!-- <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i> -->
						</div> <!-- <div class="submenu absolute">
                        <ul class="bg-indigo-200 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-indigo-400 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-indigo-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-indigo-400b menu item</a></li>
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