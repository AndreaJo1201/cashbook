<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
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
	
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
	
	String deleteMemberId = request.getParameter("memberId");

	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(deleteMemberId);
%>

<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<div>
			<h2>회원 강제 탈퇴 페이지</h2>
		</div>
		
		<form action="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminAction.jsp" method="post">
			<table border="1">
				<tr>
					<th><span>회원번호</span></th>
					<td><input type="text" name="memberNo" value="<%=member.getMemberNo() %>" readonly="readonly"></td>
				</tr>
			
				<tr>
					<th><span>회원ID</span></th>
					<td><input type="text" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span>회원닉네임</span></th>
					<td><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span>회원 레벨</span></th>
					<td>
						<input type="text" name="memberLevel" value="<%=member.getMemberLevel() %>" readonly="readonly">
					</td>
				</tr>
				
			</table>
			<button type="submit">전송</button>
		</form>
	</body>
	
</html>