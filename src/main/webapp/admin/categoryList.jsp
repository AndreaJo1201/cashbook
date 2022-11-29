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
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>Insert title here</title>
	</head>

	<body>
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
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
							<td><a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo() %>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo() %>">삭제</a></td>
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