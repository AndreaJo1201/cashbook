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
		<meta charset="UTF-8">
		<title>CASH_LIST</title>
	</head>

	<body>
		<div>
			<!-- 로그인 정보(세션 -> loginMember 변수) 출력 -->
			<span>ID : <%=loginMember.getMemberId() %> / Name : <%=loginMember.getMemberName() %>님 반갑습니다.</span>
			<br>
			<span><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a></span>
			<br>
			<span><a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 수정</a></span>
			<br>
			<span><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원 탈퇴</a></span>
			<div>
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달</a>
								      
				<%=year%>년 <%=month+1%> 월
								      
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">다음달&#8702;</a>
			</div>
			<span><%=month+1 %>월,<%=year %>년</span>
		</div>
		<div>
			<table border="1">
				<tr>
					<th colspan="7"><%=year %>년 <%=month+1 %>월</th>
				</tr>
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
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
									<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">
										<%=date %>
									</a>
								</div>
								<div>
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
							</tr><tr>
				<%
						}
					}
				%>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			<div>
			<%
				if(loginMember.getMemberLevel() > 0) {
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
			<%
				}
			%>
			</div>
		</div>
	</body>
</html>