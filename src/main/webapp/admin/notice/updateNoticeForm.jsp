<%@page import="vo.Member"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("noticeNo") == null ||
		request.getParameter("noticeNo").equals("")) { // 공지사항 식별 번호가 없을 시 list 페이지로 이동
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
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
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
	<div class="container-fluid">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-light text-white">
			<h1><label>공지사항 수정</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="table-responsive container-fluid">
			<div class="mt-4">
				<div class="card">
					<div class="card-body">
						<table class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th colspan="2" class="col-sm-12"><label>기존 공지사항</label></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
									<td class="col-sm-12">
										<p><label><%=noticeByNo.getNoticeMemo() %></label></p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="mt-2 p-2">
				<div class="card">
					<div class="card-body">
						<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post" id="form">
							<table class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th colspan="2" class="col-sm-12"><label>수정 사항</label></th>	
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
										<td class="col-sm-11"><textarea name="noticeMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="noticeNo" value="<%=noticeByNo.getNoticeNo()%>">
						</form>
						
						<div class="d-flex justify-content-between">
							<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
							<button type="submit" class="btn btn-outline-success btn-sm" form="form">수정</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	</body>
</html>