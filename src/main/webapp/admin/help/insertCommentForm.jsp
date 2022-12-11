<%@page import="vo.Help"%>
<%@page import="dao.HelpDao"%>
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
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) { // 답변 달려는 문의사항 식별 번호가 없을 시 문의 list로 이동
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelp(helpNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
		<title>문의사항 답변 작성</title>
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
		<div id="main-wrapper">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			
			<div class="content-body">
				<div class="container-fluid table-responsive mt-2">
					<div class="container-fluid">
						<div class="mt-2 card">
							<div class="mt-4 p-5 card-body">
								<h1>문의사항 답변 작성</h1>
							</div>
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</div>
					</div>
		
					<div class="table-responsive container-fluid">
						<div class="mt-4">
							<div class="card">
								<div class="card-body">
									<table class="table table-bordered">
										<thead class="thead-light">
											<tr>
												<th colspan="2" class="col-sm-12">회원 문의사항</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="col-sm-1 text-center"><strong>문의내용</strong></td>
												<td class="col-sm-11"><p><%=help.getHelpMemo() %></p></td>
											</tr>
											<tr>
												<td class="col-sm-1 text-center"><strong>작성자</strong></td>
												<td class="col-sm-11"><span><%=help.getMemberId() %></span></td>
											</tr>
											<tr>
												<td class="col-sm-1 text-center"><strong>작성일</strong></td>
												<td class="col-sm-11"><span><%=help.getCreatedate() %></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<div class="mt-2 p-2">
							<div class="card">
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post" id="form">
										<table class="table table-bordered">
											<thead class="thead-light">
												<tr>
													<th colspan="2" class="col-sm-12">답변 작성</th>
												</tr>
											</thead>
											<tbody>
											<tr>
												<td class="col-sm-1 text-center"><strong>답변</strong></td>
												<td class="col-sm-11"><textarea name="commentMemo" placeholder="코멘트를 입력해주세요."></textarea></td>
											</tr>
											</tbody>
										</table>
										<input type="hidden" name="helpNo" value="<%=helpNo %>">
									</form>
								</div>
							</div>
							<div class="d-flex justify-content-between">
								<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
								<button type="submit" class="btn btn-outline-success btn-sm" form="form">답변작성</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>