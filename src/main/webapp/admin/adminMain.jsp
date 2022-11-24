<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}
	
	
	//Model 호출
	
	//최근 공지사항 5개, 최근 가입한 멤버 5명
	
	
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
			<li><a href="">공지사항 관리</a></li>
			<li><a href="">카테고리 관리</a></li>
			<li><a href="">회원 관리(회원 목록 보기, level 수정, 강제회원탈퇴)</a></li>
		</ul>
	</body>
</html>