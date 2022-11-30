<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) { // 세션 정보가 없을시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 작성</title>
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
			<h1>공지사항 작성</h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-2 p-2">
			<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp" method="post" id="form">
				<table class="table table-bordered">
					<tr>
						<th class="col-sm-1">내용</th>
						<td class="col-sm-11"><textarea name="noticeMemo" placeholder="공지사항 내용을 입력해주세요."></textarea></td>
					</tr>
				</table>
			</form>
			
			<div class="d-flex justify-content-between">
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
				<button type="submit" class="btn btn-outline-primary btn-sm" form="form">입력</button>
			</div>
		</div>
	</div>
	</body>
</html>