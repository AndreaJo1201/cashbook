<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="vo.*" %>

<%
	if(session.getAttribute("loginEmpNo") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage; // 공지사항 카운트해서 lastPage 구하기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	System.out.println("lastPage = "+lastPage);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LOGIN</title>
	</head>

	<body>
		<!-- 공지사항(5개)목록 페이징 -->
		<div>
			<table border="1">
				<tr>
					<th>공지내용</th>
					<th>날짜</th>
				</tr>
				<tr>
				<%
					for(Notice n : list) {
				%>
							<td><%=n.getNoticeMemo() %></td>
							<td><%=n.getCreatedate() %></td> 
						</tr><tr>
				<%
					}
				%>
				</tr>
			</table>
			<%
				if(currentPage > 1) {
			%>
					<div>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1 %>">이전 공지사항</a>
					</div>
			<%
				}
				if(currentPage < lastPage) {
			%>
				<div>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1 %>">다음 공지사항</a>
				</div>
			<%
				}
			%>
		</div>
	
		<div>
			<h1>LOGIN</h1>
		</div>
		<div>
			<form action="<%=request.getContextPath()%>/loginAction.jsp">
				<table>
					<tr>
						<td>ID</td>
						<td><input type="text" name="memberId"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
				</table>
				<button type="submit">login</button>
			</form>
		</div>
		<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
	</body>
</html>