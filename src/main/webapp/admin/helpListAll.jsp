<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이징 처리하기 currentPage
	int rowPerPage = 10;
	
	HelpDao helpDao = new HelpDao();
	
	int helpListCount = helpDao.selectHelpListCount();
	int lastPage = (int)Math.ceil(((double)(helpListCount)/(double)rowPerPage));
	
	if(currentPage < 1) { // 없는 페이지로 이동시 자동 이동
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp?currentPage=1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp?currentPage="+lastPage);
	}
	
	int beginRow = (currentPage-1) * rowPerPage;
	
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	

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
		<title>문의사항 내역</title>
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1><label>문의사항</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-responsive container-fluid">
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<table class="table table-bordered table-hover">
								<thead class="thead-light">
									<tr>
										<th class="col-sm-1">번호</th>
										<th class="col-sm-3">문의내용</th>
										<th class="col-sm-1">작성자</th>
										<th class="col-sm-2">작성일</th>
										<th class="col-sm-3">답변내용</th>
										<th class="col-sm-1">답변일</th>
										<th class="col-sm-1">답변추가 / 수정 / 삭제</th>				
									</tr>
								</thead>
								<tbody>
									<tr>
									<%
										for(HashMap<String,Object> m : list) {
									%>
											<td class="col-sm-1"><label><%=m.get("helpNo") %></label></td>
											<td class="col-sm-3"><label><%=m.get("helpMemo") %></label></td>
											<td class="col-sm-1"><label><%=m.get("memberId") %></label></td>
											<td class="col-sm-2"><label><%=m.get("helpCreateDate") %></label></td>
											<td class="col-sm-3">
												<%
													if(m.get("commentMemo") == null) {
												%>
														<span><label>답변 미작성</label></span>
												<%
													} else {
												%>
														<label><%=m.get("commentMemo") %></label>
												<%
													}
												%>
											</td>
											<td class="col-sm-1">							
												<%
													if(m.get("commentMemo") == null) {
												%>
														<span><label>답변 미작성</label></span>
												<%
													} else {
												%>
														<label><%=m.get("commentCreateDate") %></label>
												<%
													}
												%></td>
											<td class="col-sm-1">
												<%
													if(m.get("commentMemo") == null) {
												%>
														<a href="<%=request.getContextPath()%>/admin/help/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-outline-primary btn-sm">답변 입력</a>
												<%
													} else {
												%>
														<a href="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-sm btn-primary">답변 수정</a>
														<a href="<%=request.getContextPath()%>/admin/help/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-sm btn-danger">답변 삭제</a>
														<!-- 수정 삭제 주소 변경 필요 -->
												<%
													}
												%>
											</td>
											</tr><tr>
									<%
										}
									%>
									</tr>
								</tbody>
							</table>
							<div class="text-center">
								<ul class="pagination justify-content-center">				
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1" class="page-link">처음</a>
									</li>
									<%
										if(currentPage > 1){
									%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
											</li>
									<%
										}
										if(endPage <= lastPage) {
											for(int i=beginPage; i<=endPage; i++){
												if(currentPage == i){
												%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%		
												}else{
												%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%	
												}
											}
										} else if(endPage > lastPage) {
											for(int i=beginPage; i<=lastPage; i++) {
												if(currentPage == i) {
									%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
									<%				
												} else {
									%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
									<%				
												}
											}
										}
										if(currentPage < lastPage){
									%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
											</li>
									<%
										}
									%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>