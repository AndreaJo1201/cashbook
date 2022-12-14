<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	//Controller
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
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	int rowPerPage = 10;
	
	NoticeDao noticeDao = new NoticeDao();
	int noticeCount = noticeDao.selectNoticeCount();
	int lastPage =(int) Math.ceil((double)(noticeDao.selectNoticeCount()) / (double)rowPerPage);
	
	if(currentPage < 1) { // 존재하지 않는 페이지로 이동 시 자동 이동
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?currentPage=1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?currentPage="+lastPage);
	}
	
	int beginRow = (currentPage-1)*rowPerPage;
	
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	
	
	//Model 호출
	
	//notice List 출력
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>Notice</title>
		
		<style>		
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
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
								<h1>공지사항</h1>
							</div>
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</div>
					</div>
			
					<div class="table-reponsive container-fluid">
						<div class="mt-2 p-2">
							<!-- notice contents... -->
							<div class="card">
								<div class="card-body">
									<table class="table table-bordered text-center table-hover">
										<thead class="thead-light">
											<tr>
												<th class="col-sm-1">번호</th>
												<th class="col-sm-7">공지사항 내용</th>
												<th class="col-sm-2">게시일</th>
												<th class="col-sm-1">수정</th>
												<th class="col-sm-1">삭제</th>
											</tr>
										</thead>
										<tbody>
										<%
											for(Notice n : list) {
										%>
												<tr>
													<td class="col-sm-1"><%=n.getNoticeNo() %></td>
													<td class="col-sm-7"><%=n.getNoticeMemo() %></td>
													<td class="col-sm-2"><%=n.getCreatedate() %></td>
													<td class="col-sm-1">
														<a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-primary btn-sm">
															수정
														</a>
													</td>
													<td class="col-sm-1">
														<a href="<%=request.getContextPath()%>/admin/notice/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-danger btn-sm">
															삭제
														</a>
													</td>
												</tr>
										<%
											}
										%>
										</tbody>
									</table>
									<div class="text-center">
										<ul class="pagination justify-content-center">				
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1" class="page-link">처음</a>
											</li>
											<%
												if(currentPage > 1){
											%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
													</li>
											<%
												}
												if(endPage <= lastPage) {
													for(int i=beginPage; i<=endPage; i++){
														if(currentPage == i){
														%>
															<li class="page-item active">
																<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
														<%		
														}else{
														%>
															<li class="page-item">
																<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
														<%	
														}
													}
												} else if(endPage > lastPage) {
													for(int i=beginPage; i<=lastPage; i++) {
														if(currentPage == i) {
											%>
															<li class="page-item active">
																<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
											<%				
														} else {
											%>
															<li class="page-item">
																<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
											<%				
														}
													}
												}
												if(currentPage < lastPage){
											%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
													</li>
											<%
												}
											%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
											</li>
										</ul>
									</div>
								</div>
							</div>	
							<div class="d-flex justify-content-end">
								<a href="<%=request.getContextPath() %>/admin/notice/insertNoticeForm.jsp" class="btn btn-sm btn-outline-primary">공지사항 작성</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</body>
</html>