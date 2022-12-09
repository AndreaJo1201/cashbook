<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "java.net.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>UPDATE PW</title>
	</head>

	<body>
	<div class="main-wrapper">
		
		<jsp:include page="/inc/header.jsp"></jsp:include>
			
		<div class="content-body">
			<div class="table-reponsive container-fluid">
			<div class="login-form-bg h-100">
				<div class="container h-100">
					<div class="row justify-content-center h-100">
						<div class="col-xl-6">
							<div class="form-input-content">
								<div class="card login-form mb-0">
									<div class="card-body pt-5">
										<a class="text-center" href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp"><h1>회원 비밀번호 수정</h1></a>
										<form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
											<div class="form-group">
												<input type="password" class="form-control" placeholder="Password" name="memberPw">
											</div>
											<div class="form-group">
												<input type="password" class="form-control" placeholder="Change Password" name="changePw">
											</div>
											<div class="form-group">
												<input type="password" class="form-control" placeholder="Change Password Check" name="changePw2">
											</div>
											<button type="submit" class="btn login-form__btn submit w-100">UPDATE</button>
											<%
												if(request.getParameter("msg") != null) {
											%>
											<div class="alert alert-danger mt-1 alert-dismissible">
												<%=request.getParameter("msg") %>
												<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
											</div>
											<%
												}
											%>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
	</body>
</html>