<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
    
<!-- NOTICE: You can use the _analytics.html partial to include production code specific code & trackers -->
<nav class="navbar navbar-dark navbar-theme-primary px-4 col-12 d-lg-none">
    <a class="navbar-brand me-lg-5" href="${applicationScope.dashboardPage }">
        <img class="navbar-brand-dark" src="<c:url value='/resources/admin/assets/img/brand/light.svg' />" alt="Volt logo" /> 
        <img class="navbar-brand-light" src="<c:url value='/resources/admin/assets/img/brand/dark.svg' />" alt="Volt logo" />
    </a>
    <div class="d-flex align-items-center">
        <button class="navbar-toggler d-lg-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>