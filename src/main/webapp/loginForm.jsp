<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="vo.*" %>

<%
	if(session.getAttribute("loginMember") != null) { // 로그인 상태일시 가계부 페이지로 이동
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
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>LOGIN</title>
		
		<style>
			#login {
			  height: 100px;
			  width: 300px;
			  margin: auto;
			  text-align: center;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<!-- 공지사항(5개)목록 페이징 -->
			<div class="text-end p-2">
				<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="btn btn-dark btn-sm">회원가입</a>
			</div>
			<div>
				<table class="table text-center table-hover">
					<thead>
						<tr class="table-dark">
							<th class="col-sm-10"><label>공지사항</label></th>
							<th class="col-sm-2"><label>날짜</label></th>
						</tr>
					</thead>
					<tbody>
						<tr class="table-light">
						<%
							for(Notice n : list) {
						%>
									<td class="col-sm-10"><label><%=n.getNoticeMemo() %></label></td>
									<td class="col-sm-2"><label><%=n.getCreatedate() %></label></td> 
								</tr><tr class="table-light">
						<%
							}
						%>
						</tr>
					</tbody>
				</table>
				<div class="text-center">
				<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=1" class="btn btn-secondary btn-sm" >첫 페이지</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1 %>" class="btn btn-secondary btn-sm">이전</a>
				<%
					} 
				%>
						<label><%=currentPage %> / <%=lastPage %></label>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1 %>" class="btn btn-secondary btn-sm">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="btn btn-secondary btn-sm">마지막 페이지</a>
				</div>
			</div>
		
			<div class="mt-4 p-4 text-dark rounded" id="login">
				<h1><label>LOGIN</label></h1>
			</div>
			<div class="text-center" id="login">
				<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="align_middle">
					<table class="table table-sm table-bordered">
						<tr class="text-center">
							<td>
								<label>ID</label>
							</td>
							<td><input type="text" name="memberId"></td>
						</tr>
						<tr class="text-center">
							<td>
								<label>PW</label>
							</td>
							<td><input type="password" name="memberPw"></td>
						</tr>
					</table>
					<div class="d-grid">
						<button type="submit" class="btn btn-primary btn-lg btn-block">JOIN</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>