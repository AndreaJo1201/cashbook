<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

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
%>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	String date = request.getParameter("date");
	
	if(request.getParameter("year") == null ||
		request.getParameter("year").equals("") ||
		request.getParameter("month") == null ||
		request.getParameter("month").equals("") ||
		request.getParameter("date") == null ||
		request.getParameter("date").equals("")) { 
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
	}
	
	CashDateDao cashDateDao = new CashDateDao();
	ArrayList<HashMap<String, Object>> list = cashDateDao.selectCashDateList(year, month+1, date, memberId);
	
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
				</tr>
				<tr>
				<%
					for (HashMap<String, Object> m : list) {
						if(m.get("categoryKind").equals("지출")) {
							resultPrice = resultPrice - ((Long)(m.get("cashPrice")));
						} else {
							resultPrice = resultPrice + ((Long)(m.get("cashPrice")));
						}
				%>
						<td><%=(String)(m.get("categoryKind"))%></td>
						<td><%=(String)(m.get("categoryName"))%></td>
						<td>\<%=(Long)(m.get("cashPrice"))%></td>
						<td><%=(String)(m.get("cashMemo"))%></td>
						</tr><tr>
				<%
					}
				%>
				</tr>
				<tr>
					<td colspan="2">총 지출 :</td>
					<td colspan="2">\<%=resultPrice %></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year<%=year%>&month=<%=month%>">뒤로가기</a>
		</div>
		
		
	</body>
</html>