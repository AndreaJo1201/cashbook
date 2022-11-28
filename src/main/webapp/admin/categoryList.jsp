<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	//Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	int categoryCount = categoryDao.selectCoategoryCount();
	int lastPage = (int)Math.ceil(((double)(categoryCount)/rowPerPage));
	
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 메인</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지사항 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(회원 목록 보기, level 수정, 강제회원탈퇴)</a></li>
		</ul>
		
		<div>
			<!-- category contents... -->
			<h1>카테고리 목록</h1>
			<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
			<table border="1">
				<!-- 모델 데이터 카테고리 리스트 출력 -->
				<tr>
					<th>번호</th>
					<th>종류</th>
					<th>이름</th>
					<th>갱신일</th>
					<th>추가일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				
				<tr>
					<%
						for(Category c : categoryList) {
					%>
							<td><%=c.getCategoryNo() %></td>
							<td><%=c.getCategoryKind() %></td>
							<td><%=c.getCategoryName() %></td>
							<td><%=c.getUpdatedate() %></td>
							<td><%=c.getCreatedate() %></td>
							<td><a href="<%=request.getContextPath()%>/admin/category">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/category">삭제</a></td>
							</tr><tr>
					<%
						}
					%>
				</tr>
				
			</table>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%		
				}
			%>
			<span><%=currentPage %> / <%=lastPage %></span>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>