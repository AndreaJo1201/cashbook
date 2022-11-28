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
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
			<table>
				<tr>
					<th>카테고리종류</th>
					<td>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출">지출
					</td>
				</tr>
				<tr>
					<th>카테고리이름</th>
					<td><input type="text" name="categoryName"></td>
				</tr>
			</table>
			<button type="submit">추가</button>
		</form>
	</body>
</html>