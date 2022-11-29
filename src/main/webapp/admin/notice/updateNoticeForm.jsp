<%@page import="vo.Member"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
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

	if(request.getParameter("noticeNo") == null ||
		request.getParameter("noticeNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
			return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeByNo = noticeDao.selectNoticeByNo(noticeNo);
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 수정</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		
		<style>
			textarea {
				width:100%;
				height: 400px;
				border: none;
				resize: none;
			}
			
			th {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1><label>공지사항 작성</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-4">
			<table class="table table-bordered">
				<tr>
					<th colspan="2" class="col-sm12 table-dark"><label>기존 공지사항</label></th>
				</tr>
				<tr>
					<th class="col-sm-1"><label>내용</label></th>
					<td class="col-sm-12">
						<p><label><%=noticeByNo.getNoticeMemo() %></label></p>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="mt-2 p-2">
			<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post" id="form">
				<table class="table table-bordered">
					<tr>
						<th colspan="2" class="table-dark col-sm-12"><label>수정 사항</label></th>	
					</tr>
					<tr>
						<th class="col-sm-1"><label>내용</label></th>
						<td class="col-sm-11"><textarea name="noticeMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
					</tr>
				</table>
				<input type="hidden" name="noticeNo" value="<%=noticeByNo.getNoticeNo()%>">
			</form>
			
			<div class="d-flex justify-content-between">
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
				<button type="submit" class="btn btn-outline-success btn-sm" form="form">수정</button>
			</div>
		</div>
	</div>	
	</body>
</html>