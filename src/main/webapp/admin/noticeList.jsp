<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	int rowPerPage = 10;
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	
	//Model 호출
	
	//notice List 출력
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int lastPage =(int) Math.ceil((double)(noticeDao.selectNoticeCount()) / (double)rowPerPage);
	
	
	if(currentPage < 1 || currentPage > lastPage) {
		String msg = "";
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
	}
	
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
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(회원 목록 보기, level 수정, 강제회원탈퇴)</a></li>
		</ul>
		
		<div>
			<!-- notice contents... -->
			<h1>공지사항</h1>
			<a href = "<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지사항 추가</a>
			<table border="1">
				<tr>
					<th>공지사항 번호</th>
					<th>공지사항 내용</th>
					<th>공지사항 게시일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeNo() %></td>
							<td><%=n.getNoticeMemo() %></td>
							<td><%=n.getCreatedate() %></td>
							<td><a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/notice/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
						</tr>
				<%
					}
				%>
			</table>
			
			<div>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
				<%
					}
				%>
				<span><%=currentPage%> / <%=lastPage %></span>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage %>">마지막</a>
			</div>
		</div>
	</body>
</html>