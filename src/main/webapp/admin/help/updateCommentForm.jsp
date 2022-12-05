<%@page import="vo.Comment"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Member"%>
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
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("")) { //코멘트 식별 번호가 없을시 리스트로 이동
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
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1><label>문의사항 답변 수정</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-responsive container-fluid">
				<div class="mt-4">
					<div class="card">
						<div class="card-body">
							<table class="table table-bordered table-hover">
								<thead class="thead-light">
									<tr>
										<th colspan="2" class="col-sm-12 table-dark"><label>수정 전 내용</label></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
										<td class="col-sm-11"><p><label><%=comment.getCommentMemo() %></label></p></td>
									</tr>
									<tr>
										<td class="col-sm-1 text-center"><label><strong>작성일</strong></label></td>
										<td class="col-sm-11"><label><%=comment.getCreatedate() %></label></td>
									</tr>
									<tr>
										<td class="col-sm-1 text-center"><label><strong>수정일</strong></label></td>
										<td class="col-sm-11"><label><%=comment.getUpdatedate() %></label></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/help/updateCommentAction.jsp" method="post" id="form">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th colspan="2" class="col-sm-12"><label>수정 사항</label></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
											<td class="col-sm-11"><textarea name="commentMemo" placeholder="수정할 내용을 입력해주세요."></textarea></td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="commentNo" value="<%=comment.getCommentNo() %>">
							</form>
						</div>
					</div>
					<div class="d-flex justify-content-between">
						<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
						<button type="submit" class="btn btn-sm btn-outline-success" form="form">수정</button>
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>