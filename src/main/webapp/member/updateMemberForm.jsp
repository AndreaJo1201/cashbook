<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.net.*" %>
<%@ page import = "vo.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember"); //session 값 get
	String memberId = loginMember.getMemberId(); // session에서 memberId 값 할당
	String memberName = loginMember.getMemberName(); // session에서 memberName 값 할당

%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>UPDATE</title>
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
											<a class="text-center" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp"><h1>회원 정보 수정</h1></a>
											<form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
												<div class="form-group">
													<input type="text" class="form-control" placeholder="ID" name="memberId" value="<%=memberId%>" readonly="readonly">
												</div>
												<div class="form-group">
													<input type="text" class="form-control" placeholder="Nick Name" name="memberName" value="<%=memberName%>">
												</div>
												<div class="form-group">
													<input type="password" class="form-control" placeholder="Password" name="memberPw">
												</div>
												<button type="submit" class="btn login-form__btn submit w-100">UPDATE</button>
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