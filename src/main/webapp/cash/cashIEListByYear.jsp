<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@page import="java.text.NumberFormat"%>

<%
	// Controller : session, request 요청
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

	CashDao cashDao = new CashDao();
	
	ArrayList<HashMap<String,Object>> IEListYear = cashDao.selectImportExportListByYear(memberId);
	
	NumberFormat numberFormat = NumberFormat.getInstance();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>CASH_LIST(IE)</title>
	</head>

	<body>
		<div id="main-wrapper">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			
			<div class="content-body">
				<div class="container-fluid table-responsive mt-2">
					<div class="card">
						<div class="card-body text-center">
							<span class="h1">연도별 누적 데이터</span>
							
							<div class="mt-2 p-2">
								<table class="table table-bordered">
									<thead class="thead-dark">
										<tr>
											<th>연도</th>
											<th>수입 건수</th>
											<th>수입 합계</th>
											<th>수입 평균</th>
											<th>지출 건수</th>
											<th>지출 합계</th>
											<th>지출 평균</th>
											<th>총 합계</th>							
										</tr>
									</thead>
									<tbody>
										<tr>
											<%
												if(!IEListYear.isEmpty()) {
													for(HashMap<String,Object> m : IEListYear) {	
											%>
														<td><%=m.get("year") %>년</td>
														<td><%=m.get("importCnt") %>건</td>
														<td><%=numberFormat.format((long)m.get("importSum"))%>원</td>
														<td><%=numberFormat.format((long)m.get("importAvg"))%>원</td>
														<td><%=m.get("exportCnt") %>건</td>
														<td><%=numberFormat.format((long)m.get("exportSum")) %>원</td>
														<td><%=numberFormat.format((long)m.get("exportAvg"))%>원</td>
											<%
														if((long)m.get("importSum")>=(long)m.get("exportSum")) {
											%>
															<td class="text-info"><%=numberFormat.format((long)m.get("importSum")-(long)m.get("exportSum")) %>원</td>
											<%
														} else {
											%>
															<td class="text-danger"><%=numberFormat.format((long)m.get("importSum")-(long)m.get("exportSum")) %>원</td>
											<%
														}
											%>
														</tr><tr>
											<%
													}
												} else {
											%>
													<td class="text-danger text-center" colspan="8">입력된 데이터가 없습니다.</td>
											<%
												}
											%>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>