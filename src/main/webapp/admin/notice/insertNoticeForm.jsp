<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h1>공지사항 입력</h1>
		
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp">
			<table border="1">
				<tr>
					<th colspan="2">공지사항 내용</th>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="20" cols="50" name="noticeMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">입력</button>
		</form>
		
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">뒤로가기</a>
		</div>
	</body>
</html>