<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
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
	
	int rowPerPage = 10;
	
	MemberDao memberDao = new MemberDao();
	int memberCount = memberDao.selectMemberCount(); // -> lastPage 계산용
	int lastPage = (int)Math.ceil(((double)(memberCount)/(double)rowPerPage));
	
	if(currentPage < 1) { // 없는 페이지로 이동시 자동 이동
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?currentPage=1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?currentPage="+lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	
	//Model 호출
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	
	
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>회원 관리</title>
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
								<h1>회원 관리</h1>
							</div>
							<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
						</div>
					</div>
			
					<div class="table-reponsiove container-fluid">
						<div class="mt-2 p-2">
							<!-- memberList contents... -->
							<div class="card">
								<div class="card-body">
									<table class="table table-bordered table-hover">
										<thead class="thead-light">
											<tr>
												<th class="col-sm-1">회원 번호</th>
												<th class="col-sm-2">회원 ID</th>
												<th class="col-sm-1">회원 레벨</th>
												<th class="col-sm-2">회원 이름</th>
												<th class="col-sm-2">최신 수정일</th>
												<th class="col-sm-2">가입일자</th>
												<th class="col-sm-1">레벨 수정</th>
												<th class="col-sm-1">탈퇴</th>
											</tr>
										</thead>
										<tbody>
											<%
												for(Member m : memberList) {
											%>
													<tr>
														<td class="col-sm-1"><%=m.getMemberNo() %></td>
														<td  class="col-sm-2"><%=m.getMemberId() %></td>
														<td class="col-sm-1"><%=m.getMemberLevel() %></td>
														<td  class="col-sm-2"><%=m.getMemberName() %></td>
														<td  class="col-sm-2"><%=m.getUpdatedate() %></td>
														<td  class="col-sm-2"><%=m.getCreatedate() %></td>
														<td class="col-sm-1"><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>" class="btn btn-primary btn-sm">수정</a></td>
														<td class="col-sm-1"><a href="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminForm.jsp?memberId=<%=m.getMemberId()%>" class="btn btn-danger btn-sm">탈퇴</a></td>
													</tr>
											<%		
												}
											%>
										</tbody>
									</table>
									<div class="text-center">
										<ul class="pagination justify-content-center">				
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1" class="page-link">처음</a>
											</li>
											<%
												if(currentPage > 1){
											%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
													</li>
											<%
												}
												if(endPage <= lastPage) {
													for(int i=beginPage; i<=endPage; i++){
														if(currentPage == i){
														%>
															<li class="page-item active">
																<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
														<%		
														}else{
														%>
															<li class="page-item">
																<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
														<%	
														}
													}
												} else if(endPage > lastPage) {
													for(int i=beginPage; i<=lastPage; i++) {
														if(currentPage == i) {
											%>
															<li class="page-item active">
																<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
											<%				
														} else {
											%>
															<li class="page-item">
																<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
															</li>
											<%				
														}
													}
												}
												if(currentPage < lastPage){
											%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
													</li>
											<%
												}
											%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</body>
</html>