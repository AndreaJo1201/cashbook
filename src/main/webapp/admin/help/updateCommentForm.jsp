<%@page import="vo.Comment"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Member"%>
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
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>문의사항 답변 수정</title>
		<style>		
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
			
			textarea {
				width:100%;
				height: 400px;
				border: none;
				resize: none;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-primary text-white">
				<h1><label>문의사항 답변 수정</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="mt-4">
				<table class="table table-bordered table-hover">
					<tr>
						<th colspan="2" class="col-sm-12 table-dark"><label>수정 전 내용</label></th>
					</tr>
					<tr>
						<th class="col-sm-1"><label>내용</label></th>
						<td class="col-sm-11"><p><label><%=comment.getCommentMemo() %></label></p></td>
					</tr>
					<tr>
						<th class="col-sm-1"><label>작성일</label></th>
						<td class="col-sm-11"><label><%=comment.getCreatedate() %></label></td>
					</tr>
					<tr>
						<th class="col-sm-1"><label>수정일</label></th>
						<td class="col-sm-11"><label><%=comment.getUpdatedate() %></label></td>
					</tr>
				</table>
			</div>
			
			<div class="mt-2 p-2">
				<form action="<%=request.getContextPath()%>/admin/help/updateCommentAction.jsp" method="post" id="form">
					<table class="table table-bordered">
						<tr>
							<th colspan="2" class="table-dark col-sm-12"><label>수정 사항</label></th>
						</tr>
						<tr>
							<th class="col-sm-1"><label>내용</label></th>
							<td class="col-sm-11"><textarea name="commentMemo" placeholder="수정할 내용을 입력해주세요."></textarea></td>
						</tr>
					</table>
					<input type="hidden" name="commentNo" value="<%=comment.getCommentNo() %>">
				</form>
				<div class="d-flex justify-content-between">
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
					<button type="submit" class="btn btn-sm btn-outline-success" form="form">수정</button>
				</div>
			</div>
		</div>	
	</body>
</html>