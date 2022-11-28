<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	//Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // -> lastPage 계산용
	
	int lastPage = (int)Math.ceil(((double)(memberCount)/rowPerPage));
	
	
	
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
			<li><a href="<%=request.getContextPath()%>/admin/">고객센터 관리</a></li>
		</ul>
		
		<div>
			<!-- memberList contents... -->
			<h1>멤버 목록</h1>
			<table border="1">
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
				%>
						<tr>
							<td><%=m.getMemberNo() %></td>
							<td><%=m.getMemberId() %></td>
							<td><%=m.getMemberLevel() %></td>
							<td><%=m.getMemberName() %></td>
							<td><%=m.getUpdatedate() %></td>
							<td><%=m.getCreatedate() %></td>
							<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminForm.jsp?memberId=<%=m.getMemberId()%>">탈퇴</a></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%		
				}
			%>
			<span><%=currentPage %> / <%=lastPage %></span>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>