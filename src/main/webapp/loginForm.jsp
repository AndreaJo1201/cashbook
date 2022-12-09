<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("loginMember") != null) { // 로그인 상태일시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	
	NoticeDao noticeDao = new NoticeDao();
	
	int lastPage = (int)Math.ceil((double)noticeDao.selectNoticeCount() / (double)rowPerPage); // 공지사항 카운트해서 lastPage 구하기
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	System.out.println("lastPage = "+lastPage);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
		<title>LOGIN</title>
		<style>
			.leftcolumn {
				float:left;
				width:75%
			}
			
			.rightcolumn {
				float: left;
				width: 25%;
				padding-left: 20px;
			}
		</style>
	</head>

	<body>
	    <div class="table-reponsive container p-4">
	    	<div class="card">
		    	<div class="card-body">
					<table class="table table-dark">
						<thead class="thead-dark">
							<tr>
								<th class="col-sm-10 text-center">공지사항</th>
								<th class="col-sm-2 text-center">날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr class="table-light">
							<%
								for(Notice n : list) {
							%>
										<td class="col-sm-10"><%=n.getNoticeMemo() %></td>
										<td class="col-sm-2 text-center"><%=n.getCreatedate() %></td> 
									</tr><tr class="table-light">
							<%
								}
							%>
							</tr>
						</tbody>
					</table>
					<!-- 공지사항(5개)목록 페이징 -->
					<div class="text-center">
						<ul class="pagination justify-content-center">				
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1" class="page-link">처음</a>
							</li>
							<%
								if(currentPage > 1){
							%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
									</li>
							<%
								}
								if(endPage <= lastPage) {
									for(int i=beginPage; i<=endPage; i++){
										if(currentPage == i){
										%>
											<li class="page-item active">
												<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
											</li>
										<%		
										}else{
										%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
											</li>
										<%	
										}
									}
								} else if(endPage > lastPage) {
									for(int i=beginPage; i<=lastPage; i++) {
										if(currentPage == i) {
							%>
											<li class="page-item active">
												<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
											</li>
							<%				
										} else {
							%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
											</li>
							<%				
										}
									}
								}
								if(currentPage < lastPage){
							%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
									</li>
							<%
								}
							%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
 
		
		<div class="login-form-bg h-100">
	     	<div class="container h-100">
	            <div class="row justify-content-center h-100">
	                <div class="col-xl-6">
	                    <div class="form-input-content">
	                        <div class="card login-form mb-0">
	                            <div class="card-body pt-5">
	                                <a class="text-center" href="<%=request.getContextPath()%>/loginForm.jsp"><h1>CASH BOOK</h1></a>
	                                <form class="mt-5 mb-5 login-input" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
	                                    <div class="form-group">
	                                        <input type="text" class="form-control" placeholder="ID" name="memberId">
	                                    </div>
	                                    <div class="form-group">
	                                        <input type="password" class="form-control" placeholder="Password" name="memberPw">
	                                    </div>
	                                    <button type="submit" class="btn login-form__btn submit w-100">Sign In</button>
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
	                                <p class="mt-5 login-form__footer">Don't have account? <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="text-primary">Register</a> now</p>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
		</div>
	    
	    
    <!--**********************************
        Scripts
    ***********************************-->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>