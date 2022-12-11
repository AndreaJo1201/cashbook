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
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
		<style>
			textarea {
				width:100%;
				height: 400px;
				border: none;
				resize: none;
			}
			
			.center_middle {
				vertical-align: middle;
				text-align: center;
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
								<h1>공지사항 작성</h1>
							</div>
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</div>
					</div>
		
					<div class="table-responsive container-fluid">
						<div class="mt-2 p-2">
							<div class="card">
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp" method="post" id="form">
										<table class="table table-bordered">
											<thead class="thead-light">
												<tr>
													<th class="col-sm-12 text-center" colspan="2">공지사항 작성</th>
												</tr>
											</thead>
											<tbody>
												<tr class="table-light">
													<td class="col-sm-1 text-center"><strong>내용</strong></td>
													<td class="col-sm-11"><textarea name="noticeMemo" placeholder="공지사항 내용을 입력해주세요."></textarea></td>
												</tr>
											</tbody>
										</table>
									</form>
								</div>
							</div>
							<div class="d-flex justify-content-between">
								<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
								<button type="submit" class="btn btn-outline-primary btn-sm" form="form">입력</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>