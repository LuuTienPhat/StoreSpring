<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đăng nhập</title>
    <%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
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
                <a href="" class="logo inline-flex items-center mr-5 img-container">
                    <img src="./assets/img/logo_1626144063_logo web_B2S season.png">
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
                        <li><a href="#" class="pr-2 py-1 block hover:text-pink-300 transition-colors">Gấu bông</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Văn phòng phẩm</a>
                        </li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Vòng tay</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Kẹp tóc</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Ví</a></li>
                        <li><a href="#" class="px-2 py-1 block hover:text-pink-300 transition-colors">Idol</a></li>
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
                <li class="nav__submenu-container relative">
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
                    <!-- <div class="submenu absolute">
                        <ul class="bg-pink-200 w-44">
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Sub hover:text-pink-400 menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold border-b-2 border-white text-sm">Su hover:text-pink-400b menu item</a></li>
                            <li><a href="#" class="py-1 px-3 block font-bold">Su hover:text-pink-400b menu item</a></li>
                        </ul>
                    </div> -->
                </li>
            </ul>
        </div>
    </header>
    <main class="main">
        <div class="sign-up-form-container mx-auto my-10 border-2 border-gray-100 rounded-md">
            <div class="flex"><a href="#"
                    class="switch-to-sign-in w-full py-2 relative text-xl text-pink-300 text-center active-show-after">ĐĂNG
                    NHẬP</a><a href="${applicationScope.signUpPage}"
                    class="switch-to-sign-up w-full py-2 relative text-xl text-pink-300 text-center">ĐĂNG KÝ</a>
            </div>
            <form action="" class="w-full  p-4">
                <input type="text" name="username" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Nhập tên đăng nhập hoặc email">
                <input type="text" name="fullname" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Mật khẩu">
                
                <button class="w-full px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md mb-3">ĐĂNG KÝ</button>
                <a href="#" class="pr-2 py-1 block hover:text-pink-300 transition-colors w-full text-center mb-3">Quên mật khẩu?</a>
                <h4 class="text-center mb-3">Hoặc đăng nhập với</h4>
                <button class="w-full px-4 py-2 font-bold bg-blue-700 hover:bg-blue-500 transition-colors text-white rounded-md mb-3"><i class="fab fa-facebook-f mr-1"></i>Đăng nhập bằng Facebook</button>
                <button class="w-full px-4 py-2 font-bold bg-red-700 hover:bg-red-500 transition-colors text-white rounded-md"><i class="fab fa-google mr-1"></i>Đăng nhập bằng Google</button>
            </form>
        </div>

    </main>
    <footer>
        <div class="section px-32 py-5 bg-pink-300 flex text-white font-medium">
            <div class="mr-3 flex flex-col">
                <span class="text-md">Hotline</span>
                <span class="text-xl mb-4">0987654321</span>
                <span class="text-md">Email</span>
                <span class="text-lg mb-4">cskh@email.com</span>
                <a class="text-sm mb-2" href="#">CHÍNH SÁCH BÁN HÀNG</a>
                <a class="text-sm" href="#">HƯỚNG DẪN MUA HÀNG</a>
            </div>
            <div class="mx-3">
                <h3 class="text-md">HÀ NỘI</h3>
                <ul class="list-disc pl-6 text-sm">
                    <li class="">81 Bà Triệu, Hai Bà Trưng</li>
                    <li class="">226 Nguyễn Trãi, Nam Từ Liêm (gần ĐH Hà Nội)</li>
                    <li class="">226 Nguyễn Trãi, Nam Từ Liêm (gần ĐH Hà Nội)</li>
                    <li class="">81 Bà Triệu, Hai Bà Trưng</li>
                    <li class="">81 Bà Triệu, Hai Bà Trưng</li>
                    <li class="">81 Bà Triệu, Hai Bà Trưng</li>
                </ul>
            </div>
            <div class="mx-3">
                <h3 class="text-md">TP.HỒ CHÍ MINH</h3>
                <ul class="list-disc pl-6 text-sm">
                    <li class="">92 Hồ Tùng Mậu, P.Bến Nghé, Q1</li>
                    <li class="">708 Sư Vạn Hạnh, P.12, Q.10 (đối diện chéo Vạn Hạnh Mall)</li>
                    <li class="">87 Bàu Cát, P.14, Q.Tân Bình (khúc giao Nguyễn Hồng Đào)</li>
                    <li class="">87 Bàu Cát, P.14, Q.Tân Bình (khúc giao Nguyễn Hồng Đào)</li>
                    <li class="">92 Hồ Tùng Mậu, P.Bến Nghé, Q1</li>
                    <li class="">92 Hồ Tùng Mậu, P.Bến Nghé, Q1</li>
                </ul>
            </div>

            <div class="flex flex-col w-32 ml-3">
                <div class="">
                    <a href="#" class="w-full"><img src="./assets/img/logo-f.png"></a>
                </div>
                <span class="mb-1">Hãy kết nối với chúng mình</span>
                <div class="flex justify-between items-center h-fit mb-2 social">
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="./assets/img/social-color-insta.png" class="h-15"></a></div>
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="./assets/img/social-color-youtube.png" class="h-15"></a></div>
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="./assets/img/fb-logo.png" class="h-7"></a></div>
                </div>
                <div class="h-fit w-full">
                    <a href="#" class="w-full"><img src="./assets/img/dathongbaobocongthuong.png"></a>
                </div>
            </div>

        </div>
    </footer>

    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
    <script src="./assets/js/main.js"></script>
    <script src="./assets/js/sign-up.js"></script>
</body>

</html>