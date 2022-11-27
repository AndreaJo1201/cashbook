<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	String updateMemberId = request.getParameter("memberId");

	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(updateMemberId);
	
%>

<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<div>
			<h1>회원 레벨 수정</h1>
		</div>
		<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post">
			<table border="1">
				<tr>
					<th><span>회원ID</span></th>
					<td><input type="text" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span>회원닉네임</span></th>
					<td><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>회원 레벨</th>
					<td>
						<%
							if(member.getMemberLevel() == 1) {
						%>
								<input type="radio" name ="memberLevel" value="0">일반회원
								<input type="radio" name ="memberLevel" value="1" checked="checked">관리자
						<%
							} else {
						%>
								<input type="radio" name ="memberLevel" value="0" checked="checked">일반회원
								<input type="radio" name ="memberLevel" value="1">관리자
						<%
							}
						%>
						
					</td>
				</tr>		
			</table>
			<input type="hidden" name="memberNo" value="<%=member.getMemberNo()%>">
			<button type="submit">전송</button>
		</form>
	</body>
	
</html>