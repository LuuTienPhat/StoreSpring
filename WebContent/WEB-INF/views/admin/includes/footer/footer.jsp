<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<footer class="bg-white rounded shadow py-3 px-4 mb-4 mt-4">
    <div class="row">
        <div class="col-12 col-md-4 col-xl-6 mb-4 mb-md-0 d-flex align-items-center">
            <p class="mb-0 text-center text-lg-start">
	            ©<span class="current-year me-2"></span>
	            <a class="text-primary fw-normal fst-italic text-uppercase fw-bold" href="#" target="_blank">store spring 21</a>
            </p>
        </div>
        <div class="col-12 col-md-8 col-xl-6 text-center text-lg-start">
            <!-- List -->
            <ul class="list-inline list-group-flush list-group-borderless text-md-end mb-0">
                <li class="list-inline-item px-0 px-sm-2" id = "back-to-top">
                    <i class="bi bi-arrow-up-circle-fill fs-1"></i>
                </li>
                <!-- <li class="list-inline-item px-0 px-sm-2">
                    <a href="https://themesberg.com/themes">Themes</a>
                </li>
                <li class="list-inline-item px-0 px-sm-2">
                    <a href="https://themesberg.com/blog">Blog</a>
                </li>
                <li class="list-inline-item px-0 px-sm-2">
                    <a href="https://themesberg.com/contact">Contact</a>
                </li> -->
            </ul>
        </div>
    </div>
</footer>

<script>
	const btnBackToTop = document.getElementById("back-to-top");
	btnBackToTop.addEventListener("click", () => {
		document.body.scrollTop = 0;
		document.documentElement.scrollTop = 0;
	})
</script>