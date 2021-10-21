<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
</head>
<body>
<div class="overcoat">
            
</div>
<header class="header">
        <ul class="nav__top flex justify-end bg-pink-300">
            <li><a href="#"
                    class="px-4 py-1 block font-bold hover:text-pink-400 transition-colors">HỆ THỐNG CỬA
                    HÀNG</a></li>
            <li><a href="#" class="px-4 py-1 block font-bold hover:text-pink-400 transition-colors">VỀ MOJI</a></li>
            <li><a href="#" class="px-4 py-1 block font-bold hover:text-pink-400 transition-colors">TUYỂN DỤNG</a></li>
        </ul>
        <div class="nav__middle flex justify-between px-32 items-center">
            <div class="nav__middle-left flex justify-between items-center">
                <div class="mobile-menu-button test-ani cursor-pointer hidden">
                    <div class="bar-top bg-pink-300">

                    </div>
                    <div class="bar-middle bg-pink-300">

                    </div>
                    <div class="bar-bottom bg-pink-300">

                    </div>
                </div>
                <a href="${applicationScope.storeIndexPage}" class="logo inline-flex items-center mr-5 img-container">
                    <img src="<c:url value='/resources/store/assets/img/logo_1626144063_logo web_B2S season.png' />">
                </a>
            </div>

            <div class="flex justify-between nav__middle-right flex-1 items-center">
                <div class="nav__middle-bottom flex-1 mt-8">
                    <form action="" class="flex border-2 border-pink-400 rounded-r-lg rounded-l-lg overflow-hidden">
                        <input type="text" name="" id="" placeholder="Tìm kiếm sản phẩm"
                            class="flex-1 outline-none px-3 py-1">
                        <button><i
                                class="fa fa-search p-2 bg-pink-300 hover:bg-pink-500 text-white rounded-r-md hover:text-white"></i></button>
                    </form>
                    <ul class="flex">
                        <!-- <li><a href="#" class="pr-2 py-1 block hover:text-pink-300 transition-colors">Gấu bông</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Văn phòng phẩm</a>
                        </li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Vòng tay</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Kẹp tóc</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Ví</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Idol</a></li> -->
                        <c:forEach var = "category" begin = "2" end = "4" step="1" items="${applicationScope.listCategory}">
         							<li><a href="store/category/${category.id}" class="px-2 py-1 block hover:text-pink-300 transition-colors">${category.name}</a></li>
      					</c:forEach>
                    </ul>
                </div>
                <div class="nav__log-in flex justify-between items-center">
                    <div class="hidden mobile-user mr-3">
                        <a href="${applicationScope.signInPage}"
                        class="py-1 block hover:text-pink-300 transition-colors font-bold"><i class="fas fa-user text-2xl"></i></a>
                    </div>
                    <div class="flex justify-between items-center sign-in-up"><a href="${applicationScope.signInPage}"
                        class="py-1 block hover:text-pink-300 transition-colors font-bold mr-2 ml-5">Đăng nhập |</a>
                    <a href="${applicationScope.signUpPage}" class="py-1 block hover:text-pink-300 transition-colors font-bold mr-4">
                        Đăng ký</a>
                    </div>
                    <a href="${applicationScope.shoppingCartPage}" class="py-1 block transition-colors mr-2 relative"><i
                        class="hover:text-pink-300 fa fa-shopping-bag text-2xl"></i>
                    <div
                        class="shopping-bag__count absolute bg-red-700 font-bold rounded-full -top-3 -right-3 px-2 text-md">
                        0
                    </div>
                </a>
                </div>
            </div>

        </div>
        <div class="nav__bottom flex items-center px-32 bg-pink-300">
            <div class="nav__bottom-header hidden w-full">

            </div>
            <ul class="flex items-center">
                <!-- <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Tất cả</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>

                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Gấu bông</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Túi ví</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Văn phòng phẩm</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Điện tử</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Phụ kiện thời trang</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Đồ gia dụng</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Trang điểm</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Du lịch</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Đồ chơi</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Trang trí</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#"
                                    class="py-2 px-3 block font-bold border-b-2 border-white text-sm hover:text-pink-400">Sub
                                    menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold hover:text-pink-400 text-sm">Sub menu item</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="#" class="block font-bold text-sm hover:text-pink-400 transition-colors">Idol</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-pink-400 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-pink-400b menu item</a></li>
                        </ul>
                    </div>
                </li> -->
                <li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="store/all" class="block font-bold text-sm hover:text-pink-400 transition-colors">Tất cả</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                </li>
                <c:forEach var="category" items="${applicationScope.listCategory}">
                	<li class="nav__submenu-container relative">
                    <div class="cursor-pointer px-2 py-3 flex justify-between border-b-2 border-white">
                        <a href="store/category/${category.id}" class="block font-bold text-sm hover:text-pink-400 transition-colors">${category.name}</a>
                        <i class="fa fa-chevron-down flex-1 nav__submenu-container pr-2 hidden"></i>
                    </div>
                    <!-- <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-pink-400 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-pink-400b menu item</a></li>
                        </ul>
                    </div> -->
                </li>
                </c:forEach>
            </ul>
        </div>
    </header>
</body>
</html>