<%@page import="dao.MemberDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.NoticeDao"%>
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

	int beginRow = 0;
	int rowPerPage = 5;
	
	
	//Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	
	//최근 공지사항 5개, 최근 가입한 멤버 5명
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
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
			<table border="1">
				<tr>
					<th colspan="3">최신 공지사항</th>
				</tr>
				<tr>
					<%
						for(Notice n : noticeList) {
					%>
								<td><%=n.getNoticeNo() %></td>
								<td><%=n.getNoticeMemo() %></td>
								<td><%=n.getCreatedate() %></td>
							</tr><tr>
					<%
						}
					%>
				</tr>
			</table>
			<br>
			<table border="1">
				<tr>
					<th colspan="3">최근 가입회원</th>
				</tr>
				<tr>
					<%
						for(Member m : memberList) {
					%>
								<td><%=m.getMemberNo() %></td>
								<td><%=m.getMemberName() %></td>
								<td><%=m.getCreatedate() %></td>
							</tr><tr>
					<%
						}
					%>
				</tr>
			</table>
		</div>
	</body>
</html>