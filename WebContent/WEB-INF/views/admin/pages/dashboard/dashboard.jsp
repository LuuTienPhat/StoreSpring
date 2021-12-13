<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- ========== Meta Tags ========= -->
    <%@include file="/WEB-INF/views/admin/includes/header/head.jsp"%>

    <!-- ========== Favicon linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/header/favicon.jsp"%>

    <!-- ========== All CSS files linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/header/styles.jsp"%>
  </head>

  <body>
    <%@include file="/WEB-INF/views/admin/includes/nav/sidebar.jsp"%>

    <main class="content">
      <%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>

      <div class="py-4 d-flex">
        <%@include file="/WEB-INF/views/admin/pages/dashboard/partials/shortcuts.jsp"%>
      </div>
      <div class="row">
        <div class="col-12 mb-4">
        	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/salesChartCard.jsp"%>
        </div>
        <div class="col-12 col-sm-6 col-xl-4 mb-4">
        	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/totalCustomerCard.jsp"%>
        </div>
        <div class="col-12 col-sm-6 col-xl-4 mb-4">
        	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/totalRevenueCard.jsp"%>
        </div>
        <div class="col-12 col-sm-6 col-xl-4 mb-4">
          <%@include file="/WEB-INF/views/admin/pages/dashboard/partials/invoiceCard.jsp"%>
        </div>
      </div>
      <div class="row">
        <div class="col-12 col-xl-8">
          <div class="row">
            <div class="col-12 mb-4">
            	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/topRevenueProductsCard.jsp"%>
            </div>
            <div class="col-12 col-xxl-6 mb-4">
            	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/mostViewedProductsCard.jsp"%>
            </div>
            <div class="col-12 col-xxl-6 mb-4">
            	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/topFavortiteProductsCard.jsp"%>
            </div>
            <div class="col-12">
            	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/lastestOrdersCard.jsp"%>
            </div>
          </div>
        </div>
        <div class="col-12 col-xl-4">
          <div class="col-12 px-0 mb-4">
          	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/ordersChartCard.jsp"%>
          </div>
          <div class="col-12 px-0 mb-4">
          	<%@include file="/WEB-INF/views/admin/pages/dashboard/partials/totalCategoryCard.jsp"%>
          </div>
          <div class="col-12 px-0 mb-4">
            <%@include file="/WEB-INF/views/admin/pages/dashboard/partials/productsOfEachCategoryCard.jsp"%>
            <!-- <div class="card border-0 shadow">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between border-bottom pb-3">
                                    <div>
                                        <div class="h6 mb-0 d-flex align-items-center">
                                            <svg class="icon icon-xs text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM4.332 8.027a6.012 6.012 0 011.912-2.706C6.512 5.73 6.974 6 7.5 6A1.5 1.5 0 019 7.5V8a2 2 0 004 0 2 2 0 011.523-1.943A5.977 5.977 0 0116 10c0 .34-.028.675-.083 1H15a2 2 0 00-2 2v2.197A5.973 5.973 0 0110 16v-2a2 2 0 00-2-2 2 2 0 01-2-2 2 2 0 00-1.668-1.973z"
                                                    clip-rule="evenodd"
                                                ></path>
                                            </svg>
                                            Global Rank
                                        </div>
                                    </div>
                                    <div>
                                        <a href="#" class="d-flex align-items-center fw-bold">
                                            #755
                                            <svg class="icon icon-xs text-gray-500 ms-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z"
                                                    clip-rule="evenodd"
                                                ></path>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-between border-bottom py-3">
                                    <div>
                                        <div class="h6 mb-0 d-flex align-items-center">
                                            <svg class="icon icon-xs text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M3 6a3 3 0 013-3h10a1 1 0 01.8 1.6L14.25 8l2.55 3.4A1 1 0 0116 13H6a1 1 0 00-1 1v3a1 1 0 11-2 0V6z" clip-rule="evenodd"></path>
                                            </svg>
                                            Country Rank
                                        </div>
                                        <div class="small card-stats">
                                            United States
                                            <svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path>
                                            </svg>
                                        </div>
                                    </div>
                                    <div>
                                        <a href="#" class="d-flex align-items-center fw-bold">
                                            #32
                                            <svg class="icon icon-xs text-gray-500 ms-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z"
                                                    clip-rule="evenodd"
                                                ></path>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center justify-content-between pt-3">
                                    <div>
                                        <div class="h6 mb-0 d-flex align-items-center">
                                            <svg class="icon icon-xs text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4l2 2h4a2 2 0 012 2v1H8a3 3 0 00-3 3v1.5a1.5 1.5 0 01-3 0V6z" clip-rule="evenodd"></path>
                                                <path d="M6 12a2 2 0 012-2h8a2 2 0 012 2v2a2 2 0 01-2 2H2h2a2 2 0 002-2v-2z"></path>
                                            </svg>
                                            Category Rank
                                        </div>
                                        <div class="small card-stats">
                                            Computers Electronics > Technology
                                            <svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path>
                                            </svg>
                                        </div>
                                    </div>
                                    <div>
                                        <a href="#" class="d-flex align-items-center fw-bold">
                                            #11
                                            <svg class="icon icon-xs text-gray-500 ms-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11.707 4.707a1 1 0 00-1.414-1.414L10 9.586 8.707 8.293a1 1 0 00-1.414 0l-2 2a1 1 0 101.414 1.414L8 10.414l1.293 1.293a1 1 0 001.414 0l4-4z"
                                                    clip-rule="evenodd"
                                                ></path>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div> -->
          </div>
          <div class="col-12 px-0">
            <!-- <div class="card border-0 shadow">
                            <div class="card-body">
                                <h2 class="fs-5 fw-bold mb-1">Acquisition</h2>
                                <p>Tells you where your visitors originated from, such as search engines, social networks or website referrals.</p>
                                <div class="d-block">
                                    <div class="d-flex align-items-center me-5">
                                        <div class="icon-shape icon-sm icon-shape-danger rounded me-3">
                                            <svg fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    fill-rule="evenodd"
                                                    d="M3 3a1 1 0 000 2v8a2 2 0 002 2h2.586l-1.293 1.293a1 1 0 101.414 1.414L10 15.414l2.293 2.293a1 1 0 001.414-1.414L12.414 15H15a2 2 0 002-2V5a1 1 0 100-2H3zm11 4a1 1 0 10-2 0v4a1 1 0 102 0V7zm-3 1a1 1 0 10-2 0v3a1 1 0 102 0V8zM8 9a1 1 0 00-2 0v2a1 1 0 102 0V9z"
                                                    clip-rule="evenodd"
                                                ></path>
                                            </svg>
                                        </div>
                                        <div class="d-block">
                                            <label class="mb-0">Bounce Rate</label>
                                            <h4 class="mb-0">33.50%</h4>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center pt-3">
                                        <div class="icon-shape icon-sm icon-shape-purple rounded me-3">
                                            <svg fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"
                                                ></path>
                                            </svg>
                                        </div>
                                        <div class="d-block">
                                            <label class="mb-0">Sessions</label>
                                            <h4 class="mb-0">9,567</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> -->
          </div>
        </div>
      </div>
      <!-- <div class="theme-settings card bg-gray-800 pt-2 collapse" id="theme-settings">
                <div class="card-body bg-gray-800 text-white pt-4">
                    <button type="button" class="btn-close theme-settings-close" aria-label="Close" data-bs-toggle="collapse" href="#theme-settings" role="button" aria-expanded="false" aria-controls="theme-settings"></button>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <p class="m-0 mb-1 me-4 fs-7">Open source <span role="img" aria-label="gratitude">ð</span></p>
                        <a
                            class="github-button"
                            href="https://github.com/themesberg/volt-bootstrap-5-dashboard"
                            data-color-scheme="no-preference: dark; light: light; dark: light;"
                            data-icon="octicon-star"
                            data-size="large"
                            data-show-count="true"
                            aria-label="Star themesberg/volt-bootstrap-5-dashboard on GitHub"
                        >
                            Star
                        </a>
                    </div>
                    <a href="https://themesberg.com/product/admin-dashboard/volt-bootstrap-5-dashboard" target="_blank" class="btn btn-secondary d-inline-flex align-items-center justify-content-center mb-3 w-100">
                        Download
                        <svg class="icon icon-xs ms-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path
                                fill-rule="evenodd"
                                d="M2 9.5A3.5 3.5 0 005.5 13H9v2.586l-1.293-1.293a1 1 0 00-1.414 1.414l3 3a1 1 0 001.414 0l3-3a1 1 0 00-1.414-1.414L11 15.586V13h2.5a4.5 4.5 0 10-.616-8.958 4.002 4.002 0 10-7.753 1.977A3.5 3.5 0 002 9.5zm9 3.5H9V8a1 1 0 012 0v5z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                    </a>
                    <p class="fs-7 text-gray-300 text-center">Available in the following technologies:</p>
                    <div class="d-flex justify-content-center">
                        <a class="me-3" href="https://themesberg.com/product/admin-dashboard/volt-bootstrap-5-dashboard" target="_blank">
                            <img src="../../assets/img/technologies/bootstrap-5-logo.svg" class="image image-xs" />
                        </a>
                        <a href="https://demo.themesberg.com/volt-react-dashboard/#/" target="_blank">
                            <img src="../../assets/img/technologies/react-logo.svg" class="image image-xs" />
                        </a>
                    </div>
                </div>
            </div>

            <div class="card theme-settings bg-gray-800 theme-settings-expand" id="theme-settings-expand">
                <div class="card-body bg-gray-800 text-white rounded-top p-3 py-2">
                    <span class="fw-bold d-inline-flex align-items-center h6">
                        <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path
                                fill-rule="evenodd"
                                d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                        Settings
                    </span>
                </div>
            </div> -->

      <!-- ========== All JS files linkup ========= -->
      <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
    </main>

    <!-- ========== All JS files linkup ========= -->
    <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
  </body>
</html>
