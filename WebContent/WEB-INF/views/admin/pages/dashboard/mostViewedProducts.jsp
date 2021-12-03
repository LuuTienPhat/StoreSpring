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

        <jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder" />
        <c:url value="${pagedLink }" var="pagedLink">
            <c:param name="p" value="~" />
        </c:url>
        
        <main class="content">
            <%@include file="/WEB-INF/views/admin/includes/nav/navbar.jsp"%>
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center py-4">
                <div class="d-block mb-4 mb-md-0">
                    <a href="${applicationScope.dashboardPage }" class="btn btn-gray-200">
	                    <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
	                    Quay lại
                    </a>
                </div>
            </div>

            
            <!-- <div class="card card-body border-0 shadow table-wrapper table-responsive overflow-hidden"> -->
                <div class="card border-0 shadow">
    <div class="card-header border-bottom d-flex align-items-center justify-content-between">
        <div class=" h2 fs-5 fw-bold mb-0 text-info d-flex align-items-center">
        <svg class="icon me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
        	<span>${title }</span>
        </div>
    </div>
    <div class="card-body">
        <div class="list-group list-group-flush list my--3">
            <c:forEach items="${pagedListHolder.pageList}" var="product" varStatus="i">
                <a class="list-group-item list-group-item-action px-2 ${i.index != pagedListHolder.getPageSize() ? 'border-bottom' : '' }" aria-current="true" href="${applicationScope.productPage }/${product.id}">
                    <div class="row align-items-center justify-content-between">
                        <div class="col-auto">
                        	<c:set var="index" value="${(pagedListHolder.page) * pagedListHolder.pageSize + i.count}"></c:set>
                            <h3 class="my-0 ${index == 1 ? 'text-danger' : index == 2 ? 'text-secondary' : index == 3 ? 'text-tertiary' : 'text-gray-400' }">
                            	${index}
                            </h3>
                        </div>
                        <div class="col-auto">
                            <img class="rounded" width="100" height="100" alt="Image placeholder" src="${product.images.get(0).image}" />
                        </div>
                        <div class="col-5 text-truncate">
                            <h4 class="h6 mb-0 text-truncate">
                                ${product.name }
                            </h4>
                        </div>
                        <div class="col-auto">
                            <div class="d-flex align-items-center">
                                <!-- <div class="bg-success dot rounded-circle me-1"></div> -->
                                <svg class="icon icon-xxs me-2 text-info" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                                <small>${product.views }</small>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
    <div>
      <tg:adminPaging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
  </div>
</div>

                
            <!-- </div> -->

            <%@include file="/WEB-INF/views/admin/includes/footer/footer.jsp"%>
        </main>

        <!-- ========== All JS files linkup ========= -->
        <%@include file="/WEB-INF/views/admin/includes/footer/script.jsp"%>
    </body>
</html>
