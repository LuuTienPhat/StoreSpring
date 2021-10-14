<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Product detail</title>
    <%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
    <main class="main">
        <div class="section px-32 my-5 product__detail">
            <div class="product-navigation font-bold mb-5">Trang chủ > Đồ chơi > <span class="text-pink-300">Đồ
                    chơi</span></div>
            <div class="flex detail__wrapper">
                <a href="#" class="product-detail__img-container"><img src="./assets/img/sp1.jpeg" alt=""></a>
                <div class="ml-5 flex-1 detail__desc">
                    <h3 class="text-3xl font-bold mb-2">Squishy MJ Momo duck nháy mắt 7cm - Vàng</h3>
                    <div class="flex justify-between">
                        <h6 class="mb-2 text-gray-500">Mã sản phẩm: M.D100.NO.21071018-YL</h6>
                        <div class="flex">
                            <i class="fa fa-share-alt text-2xl hover:text-pink-400 text-2xl mr-2 cursor-pointer"></i>
                            <i class="fa fa-heart hover:text-pink-400 text-2xl cursor-pointer"></i>
                        </div>
                    </div>
                    <h2 class="price my-4 text-3xl font-bold">50,000đ</h2>
                    <div class="flex my-4 items-center">
                        <h6 class="color mr-4">Màu sắc</h6>
                        <div
                            class="color-visual border-2 border-blue-400 rounded-full w-9 h-9 bg-yellow-300 cursor-pointer">
                        </div>
                    </div>
                    <div class="flex my-4">
                        <h6 class="mr-4">Số lượng</h6>
                        <div class="input-group flex align-items-center">
                            <button class="button-minus">-</button>
                            <input type="number" step="1" max="" min="1" value="1" name="quantity"
                                class="quantity-field">

                            <button class="button-plus">+</button>

                        </div>
                    </div>
                    <div class="flex my-4 border-gray-300 border-b-2 pb-5">
                        <button
                            class="w-full text-center py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md mr-4 add-to-cart">THÊM
                            VÀO GIỎ HÀNG</button>
                        <button
                            class="w-full text-center py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md buy-now">MUA
                            NGAY</button>
                    </div>
                    <div class="delivery-policy">
                        <div class="flex my-2">
                            <div class="flex w-100 items-center mr-2">
                                <i class="fas fa-truck mr-2"></i>
                                <span class="font-bold">Giao hàng toàn quốc đơn hàng từ 100k</span>
                            </div>
                            <div class="flex w-1/2 items-center mr-2">
                                <i class="fas fa-coins mr-2"></i>
                                <span class="font-bold">COD nội thành HN, HCM</span>
                            </div>
                            <div class="flex w-1/2 items-center">
                                <i class="fas fa-sync mr-2"></i>
                                <span class="font-bold">Đổi trả trong 24h</span>
                            </div>

                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-gift mr-2"></i>
                            <div class="flex flex-col">
                                <span class="font-bold">Freeship cho đơn hàng từ 200k nội thành HN, HCM</span>
                                <span class="font-bold">Freeship cho đơn hàng từ 300k toàn quốc</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section__heading mb-8  mt-16">
                <h3><a href="#" class="hover:text-pink-300 transition-colors text-3xl font-bold">Các sản phẩm đã xem</a>
                </h3>
            </div>
            <div class="visited-product flex flex-wrap">
                <div class="item w-1/5 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="#" class="block overflow-hidden">
                            <img src="./assets/img/sp1.jpeg" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
                        </div>
                    </div>
                    <a href="#" class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/5 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="#" class="block overflow-hidden">
                            <img src="./assets/img/sp1.jpeg" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
                        </div>
                    </div>
                    <a href="#" class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/5 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="#" class="block overflow-hidden">
                            <img src="./assets/img/sp1.jpeg" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
                        </div>
                    </div>
                    <a href="#" class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/5 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="#" class="block overflow-hidden">
                            <img src="./assets/img/sp1.jpeg" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i class="fa text-2xl fa-heart text-white hover:text-pink-400"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i class="fa text-2xl fa-cart-plus text-white hover:text-pink-400"></i></a>
                        </div>
                    </div>
                    <a href="#" class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
            </div>
        </div>

    </main>
    <%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
    <!-- <script src="./assets/js/main.js"></script> -->
    <script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
    <!-- <script src="./assets/js/product-detail.js"></script> -->
    <script src="<c:url value='/resources/store/assets/js/product-detail.js'/>"></script>
</body>

</html>