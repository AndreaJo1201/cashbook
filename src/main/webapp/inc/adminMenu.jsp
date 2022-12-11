<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%

%>

<nav class="navbar navbar-expand bg-dark navbar-dark">
	<div class="container d-flex justify-content-around">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href ="<%=request.getContextPath()%>/admin/adminMain.jsp">[메인 페이지]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href ="<%=request.getContextPath()%>/admin/noticeList.jsp">[공지사항 관리]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href ="<%=request.getContextPath()%>/admin/categoryList.jsp">[카테고리 관리]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href ="<%=request.getContextPath()%>/admin/memberList.jsp">[회원 관리]</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href ="<%=request.getContextPath()%>/admin/helpListAll.jsp">[문의내역 관리]</a>
			</li>
		</ul>
	</div>
</nav>