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
	
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null) {
			Calendar today = Calendar.getInstance();
			year = today.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}

	CashDao cashDao = new CashDao();
	
	ArrayList<HashMap<String, Object>> IEList = cashDao.selectImportExportListByYear(year, memberId);
	
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
						<div class="card-body">
							<div class="d-flex justify-content-around row">
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashIEListByMonth.jsp?year=<%=year-1%>" class="btn btn-dark">이전 년도</a>
								</div>
								<div>
									<span class="h1"><%=year %>년 월별 데이터</span>
								</div>
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashIEListByMonth.jsp?year=<%=year+1%>" class="btn btn-dark">다음 년도</a>
								</div>
							</div>
							<div class="mt-2 p-2">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th>월</th>
											<th>수입 건수</th>
											<th>수입 합계</th>
											<th>수입 평균</th>
											<th>지출 건수</th>
											<th>지출 합계</th>
											<th>지출 평균</th>
											<th>합계</th>							
										</tr>
									</thead>
									<tbody>
										<tr>
											<%
												if(!IEList.isEmpty()) {
													for(HashMap<String,Object> m : IEList) {
											%>
														<td><%=m.get("month") %>월</td>
														<td><%=m.get("importCnt") %>건</td>
														<td><%=numberFormat.format((long)m.get("importSum"))%>원</td>
														<td><%=numberFormat.format((long)m.get("importAvg"))%>원</td>
														<td><%=m.get("exportCnt") %>건</td>
														<td><%=numberFormat.format((long)m.get("exportSum")) %>원</td>
														<td><%=numberFormat.format((long)m.get("exportAvg"))%>원</td>
											<%
														if((long)m.get("importSum") >= (long)m.get("exportSum")) {
											%>
															<td class="text-info"><%=numberFormat.format((long)m.get("importSum")-(long)m.get("exportSum"))%>원</td>
											<%
														} else {
											%>
															<td class="text-danger"><%=numberFormat.format((long)m.get("importSum")-(long)m.get("exportSum"))%>원</td>
											<%
														}
											%>
														</tr><tr>
											<%
													}
												} else {
											%>
													<td class="text-center text-danger" colspan="8">입력된 데이터가 없습니다.</td>
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