<!-- ========== Tag Lib ========= -->
<%@include file="/WEB-INF/views/admin/includes/header/taglib.jsp"%>

<c:if test="${message != null}">
    <script type="text/javascript">
        <c:if test="${messageType.equals('success')}">
        const notyf = new Notyf({
        	position : {
        		x : 'right',
        		y : 'top',
        	},
        	types : [ {
        		type : 'info',
        		background : '#0ea271',
        		icon : {
        			className : 'bi bi-check2-circle',
        			tagName : 'span',
        			color : '#fff'
        		},
        		dismissible : true,
        		duration : 1000 * 10
        	} ],
        });
        notyf.open({
        	type : 'info',
        	message : '${message}'
        });

        		</c:if>

        		<c:if test="${messageType.equals('error')}">
        		const notyf = new Notyf({
                       position: {
                           x: 'right',
                           y: 'top',
                       },
                       types: [
                           {
                               type: 'error',
                               background: '#FA5252',
                               icon: {
                                   className: 'bi bi-x-circle',
                                   tagName: 'span',
                                   color: '#fff'
                               },
                               dismissible: true,
                               duration : 1000 * 10
                           }
                       ]
                   });
                   notyf.open({
                       type: 'error',
                       message: '${message}'
                   });
        		</c:if>

        		<c:if test="${messageType.equals('warning')}">
        		const notyf = new Notyf({
                       position: {
                           x: 'right',
                           y: 'top',
                       },
                       types: [
                           {
                               type: 'warning',
                               background: '#F5B759',
                               icon: {
                                   className: 'bi bi-exclamation-circle',
                                   tagName: 'span',
                                   color: '#fff'
                               },
                               dismissible: true,
                               duration : 1000 * 10
                           }
                       ]
                   });

                   notyf.open({
                       type: 'warning',
                       message: '${message}'
                   });
        		</c:if>
    </script>
</c:if>
