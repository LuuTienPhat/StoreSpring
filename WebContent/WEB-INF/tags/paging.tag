<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag import="org.springframework.util.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="pagedListHolder" required="true"
	type="org.springframework.beans.support.PagedListHolder"%>
<%@ attribute name="pagedLink" required="true" type="java.lang.String"%>
<c:if test="${pagedListHolder.pageCount > 1}">
	<nav aria-label="Page navigation">
		<ul class="inline-flex">
			<c:if test="${pagedListHolder.page > 0}">
				<li><a
					href="<%=StringUtils.replace(pagedLink, "~", String.valueOf(pagedListHolder.getPage() - 1))%>"
					class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 rounded-l-lg focus:shadow-outline hover:bg-pink-100">Prev</a></li>
			</c:if>
			<c:if test="${pagedListHolder.firstLinkedPage > 0}">
				<li><a href="<%=StringUtils.replace(pagedLink, "~", "0")%>"
					class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline hover:bg-pink-100">1</a></li>

			</c:if>
			<c:if test="${pagedListHolder.firstLinkedPage > 1}">
				<li><span
					class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline">...</span></li>
			</c:if>
			<c:forEach begin="${pagedListHolder.firstLinkedPage}"
				end="${pagedListHolder.lastLinkedPage}" var="i">
				<c:choose>
					<c:when test="${pagedListHolder.page == i}">
						<li class="page-item active"><span
							class="h-10 px-5 text-white transition-colors duration-150 bg-pink-300 border border-pink-300 focus:shadow-outline"
							>${i+1}</span></li>
					</c:when>
					<c:otherwise>
						<li><a
							class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline hover:bg-pink-100"
							href="<%=StringUtils.replace(pagedLink, "~", String.valueOf(jspContext.getAttribute("i")))%>">${i+1}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if
				test="${pagedListHolder.lastLinkedPage < (pagedListHolder.pageCount - 2)}">
				<li class="page-item"><span class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline hover:bg-pink-100">...</span></li>
			</c:if>
			<c:if
				test="${pagedListHolder.lastLinkedPage < (pagedListHolder.pageCount - 1)}">
				<li class="page-item"><a
					class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline hover:bg-pink-100"
					href="<%=StringUtils.replace(pagedLink, "~", String.valueOf(pagedListHolder.getPageCount() - 1))%>">${pagedListHolder.pageCount}</a></li>
			</c:if>
			<c:if test="${!pagedListHolder.lastPage}">
				<li class="page-item"><a
					class="h-10 px-5 text-pink-300 transition-colors duration-150 bg-white border border-pink-300 focus:shadow-outline hover:bg-pink-100 rounded-r-lg"
					href="<%=StringUtils.replace(pagedLink, "~", String.valueOf(pagedListHolder.getPage() + 1))%>">Next</a></li>
			</c:if>
		</ul>
	</nav>
</c:if>
