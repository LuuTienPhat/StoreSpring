<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
        <div class="section px-32 py-5 bg-indigo-400 flex text-white font-medium font-bold" id="store-address">
            <div class="mr-3 flex flex-col">
                <span class="text-md">Hotline</span>
                <span class="text-xl mb-4">0987654321</span>
                <span class="text-md">Email</span>
                <span class="text-lg mb-4">storespring21@gmail.com</span>
                <a class="text-sm mb-2" href="#">CHÍNH SÁCH BÁN HÀNG</a>
                <a class="text-sm" href="#">HƯỚNG DẪN MUA HÀNG</a>
            </div>
            <div class="mx-3">
                <h3 class="text-md">HÀ NỘI</h3>
                <ul class="list-disc pl-6 text-sm">
                    <li class="">122 Hoàng Quốc Việt, Q.Cầu Giấy, Hà Nội</li>
                    <li class="">Km10, Đường Nguyễn Trãi, Q.Hà Đông, Hà Nội</li>
                </ul>
            </div>
            <div class="mx-3">
                <h3 class="text-md">TP.HỒ CHÍ MINH</h3>
                <ul class="list-disc pl-6 text-sm">
                    <li class="">11 Nguyễn Đình Chiểu, P. Đa Kao, Q.1 TP, Hồ Chí Minh</li>
                    <li class="">97 Man Thiện, P. Hiệp Phú, Q.9, TP Hồ Chí Minh</li>
                </ul>
            </div>

            <div class="flex flex-col w-32 ml-3">
                <div class="">
                    <a href="${applicationScope.storeIndexPage}" class="w-full"><img src="<c:url value='/resources/store/assets/img/logo_200x200 copy2.png'/>"></a>
                </div>
                <span class="mb-1">Hãy kết nối với chúng mình</span>
                <div class="flex justify-between items-center h-fit mb-2 social">
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="<c:url value='/resources/store/assets/img/social-color-insta.png'/>" class="h-15"></a></div>
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="<c:url value='/resources/store/assets/img/social-color-youtube.png'/>" class="h-15"></a></div>
                    <div class="transform hover:scale-110 transition-all w-10 social-icon-container"> <a href="#" class="w-full"><img
                                src="<c:url value='/resources/store/assets/img/fb-logo.png'/>" class="h-7"></a></div>
                </div>
                <div class="h-fit w-full">
                    <a href="#" class="w-full"><img src="<c:url value='/resources/store/assets/img/dathongbaobocongthuong.png'/>"></a>
                </div>
            </div>

        </div>
    </footer>
