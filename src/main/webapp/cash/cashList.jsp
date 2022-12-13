<%@page import="java.text.NumberFormat"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "dao.*" %>

<%	
	// Controller : session, request 요청
	if(session.getAttribute("loginMember") == null) {
		// 비 로그인 접속 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String msg = null;
	if(request.getParameter("msg") != null) {
		msg = request.getParameter("msg");
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	//request : 년 + 월
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null ||
		request.getParameter("month") == null) {
			Calendar today = Calendar.getInstance();
			year = today.get(Calendar.YEAR);
			month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		if(month == -1) {
			month = 11;
			year = year - 1;
		} else if (month == 12) {
			month = 0;
			year = year + 1;
		}
	}

	// 출력하려는 월, 해당 월의 1일 요일(일~토 = 1~7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	//달력 월의 1일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일 (일~토:1~7)
	
	// 월 별 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 마지막 날짜
	
	//BEGIN blank개수는 firstDay - 1
	int beginBlank = firstDay - 1;
	int endBlank = 0; // (beginBlank + lastDate) + endBlank = 7 | 7로 나누어 떨어져야함.
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	//전체 td의 개수 : 7로 나누어 떨어져야 한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	long totalCash = 0;
	long expenseCash = 0;
	long importCash = 0;
	
	//숫자 천단위 , 출력
	NumberFormat numberFormat = NumberFormat.getInstance();
	
	/*************************************************************************************************************/
	
	//model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMont(year, month+1, memberId); // cashDao.java 참조
	
	ArrayList<HashMap<String, Object>> IEList = cashDao.selectImportExportListByYear(year, memberId);
	
	ArrayList<HashMap<String,Object>> IEListYear = cashDao.selectImportExportListByYear(memberId);
	
	
	/*************************************************************************************************************/
	//View : 달력출력 + 일별 cash 목록
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>CASH_LIST</title>
		<style>
			#td {
				width:14.28%;
			}			
		</style>
	</head>

	<body>
	<div id="main-wrapper">	
		
		<jsp:include page="/inc/header.jsp"></jsp:include>
		
		<div class="content-body">
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
			<div class="container-fluid table-responsive mt-2">
				<div class="card">
					<div class="card-body">
						<table class="table table-bordered">
							<thead>
							<tr class="text-center table-dark">
								<th colspan="7">
									<span class="col-sm-5"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-primary btn-sm">&#8701; 이전달</a></span>
									<span class="col-sm-2"><%=year %>년 <%=month+1 %>월</span>
									<span class="col-sm-5"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-primary btn-sm">다음달 &#8702;</a></span>
								</th>
							</tr>
							<tr class="table-light">
								<th class="text-danger">일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th class="text-primary">토</th>
							</tr>
							</thead>
							
							<tr class="table-light">
							<!-- 달력 -->
							<%
								for(int i=1; i<=totalTd; i++) {
							%>
									<td id="td">
							<%
										int date = i-beginBlank;
										if(date > 0 && date <= lastDate) {
							%>
											<div>
											<%
												if(i%7 ==1) {
											%>
													<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>" class="text-decoration-none text-danger">
														<%=date %>
													</a>
											<%
												} else if(i%7==0) {
											%>
													<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>" class="text-decoration-none text-primary">
														<%=date %>
													</a>
											<%
												} else {
											%>
													<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>" class="text-decoration-none text-dark">
														<%=date %>
													</a>
											<%		
												}
											%>
											</div>
											<div>
												<%
													for(HashMap<String, Object> m : list) {
														String cashDate = (String)(m.get("cashDate"));
														if(Integer.parseInt(cashDate.substring(8)) == date) {
												%>
															[<%=(String)(m.get("categoryKind")) %>]
															₩<%=numberFormat.format((Long)(m.get("cashPrice"))) %>
															<%=(String)(m.get("categoryName")) %>
															<br>
												<%
															if(m.get("categoryKind").equals("수입")) {
																totalCash = totalCash + (long)m.get("cashPrice");
																importCash = importCash + (long)m.get("cashPrice");
															} else if(m.get("categoryKind").equals("지출")) {
																totalCash = totalCash - (long)m.get("cashPrice");
																expenseCash = expenseCash - (long)m.get("cashPrice");
															}
														}
													}
												%>
											</div>
							<%
										}
							%>
									</td> <!-- 11월이면 1부터 30일까지 -->
							<%
									if(i%7 == 0 && i!=totalTd) {
							%>
										</tr><tr class="table-light">
							<%
									}
								}
							%>
							</tr>
						</table>
						<div class="p-2 container-fluid row d-flex justify-content-between">
							<div>
								<span class="text-info">수입 :  <%=numberFormat.format(importCash)%>원</span>
								<br>
								<span class="text-danger">지출 : <%=numberFormat.format(expenseCash) %>원</span>
							</div>
							<div class="text-end">
							<%
								if(totalCash < 0) {
							%>
									<span class="text-danger">월 누계 : <%=numberFormat.format(totalCash) %>원</span>
							<%
								} else {
							%>
									<span class="text-info">월 누계 : <%=numberFormat.format(totalCash) %>원</span>
							<%
								}
							%>
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