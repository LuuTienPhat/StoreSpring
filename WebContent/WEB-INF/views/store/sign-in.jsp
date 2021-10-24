<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đăng nhập</title>
    <%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
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
                <button class="w-full px-4 py-2 font-bold bg-pink-700 hover:bg-pink-500 transition-colors text-white rounded-md mb-3"><i class="fab fa-facebook-f mr-1"></i>Đăng nhập bằng Facebook</button>
                <button class="w-full px-4 py-2 font-bold bg-red-700 hover:bg-red-500 transition-colors text-white rounded-md"><i class="fab fa-google mr-1"></i>Đăng nhập bằng Google</button>
            </form>
        </div>

    </main>
    <%@include file="/WEB-INF/views/store/include/store-footer.jsp"%>

    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
    <!-- <script src="./assets/js/main.js"></script> -->
    <script src="<c:url value='/resources/store/assets/js/main.js'/>"></script>
    <!-- <script src="./assets/js/sign-up.js"></script> -->
     <script src="<c:url value='/resources/store/assets/js/sign-up.js'/>"></script>
</body>

</html>