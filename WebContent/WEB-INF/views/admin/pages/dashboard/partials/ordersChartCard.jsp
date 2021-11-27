<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<div class="card border-0 shadow">
	<div
		class="card-header d-flex flex-row align-items-center flex-0 border-bottom">
		<div class="d-block">
			<div class="h6 fw-bold text-gray mb-2">Tổng đơn hàng</div>
			<h2 class="h3 fw-extrabold">${orders.size() }</h2>
			<div class="small mt-2">
				<span class="fas fa-angle-up text-success"></span> <span
					class="text-success fw-bold">18.2%</span>
			</div>
		</div>
		<!-- <div class="d-block ms-auto">
			<div class="d-flex align-items-center text-end mb-2">
				<span class="dot rounded-circle bg-gray-800 me-2"></span> <span
					class="fw-normal small">July</span>
			</div>
			<div class="d-flex align-items-center text-end">
				<span class="dot rounded-circle bg-secondary me-2"></span> <span
					class="fw-normal small">August</span>
			</div>
		</div> -->
	</div>
	<div class="card-body p-2">
		<div id="orders-chart"></div>
		<!--  <div class="ct-chart-ranking ct-golden-section ct-series-a"></div> -->
	</div>
</div>

<script type="text/javascript">
	let optionsOrdersChart = {
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
			type : 'line',
			width : "100%",
			height : 360
		},
		dataLabels : {
			enabled : false
		},
		xaxis : {
			type : 'datetime',
			labels : {
				hideOverlappingLabels: true,
		        showDuplicates: false,
		        formatter: function(value, timestamp, opts) {
		            return new Date(value).toLocaleDateString("vi-VN", {
	        		    month: "short",
	        		});
		          }
			}
		},
		series: [],
		title : {
			text : 'Đơn hàng',
		},
		noData : {
			text : 'Đang tải...'
		},
		theme : {
			monochrome : {
				enabled : true,
				color : '#31316A',
			}
		},
		tooltip : {
			fillSeriesColor : false,
			onDatasetHover : {
				highlightDataSeries : false,
			},
			x: {
	          
	          format: 'MMM',
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

	var ordersChartEl = document.getElementById('orders-chart');
	if (ordersChartEl) {
		var ordersChart = new ApexCharts(ordersChartEl, optionsOrdersChart);
		ordersChart.render();
	
		let url = "chart";
		
		axios({
			method : 'GET',
			url : url,
		}).then(function(response) {
			let data = response.data;
			let modifiedData = [];
			for(let d of data) {
				modifiedData.push({x: d.date, y: d.number});
			};
			
			ordersChart.updateSeries([ {
				name : 'Số lượng đơn hàng',
				data : modifiedData,

			} ])
		})
	}
	
	/* var optionsLineChart = {
	 series : [ {
		name : 'Clients',
		data : [ 120, 160, 200, 470, 420, 150, 470, 750, 650, 190, 140 ]
	} ],
	labels : [ '01 Feb', '02 Feb', '03 Feb', '04 Feb', '05 Feb', '06 Feb',
			'07 Feb', '08 Feb', '09 Feb', '10 Feb', '11 Feb' ],
	chart : {
		type : 'area',
		width : "100%",
		height : 360
	},
	theme : {
		monochrome : {
			enabled : true,
			color : '#31316A',
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
}; */
</script>
