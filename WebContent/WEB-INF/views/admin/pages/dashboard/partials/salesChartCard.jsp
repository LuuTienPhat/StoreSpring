<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card bg-yellow-100 border-0 shadow">
	<div class="card-header d-sm-flex flex-row align-items-center flex-0">
		<div class="d-block mb-3 mb-sm-0">
			<div class="fs-5 fw-normal mb-2">Doanh thu trong ngày</div>
			<h2 class="fs-3 fw-extrabold">
				<fmt:setLocale value="vi_VN" scope="session" />
            	<fmt:formatNumber value="${todayTotalRevenue}" type="currency" />
			</h2>
			<div class="small mt-2">
				<span class="fw-normal me-2">So với hôm qua</span> <span
					class="fas fa-angle-up text-success"></span> <span
					class="text-primary fw-bold">
						<c:set var="percentageGrowth" value="${growthRateOfOrdersComparedToYesterday}"></c:set>
						<c:if test="${percentageGrowth > 0}">
                    		<svg class="icon icon-xs text-success me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7l4-4m0 0l4 4m-4-4v18"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${percentageGrowth}" type="number" />%
                    	</c:if>
                    	
                    	<c:if test="${percentageGrowth < 0}">
                    		<svg class="icon icon-xs text-danger me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 17l-4 4m0 0l-4-4m4 4V3"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${-percentageGrowth}" type="number" />%
                    	</c:if>
                    	
                    	<c:if test="${percentageGrowth== 0}">
                    		<svg class="icon icon-xs text-gray-400 me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                    		<fmt:setLocale value="vi_VN" scope="session" />
                        	<fmt:formatNumber value="${percentageGrowth}" type="number" />%
                    		
                    	</c:if>
					</span>
			</div>
		</div>
		<div class="d-flex ms-auto">
			<!-- <a href="#" class="btn btn-secondary text-dark btn-sm me-2">Ngày</a> -->
			<!-- <span class="btn btn-dark btn-sm me-3" id="btn-revenue-by-day">Ngày</span> -->
			<span class="btn btn-secondary text-dark btn-sm me-2" id="btn-revenue-by-month">Tháng</span>
		</div>
	</div>
	<div class="card-body p-2">
		<div id="sales-chart"></div>
		<!-- <div class="ct-chart-sales-value ct-double-octave ct-series-g"></div> -->
	</div>
</div>

<script type="text/javascript">
var optionsSalesChart = {
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
			type : 'area',
			width : "100%",
			height : 360,
			toolbar: {
		        tools: {
		        	download:false,
		        	reset:false,
		          selection: false,
		          zoom: false,
		          pan: false,
		        },
			}
		},
		dataLabels : {
			enabled : false,
		},
		xaxis : {
			type : 'category',
			labels : {
				hideOverlappingLabels: true,
		        showDuplicates: false,
		        formatter: function(value, timestamp, opts) {
		            return new Date(value).toLocaleDateString("vi-VN", {
	        		    month: "long",
	        		});
		          }
			}
		},
		yaxis: {
		    labels: {
		      formatter: function(val, index) {
		        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val)
		      }
		    }
		  },
		series: [],
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
			x: {
	          format: 'MMMM',
		      },
		      y: {
		          title: {
		              formatter: (seriesName) => seriesName,
		          },
		      },
			theme : 'light',
			style : {
				fontSize : '12px',
				fontFamily : 'Inter',
			},
		},
	}

	var salesChartEl = document.getElementById('sales-chart');
	if (salesChartEl) {
		var salesChart = new ApexCharts(salesChartEl, optionsSalesChart);
		salesChart.render();
	
		let url = "chart/sales-chart";
		
		axios({
			method : 'GET',
			url : url,
		}).then(function(response) {
			let data = response.data;
			let modifiedData = [];
			for(let d of data) {
				modifiedData.push({x: d.date, y: d.money});
			};
			
			salesChart.updateSeries([ {
				name : 'Doanh thu',
				data : modifiedData,

			} ])
		})
	}
</script>
