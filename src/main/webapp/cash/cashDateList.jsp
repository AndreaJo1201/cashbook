<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	// Controller : session, request 요청
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) { // 전달받은 메시지가 있을시 alter 출력
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
%>

<%
	Member loginMember = (Member)session.getAttribute("loginMember"); //session 값 get
	String memberId = loginMember.getMemberId(); // session에서 memberId 값 할당
	
	if(request.getParameter("year") == null ||
		request.getParameter("year").equals("") ||
		request.getParameter("month") == null ||
		request.getParameter("month").equals("") ||
		request.getParameter("date") == null ||
		request.getParameter("date").equals("")) { // 확인하려는 날짜를 알 수 없으므로 cashList 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
	//2) 모델 호출
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(memberId, year, month+1, date); //cashDateDao 참조
	int cashNo = 0;
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	long resultPrice = 0;
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cash Date List</title>
	</head>

	<body>
		<div>
			<h1>수입 지출 내역</h1>
			<span><%=year %>년 <%=month+1%>월 <%=date %>일</span>
		</div>
		
		<div>
			<table border="1">
				<tr>
					<th>수입/지출</th>
					<th>내역</th>
					<th>금액</th>
					<th>상세내역</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<tr>
				<%
					for (HashMap<String, Object> m : list) {
						if(m.get("categoryKind").equals("지출")) { // 총 수입, 지출값 계산
							resultPrice = resultPrice - ((Long)(m.get("cashPrice")));
						} else {
							resultPrice = resultPrice + ((Long)(m.get("cashPrice")));
						}
						int a = (Integer)m.get("cashNo");
						
				%>
						<td><%=(String)(m.get("categoryKind"))%></td>
						<td><%=(String)(m.get("categoryName"))%></td>
						<td>\<%=(Long)(m.get("cashPrice"))%></td>
						<td><%=(String)(m.get("cashMemo"))%></td>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)(m.get("cashNo"))%>">삭제</a></td>
						</tr><tr>
				<%
					}
				%>
				</tr>
				<tr>
					<td colspan="3">총 지출 :</td>
					<td colspan="3">\<%=resultPrice %></td>
				</tr>
			</table>
			
			<!-- 임시 인설트 폼 -->
			<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
				<table border="1">
					<tr>
						<td>수입/지출</td>
						<td>
							<select name="categoryNo">
							<%
								//category 목록 출력
								for(Category c : categoryList) {
							%>
									<option value="<%=c.getCategoryNo()%>">
										<%=c.getCategoryKind()%>/<%=c.getCategoryName()%>
									</option>
							<%
								}
							%>
							</select>
						</td>
					</tr>
						
					<tr>
						<td>cashDate</td>
						<%
							if(date < 10) {
						%>
								<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-0<%=date%>" readonly="readonly"></td>
						<%
							} else {
						%>
								<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
						<%
							}
						%>
					</tr>
					
					<tr>
						<td>cashMemo</td>
						<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
					</tr>
				</table>
				<button type="submit">입력</button>
			</form>
			
			
			<div>
				<a href="/cash/insert">내역 추가</a>
			</div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month%>">뒤로가기</a>
		</div>
		
		
	</body>
</html>