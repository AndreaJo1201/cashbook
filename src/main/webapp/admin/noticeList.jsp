<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

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
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>Notice</title>
		
		<style>
			.center {
				text-align:center;
				margin: auto;
			}
			
			th {
				vertical-align: middle;
				text-align: cneter;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
	<div class="container"> 
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1>공지사항</h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-2 p-2">
			<!-- notice contents... -->
			<table class="table table-bordered text-center table-hover">
				<tr>
					<th class="col-sm-1">번호</th>
					<th class="col-sm-7">공지사항 내용</th>
					<th class="col-sm-2">게시일</th>
					<th class="col-sm-1">수정</th>
					<th class="col-sm-1">삭제</th>
				</tr>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td class="col-sm-1"><%=n.getNoticeNo() %></td>
							<td class="col-sm-7"><%=n.getNoticeMemo() %></td>
							<td class="col-sm-2"><%=n.getCreatedate() %></td>
							<td class="col-sm-1">
								<a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-primary btn-sm">
									수정
								</a>
							</td>
							<td class="col-sm-1">
								<a href="<%=request.getContextPath()%>/admin/notice/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-danger btn-sm">
									삭제
								</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<div class="text-center">
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1" class="btn btn-light">처음</a>
				<%
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1 %>" class="btn btn-light">이전</a>
				<%
					}
				%>
				<span><label><%=currentPage%> / <%=lastPage %></label></span>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1 %>" class="btn btn-light">다음</a>
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage %>" class="btn btn-light">마지막</a>
			</div>
		</div>	
		<div class="d-flex justify-content-end">
			<a href="<%=request.getContextPath() %>/admin/notice/insertNoticeForm.jsp" class="btn btn-sm btn-outline-primary">공지사항 작성</a>
		</div>

	</div>	
	</body>
</html>