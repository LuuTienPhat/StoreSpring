<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
	<div
		class="card-header d-flex flex-row align-items-center flex-0 border-bottom">
		<div class="d-block">
			<div class="h6 fw-bold text-gray mb-2">Sản phẩm mỗi danh mục</div>
			<div class="fw-normal text-gray mb-2">
				<small class="text-gray-400">Loại sản phẩm:</small>
			 	<span class="h4 fw-extrabold">${products.size() }</span>
			 </div>
			<div class="small d-flex mt-1">                               
                    <div>So với tháng trước
                    		<c:choose>
                    		<c:when test="${growthRateOfProducts > 0}">
                    			<svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                    			<span class="text-success fw-bolder">
		                    		<fmt:formatNumber value="${growthRateOfProducts}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:when test="${growthRateOfProducts < 0}">
                    			<svg class="icon icon-xs text-danger" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                    			<span class="text-danger fw-bolder">
		                    		<fmt:formatNumber value="${-growthRateOfProducts}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:when>
                    		<c:otherwise>
                    			<svg class="icon icon-xs text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    			<span class="text-gray-600 fw-bolder">
                    				<fmt:formatNumber value="${growthRateOfProducts}" type="number" maxFractionDigits="0"/>%
		                    	</span>
                    		</c:otherwise>
                    	</c:choose>
                	</div>
                </div>
		</div>
	</div>
	<div class="card-body p-2">
		<div id="products-of-category-chart"></div>
		<!--  <div class="ct-chart-ranking ct-golden-section ct-series-a"></div> -->
	</div>
</div>

<script type="text/javascript">

	var optionsProductsOfCategoryChart = {
		chart : {
			fontFamily: 'Inter, sans-serif',
			locales : [ {
				"name" : "vn",
				"options" : {
					"months" : [ "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4",
							"Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8",
							"Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12" ],
					"shortMonths" : [ "Th1", "Th2", "Th3", "Th4", "Th5", "Th6",
							"Th7", "Th8", "Th9", "Th10", "Th11", "Th12" ],
					"days" : [ "Chủ nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5",
							"Thứ 6", "Thứ 7" ],
					"shortDays" : [ "CN", "T2", "T3", "T4", "T5", "T6", "T7" ],
					"toolbar" : {
						"exportToSVG" : "Tải SVG",
						"exportToPNG" : "Tải PNG",
						"exportToCSV" : "Tải CSV",
						"menu" : "Menu",
						"selection" : "Lựa chọn",
						"selectionZoom" : "Tự chọn khoảng thu phóng",
						"zoomIn" : "Phóng to",
						"zoomOut" : "Thu nhỏ",
						"pan" : "Kéo",
						"reset" : "Khôi phục thu phóng"
					}
				}
			} ],
			defaultLocale : "vn",
			type : 'bar',
			width : "100%",
			height : 500
		},
		dataLabels : {
			enabled : false
		},
		xaxis : {
			labels : {
				hideOverlappingLabels: true,
		        showDuplicates: false
			}
		},
		series: [],
		title : {
			text : 'Sản phẩm',
		},
		noData : {
			text : 'Đang tải...'
		},
		theme : {
			monochrome : {
				enabled : true,
				color : '#f0b874',
			}
		},
		tooltip : {
			fillSeriesColor : false,
			onDatasetHover : {
				highlightDataSeries : false,
			},
			theme : 'light',
			style : {
				fontSize : '12px',
				fontFamily : 'Inter',
			},
		},
	}

	var productsOfCategoryChartEl = document.getElementById('products-of-category-chart');
	if (productsOfCategoryChartEl) {
		var productsOfCategoryChart = new ApexCharts(productsOfCategoryChartEl, optionsProductsOfCategoryChart);
		productsOfCategoryChart.render();
	
		let url = "chart/products-of-category-chart";
		
		axios({
			method : 'GET',
			url : url,
		}).then(function(response) {
			let data = response.data;
			let modifiedData = [];
			for(let d of data) {
				modifiedData.push({x: d.name, y: Object.keys(d.products).length});
			};
			
			productsOfCategoryChart.updateSeries([ {
				name : 'Số lượng sản phẩm',
				data : modifiedData,

			} ])
		})
	}
</script>
