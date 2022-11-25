<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
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
			<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지사항 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(회원 목록 보기, level 수정, 강제회원탈퇴)</a></li>
		</ul>
		
		<div>
			<!-- adminMain contents... -->
			<!-- 최근 공지 5,ㅡ 최근 가입 멤버 5 -->
			<table>
				<tr>
					<th>최신 공지사항</th>
				</tr>
				<tr>
					<%
						//for() {
					%>
								<td></td>
							</tr><tr>
					<%
						//}
					%>
				</tr>
			</table>
			
			<table>
				<tr>
					<th>최근 가입회원</th>
				</tr>
				<tr>
					<%
						//for() {
					%>
								<td></td>
							</tr><tr>
					<%
						//}
					%>
				</tr>
			</table>
		</div>
	</body>
</html>