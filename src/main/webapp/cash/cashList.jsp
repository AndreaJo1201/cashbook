<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>

<%
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member) objLoginMember;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>CASH_LIST</title>
	</head>

	<body>
		<div>
			<!-- 로그인 정보(세션 -> loginMember 변수) 출력 -->
			<span><%=request.getParameter("msg") %></span>
			<span>ID : <%=loginMember.getMemberId() %> / Name : <%=loginMember.getMemberName() %>님 반갑습니다.</span>
		</div>
	</body>
</html>