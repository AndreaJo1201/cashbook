<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") != null) { // 로그인 상태일시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
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
		
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
		<title>LOGIN</title>
	</head>

	<body>
	    <div class="table-reponsive container p-4">
			<table class="table table-bordered">
				<thead>
					<tr class="table-dark">
						<th class="col-sm-10 text-center"><label>공지사항</label></th>
						<th class="col-sm-2 text-center"><label>날짜</label></th>
					</tr>
				</thead>
				<tbody>
					<tr class="table-light">
					<%
						for(Notice n : list) {
					%>
								<td class="col-sm-10"><label><%=n.getNoticeMemo() %></label></td>
								<td class="col-sm-2 text-center"><label><%=n.getCreatedate() %></label></td> 
							</tr><tr class="table-light">
					<%
						}
					%>
					</tr>
				</tbody>
			</table>
			<div class="text-center">
				<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=1" class="btn btn-light btn-sm" >첫 페이지</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1 %>" class="btn btn-light btn-sm">이전</a>
				<%
					} 
				%>
						<label><%=currentPage %> / <%=lastPage %></label>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1 %>" class="btn btn-light btn-sm">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="btn btn-light btn-sm">마지막 페이지</a>
			</div>
		</div>	
	
	
	
		<!-- 공지사항(5개)목록 페이징 --> 
	     <div class="login-form-bg h-100">
	     	<div class="container h-100">
	            <div class="row justify-content-center h-100">
	                <div class="col-xl-6">
	                    <div class="form-input-content">
	                        <div class="card login-form mb-0">
	                            <div class="card-body pt-5">
	                                <a class="text-center" href="<%=request.getContextPath()%>/loginForm.jsp"><h1>CASH BOOK</h1></a>
	                                <form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
	                                    <div class="form-group">
	                                        <input type="text" class="form-control" placeholder="ID" name="memberId">
	                                    </div>
	                                    <div class="form-group">
	                                        <input type="password" class="form-control" placeholder="Password" name="memberPw">
	                                    </div>
	                                    <button type="submit" class="btn login-form__btn submit w-100">Sign In</button>
	                                    <%
	                                    	if(request.getParameter("msg") != null) {
	                                    %>
	                                    		<div class="alert alert-danger mt-1 alert-dismissible">
	                                    			<label><%=request.getParameter("msg") %></label>
	                                    			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	                                    		</div>
	                                    <%
	                                    	}
	                                    %>
	                                </form>
	                                <p class="mt-5 login-form__footer">Don't have account? <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="text-primary">Sign Up</a> now</p>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
		    

	</body>
</html>