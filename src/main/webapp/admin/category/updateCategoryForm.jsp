<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

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
	
	if(request.getParameter("categoryNo") == null) {
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao categoryDao = new CategoryDao();
	Category categoryOne = categoryDao.selectCategoryOne(categoryNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<div>
			<form action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post">
				<table border="1">
					<tr>
						<th>카테고리번호</th>
						<th>카테고리종류</th>
						<th>카테고리이름</th>

					</tr>
					<tr>
						<td><%=categoryOne.getCategoryNo() %></td>
						<td><%=categoryOne.getCategoryKind() %></td>
						<td><input type="text" name ="categoryName" value="<%=categoryOne.getCategoryName() %>"></td>
					</tr>
				</table>
				<input type="hidden" name="categoryNo" value="<%=categoryOne.getCategoryNo() %>">
				<button type="submit">수정</button>
			</form>
		</div>
	</body>
</html>