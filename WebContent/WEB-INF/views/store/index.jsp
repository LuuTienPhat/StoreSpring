<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Quà tặng và phụ kiện</title>
	<%@include file="/WEB-INF/views/store/include/store-head.jsp"%>

</head>

<body>
    <%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
    <main class="main">
        
        <div class="main__slider flex justify-between">
            <div class="swiper swiper-1">
                <!-- Additional required wrapper -->
                <div class="swiper-wrapper">
                    <!-- Slides -->
                    <div class="swiper-slide"><a href="#" class="w-full"><img src="<c:url value='/resources/store/assets/img/BannerM5.png'/>"
                                alt=""></a></div>
                    <div class="swiper-slide"><a href="#" class="w-full"><img src="<c:url value='/resources/store/assets/img/sb_1612181109_394.png'/>"
                                alt=""></a></div>
                    <div class="swiper-slide"><a href="#" class="w-full"><img src="<c:url value='/resources/store/assets/img/T9_Banner web.png'/>"
                                alt=""></a></div>
                </div>
                <!-- If we need pagination -->
                <div class="swiper-pagination"></div>

                <!-- If we need navigation buttons -->
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>

            </div>
            <div class="slider__right flex flex-col flex-1 ml-2">
                <a href="#" class="w-full mb-2"><img src="<c:url value='/resources/store/assets/img/Youtube - 1_tuan_mua_do_cute.jpg'/>" alt=""></a>
                <a href="#" class="w-full"><img src="<c:url value='/resources/store/assets/img/sb_1622297902_958.jpg'/>" alt=""></a>
            </div>
        </div>
        <div class="main__new-product section px-32 my-16">
            <div class="section__heading mb-8">
                <h3><a href="#" class="hover:text-pink-300 transition-colors text-3xl font-bold">Sản phẩm mới</a>
                </h3>
            </div>
            <div class="new-product__list flex flex-wrap">
                <%-- <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>

                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="item w-1/4 px-3 mb-4">
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                            <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                class="transform hover:scale-110 transition-all "></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="#"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                        Momo duck nháy mắt 7cm</a>
                    <span class="item__price font-bold">50.000đ</span>
                </div>
                <div class="list__see-more w-full text-center mt-1">
                    <button
                        class="px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md">Xem
                        thêm</button>
                </div>--%>
                <c:forEach var="p" items="${list}">
            <div class="item w-1/4 px-3 mb-4 flex flex-col justify-between">
            	<div>
                    <div class="relative item-menu-container overflow-hidden">
                        <a href="${applicationScope.productDetailPage}/${p.id}" class="block overflow-hidden">
                            <%-- <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt="" --%>
                            <img src="data:image/png;base64,${p.images[0].image}" alt="${p.id}"
                                class="transform hover:scale-110 transition-all "/></a>

                        <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                            <a href="#"><i
                                    class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                            <div class="border-l-2 border-white h-7 mx-2"></div>
                            <a href="store/shopping-cart/insert-into-cart/${p.id}"><i
                                    class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                        </div>
                    </div>
                    <a href="${applicationScope.productDetailPage}/${p.id}"
                        class="item__name block hover:text-pink-300 transition-colors font-bold my-2">${p.name}</a>
				</div>
                    <span class="item__price font-bold">${p.price}đ</span>
                </div>
            </c:forEach>
            </div> 
            
            <div class="main__new-topic section mt-16">
                <div class="section__heading mb-8">
                    <h3><a href="#" class="hover:text-pink-300 transition-colors text-3xl font-bold">Chủ đề
                            mới</a>
                    </h3>
                </div>
                <div class="mb-6 flex new-topic__nav">
                    <div class="item w-1/4 px-3 transform hover:scale-110 transition-all"> <a href="#"
                            class="w-1/4"><img src="<c:url value='/resources/store/assets/img/topic1.png'/>" alt="" class="transition-all"></a></div>
                    <div class="item w-1/4 px-3 transform hover:scale-110 transition-all"> <a href="#"
                            class="w-1/4"><img src="<c:url value='/resources/store/assets/img/topic2.png'/>" alt="" class="transition-all"></a></div>
                    <div class="item w-1/4 px-3 transform hover:scale-110 transition-all"> <a href="#"
                            class="w-1/4"><img src="<c:url value='/resources/store/assets/img/topic3.png'/>" alt="" class="transition-all"></a></div>
                    <div class="item w-1/4 px-3 transform hover:scale-110 transition-all"> <a href="#"
                            class="w-1/4"><img src="<c:url value='/resources/store/assets/img/topic4.png'/>" alt="" class="transition-all"></a></div>
                </div>
                <div class="new-product__list flex flex-wrap">
                    <div class="item w-1/4 px-3 mb-4">
                        <div class="relative item-menu-container overflow-hidden">
                            <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                                <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                    class="transform hover:scale-110 transition-all "></a>

                            <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                                <a href="#"><i
                                        class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                                <div class="border-l-2 border-white h-7 mx-2"></div>
                                <a href="#"><i
                                        class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                            </div>
                        </div>
                        <a href="${applicationScope.productDetailPage}"
                            class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                            Momo duck nháy mắt 7cm</a>
                        <span class="item__price font-bold">50.000đ</span>
                    </div>
                    <div class="item w-1/4 px-3 mb-4">
                        <div class="relative item-menu-container overflow-hidden">
                            <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                                <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                    class="transform hover:scale-110 transition-all "></a>

                            <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                                <a href="#"><i
                                        class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                                <div class="border-l-2 border-white h-7 mx-2"></div>
                                <a href="#"><i
                                        class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                            </div>
                        </div>
                        <a href="${applicationScope.productDetailPage}"
                            class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                            Momo duck nháy mắt 7cm</a>
                        <span class="item__price font-bold">50.000đ</span>
                    </div>
                    <div class="item w-1/4 px-3 mb-4">
                        <div class="relative item-menu-container overflow-hidden">
                            <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                                <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                    class="transform hover:scale-110 transition-all "></a>

                            <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                                <a href="#"><i
                                        class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                                <div class="border-l-2 border-white h-7 mx-2"></div>
                                <a href="#"><i
                                        class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                            </div>
                        </div>
                        <a href="${applicationScope.productDetailPage}"
                            class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                            Momo duck nháy mắt 7cm</a>
                        <span class="item__price font-bold">50.000đ</span>
                    </div>
                    <div class="item w-1/4 px-3 mb-4">
                        <div class="relative item-menu-container overflow-hidden">
                            <a href="${applicationScope.productDetailPage}" class="block overflow-hidden">
                                <img src="<c:url value='/resources/store/assets/img/sp1.jpeg'/>" alt=""
                                    class="transform hover:scale-110 transition-all "></a>

                            <div class="flex justify-center bg-pink-300 items-center py-2 absolute item__menu w-full">
                                <a href="#"><i
                                        class="fa text-2xl fa-heart text-white hover:text-pink-400 transition-colors"></i></a>
                                <div class="border-l-2 border-white h-7 mx-2"></div>
                                <a href="#"><i
                                        class="fa text-2xl fa-cart-plus text-white hover:text-pink-400 transition-colors"></i></a>
                            </div>
                        </div>
                        <a href="${applicationScope.productDetailPage}"
                            class="item__name block hover:text-pink-300 transition-colors font-bold my-2">Squishy MJ
                            Momo duck nháy mắt 7cm</a>
                        <span class="item__price font-bold">50.000đ</span>
                    </div>
                </div>
                <div class="list__see-more w-full text-center mt-1">
                    <button
                        class="px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md">Xem
                        thêm</button>
                </div>
            </div>
            <div class="main__new-collection section mt-16">
                <div class="section__heading mb-8">
                    <h3><a href="#" class="hover:text-pink-300 transition-colors text-3xl font-bold">Bộ sưu tập mới</a>
                    </h3>
                </div>
                <div class="swiper swiper-2">
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                        <!-- Slides -->
                        <div class="swiper-slide flex justify-between">
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                        </div>
                        <div class="swiper-slide flex justify-between">
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                            <div class="px-3"><a href="#" class="w-full block"><img src="<c:url value='/resources/store/assets/img/bottomslide18.jpg'/>"
                                        alt=""></a></div>
                        </div>
                    </div>
                    <!-- If we need pagination -->
                    <div class="swiper-pagination"></div>

                    <!-- If we need navigation buttons -->
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>

                </div>
            </div>
        </div>
    </main>
    <%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
    <!-- <script src="./assets/js/main.js"></script> -->
	<script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
</body>

</html>