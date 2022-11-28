<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "dao.*" %>

<%	
	// Controller : session, request 요청
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
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
	
	/*************************************************************************************************************/
	
	//model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMont(year, month+1, memberId); // cashDao.java 참조
	
	
	/*************************************************************************************************************/
	//View : 달력출력 + 일별 cash 목록
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>CASH_LIST</title>
	</head>

	<body>
		<div class="container">
			<!-- 로그인 정보(세션 -> loginMember 변수) 출력 -->
			<div class="row mt-2 p-2">
				<div class="text-start col-sm-6">
					<span><%=loginMember.getMemberName() %>님 반갑습니다.</span>
				</div>
				<div class="text-end col-sm-6">
					<span><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="btn btn-primary text-light btn-sm">회원정보 수정</a></span>
					<span><a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp" class="btn btn-primary text-light btn-sm">비밀번호 수정</a></span>
					<span><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp" class="btn btn-danger btn-sm">회원 탈퇴</a></span>
				</div>
			</div>
		</div>
		<div class="container">
			<table class="table table-bordered">
				<tr class="text-center">
					<th colspan="7">
						<span class="col-sm-5"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-success btn-sm">&#8701; 이전달</a></span>
						<span class="col-sm-2"><%=year %>년 <%=month+1 %>월</span>
						<span class="col-sm-5"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-success btn-sm">다음달 &#8702;</a></span>
					</th>
				</tr>
				<tr>
					<th class="text-danger"><label>일</label></th>
					<th><label>월</label></th>
					<th><label>화</label></th>
					<th><label>수</label></th>
					<th><label>목</label></th>
					<th><label>금</label></th>
					<th class="text-primary">토</th>
				</tr>
				
				<tr>
				<!-- 달력 -->
				<%
					for(int i=1; i<=totalTd; i++) {
				%>
						<td>
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
									<label>
									<%
										for(HashMap<String, Object> m : list) {
											String cashDate = (String)(m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(8)) == date) {
									%>
												[<%=(String)(m.get("categoryKind")) %>]
												\<%=(Long)(m.get("cashPrice")) %>
												<%=(String)(m.get("categoryName")) %>
												<br>
									<%
												if(m.get("categoryKind").equals("수입")) {
													totalCash = totalCash + (Long)m.get("cashPrice");
													importCash = importCash + (Long)m.get("cashPrice");
												} else if(m.get("categoryKind").equals("지출")) {
													totalCash = totalCash - (Long)m.get("cashPrice");
													expenseCash = expenseCash - (Long)m.get("cashPrice");
												}
											}
										}
									%>
									</label>
								</div>
				<%
							}
				%>
						</td> <!-- 11월이면 1부터 30일까지 -->
				<%
						if(i%7 == 0 && i!=totalTd) {
				%>
							</tr><tr>
				<%
						}
					}
				%>
				</tr>
			</table>
			<div class="p-2">
				<div>
					<span class="text-info">수입 누계 : <%=importCash %>원</span>
					<span class="text-danger">지출 누계 : <%=expenseCash %>원</span>
				</div>
				<%
					if(totalCash < 0) {
				%>
						<span class="text-danger">월 누계 : <%=totalCash %>원</span>
				<%
					} else {
				%>
						<span class="text-info">월 누계 : <%=totalCash %>원</span>
				<%
					}
				%>
				
			</div>
			<div class="container row p-1">
				<div class="text-start col-sm-6">
					<a href="<%=request.getContextPath()%>/logout.jsp" class="btn-dark btn btn-sm">로그아웃</a>
				</div>
				<%
					if(loginMember.getMemberLevel() > 0) {
				%>
						<div class="text-end col-sm-6">
							<a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="btn-dark btn btn-sm text-end">관리자 페이지</a>
						</div>
				<%
					}
				%>
			</div>
		</div>
	</body>
</html>