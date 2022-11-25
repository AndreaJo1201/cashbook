<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int beginRow = 0;
	int rowPerPage = 0;
	
	//Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // -> lastPage 계산용
	
	
	
	
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
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		</ul>
		
		<div>
			<!-- memberList contents... -->
			<h1>멤버 목록</h1>
			<table>
				<tr>
					<th>회원 번호</th>
					<th>회원 ID</th>
					<th>회원 레벨</th>
					<th>회원 이름</th>
					<th>최신 수정일</th>
					<th>가입일자</th>
					<th>레벨 수정</th>
					<th>탈퇴</th>
				</tr>
				<%
					for(Member m : memberList) {
						
					}
				%>
			</table>
		</div>
	</body>
</html>