<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") != null) { //로그인 상태로는 접속 불가, 로그인 상태일시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>Register</title>
	</head>

	<body>
		<div class="table-reponsive container-fluid">
			<div class="login-form-bg h-100">
				<div class="container h-100">
					<div class="row justify-content-center h-100">
						<div class="col-xl-6">
							<div class="form-input-content">
								<div class="card login-form mb-0">
									<div class="card-body pt-5">
										<a class="text-center" href="<%=request.getContextPath()%>/member/insertMemberForm.jsp"><h1>Register</h1></a>
										<form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="ID" name="memberId">
											</div>
											<div class="form-group">
												<input type="password" class="form-control" placeholder="Password" name="memberPw">
											</div>
											<div class="form-group">
												<input type="text" class="form-control" placeholder="Nick Name" name="memberName">
											</div>
											<button type="submit" class="btn login-form__btn submit w-100">Register</button>
		                                    <%
		                                    	if(request.getParameter("msg") != null) {
		                                    %>
		                                    		<div class="alert alert-danger mt-1 alert-dismissible fade show">
		                                    			<%=request.getParameter("msg") %>
														<button type="button" class="close" data-dismiss="alert" aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
		                                    		</div>
		                                    <%
		                                    	}
		                                    %>
										</form>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-end">
								<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-dark">Back</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>