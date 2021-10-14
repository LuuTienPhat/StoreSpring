<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đăng ký</title>
    <%@include file="/WEB-INF/views/store/include/store-head.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/store/include/store-header.jsp"%>
    <main class="main">
        <div class="sign-up-form-container mx-auto my-10 border-2 border-gray-100 rounded-md">
            <div class="flex"><a href="${applicationScope.signInPage}"
                    class="switch-to-sign-in w-full py-2 relative text-xl text-pink-300 text-center">ĐĂNG
                    NHẬP</a><a href="#"
                    class="switch-to-sign-up w-full py-2 relative text-xl text-pink-300 text-center active-show-after">ĐĂNG KÝ</a>
            </div>
            <form action="" class="w-full p-4">
                <input type="text" name="username" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Tên đăng nhập (*)">
                <input type="text" name="fullname" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Họ tên (*)">
                <input type="text" name="dateofbirth" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Ngày sinh (*)">
                <input type="text" name="phonenumber" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Điện thoại (*)">
                <input type="text" name="email" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Email (*)">
                <select id="cityId" name="cityId" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3">
                    <option value="">Tỉnh/Thành phố *</option>
                    <option value="254">Hà Nội</option>
                    <option value="255">Hồ Chí Minh</option>
                    <option value="256">An Giang</option>
                    <option value="257">Bà Rịa - Vũng Tàu</option>
                    <option value="258">Bắc Ninh</option>
                    <option value="259">Bắc Giang</option>
                    <option value="260">Bình Dương</option>
                    <option value="261">Bình Định</option>
                    <option value="262">Bình Phước</option>
                    <option value="263">Bình Thuận</option>
                    <option value="264">Bến Tre</option>
                    <option value="265">Bắc Cạn</option>
                    <option value="266">Cần Thơ</option>
                    <option value="267">Khánh Hòa</option>
                    <option value="268">Thừa Thiên Huế</option>
                    <option value="269">Lào Cai</option>
                    <option value="270">Quảng Ninh</option>
                    <option value="271">Đồng Nai</option>
                    <option value="272">Nam Định</option>
                    <option value="273">Cà Mau</option>
                    <option value="274">Cao Bằng</option>
                    <option value="275">Gia Lai</option>
                    <option value="276">Hà Giang</option>
                    <option value="277">Hà Nam</option>
                    <option value="278">Hà Tĩnh</option>
                    <option value="279">Hải Dương</option>
                    <option value="280">Hải Phòng</option>
                    <option value="281">Hòa Bình</option>
                    <option value="282">Hưng Yên</option>
                    <option value="283">Kiên Giang</option>
                    <option value="284">Kon Tum</option>
                    <option value="285">Lai Châu</option>
                    <option value="286">Lâm Đồng</option>
                    <option value="287">Lạng Sơn</option>
                    <option value="288">Long An</option>
                    <option value="289">Nghệ An</option>
                    <option value="290">Ninh Bình</option>
                    <option value="291">Ninh Thuận</option>
                    <option value="292">Phú Thọ</option>
                    <option value="293">Phú Yên</option>
                    <option value="294">Quảng Bình</option>
                    <option value="295">Quảng Nam</option>
                    <option value="296">Quảng Ngãi</option>
                    <option value="297">Quảng Trị</option>
                    <option value="298">Sóc Trăng</option>
                    <option value="299">Sơn La</option>
                    <option value="300">Tây Ninh</option>
                    <option value="301">Thái Bình</option>
                    <option value="302">Thái Nguyên</option>
                    <option value="303">Thanh Hóa</option>
                    <option value="304">Tiền Giang</option>
                    <option value="305">Trà Vinh</option>
                    <option value="306">Tuyên Quang</option>
                    <option value="307">Vĩnh Long</option>
                    <option value="308">Vĩnh Phúc</option>
                    <option value="309">Yên Bái</option>
                    <option value="310">Đắk Lắk</option>
                    <option value="311">Đồng Tháp</option>
                    <option value="312">Đà Nẵng</option>
                    <option value="313">Đắc Nông</option>
                    <option value="314">Hậu Giang</option>
                    <option value="315">Bạc Liêu</option>
                    <option value="316">Điện Biên</option>
                </select>
                <select id="districtId" name="districtId" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3">
                    <option value="">Quận/ Huyện *</option>
                </select>
                <input type="text" name="username" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Địa chỉ chi tiết (*)">
                <input type="text" name="password" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Mật khẩu của bạn (*)">
                <input type="text" name="password" id="" class="w-full p-2 border-2 border-gray-300 rounded-md mb-3" placeholder="Nhập lại mật khẩu (*)">
                <button class="w-full px-4 py-2 font-bold bg-pink-300 hover:bg-pink-400 transition-colors text-white rounded-md">ĐĂNG KÝ</button>
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