<%@page import="dao.HelpDao"%>
<%@page import="vo.Help"%>
<%@page import="vo.Member"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
			return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setMemberId(loginMember.getMemberId());
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpListOne(help);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>상세 문의 내역</title>
		<style>
			.center_middle {
				vertical-align: middle;
				text-align: cneter;
			}
				
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
		</style>
		<title>문의사항 확인</title>
	</head>

	<body>
		<div class="main-wrapper">
		
			<jsp:include page="/inc/header.jsp"></jsp:include>
			
			<div class="content-body">
				<div class="container-fluid table-responsive mt-2">
					<div class="container-fluid">
						<div class="mt-2 card">
							<div class="card-body p-2">
								<div class="mt-4 p-5 text-dark">
									<h1>문의사항 확인</h1>
								</div>
							</div>
						</div>
					</div>
				
					<div class="table-responsive container-fluid">
						<div class="mt-2">
							<div class="card">
								<div class="card-body">
									<table class="table table-bordered">
										<thead class="thead-light">
											<tr>
												<th colspan="4" class="col-sm-12 text-center">문의 내용</th>
											</tr>
											<tr>
												<td class="col-sm-1"><strong>번호</strong></td>
												<td class="col-sm-7"><strong>내용</strong></td>
												<td class="col-sm-2"><strong>수정일</strong></td>
												<td class="col-sm-2"><strong>작성일</strong></td>
											</tr>
										</thead>
										<tr>
											<%
												for(HashMap<String,Object> h : list) {
											%>
													<td class="col-sm-1"><%=h.get("helpNo") %></td>
													<td class="col-sm-7"><%=h.get("helpMemo") %></td>
													<td class="col-sm-2"><%=h.get("helpUpdateDate") %></td>
													<td class="col-sm-2"><%=h.get("helpCreatedate") %></td>
											<%
												}
											%>
										</tr>
									</table>
								</div>
							</div>
						</div>
						
						<div class="mt-2">
							<div class="card">
								<div class="card-body">
									<table class="table table-bordered">
										<thead class="thead-light">
											<tr>
												<th colspan="4" class="col-sm-12 text-center">관리자 답변</th>
											</tr>
											<tr>
												<td class="col-sm-1 text-center"><strong>번호</strong></td>
												<td class="col-sm-7 text-center"><strong>내용</strong></td>
												<td class="col-sm-2 text-center"><strong>작성자</strong></td>
												<td class="col-sm-2 text-center"><strong>작성일</strong></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<%
													for(HashMap<String,Object> h : list) {
														if(h.get("commentMemo") != null) {
												%>
															<td class="col-sm-1"><%=h.get("commentNo") %></td>
															<td class="col-sm-7"><%=h.get("commentMemo") %></td>
															<td class="col-sm-2"><%=h.get("commentMemberId") %></td>
															<td class="col-sm-2"><%=h.get("commentCreateDate") %></td>
												<%
														} else {
												%>
															<td colspan="4" class="col-sm-12">답변된 작성이 없습니다.</td>
												<%
														}
													}
												%>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="mt-2 p-2 text-end">
							<span><a href="<%=request.getContextPath()%>/help/helpList.jsp" class="btn btn-sm btn-dark">뒤로가기</a></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>