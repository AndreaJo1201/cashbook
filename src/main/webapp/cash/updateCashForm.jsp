<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%	

	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember"); //session 값 get
	String memberId = loginMember.getMemberId(); // session에서 memberId 값 할당
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("year") == null ||
		request.getParameter("year").equals("") ||
		request.getParameter("month") == null ||
		request.getParameter("month").equals("") ||
		request.getParameter("date") == null ||
		request.getParameter("date").equals("")) { // 확인하려는 날짜를 알 수 없으므로 cashList 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
	}
	
	CashDao cashDao = new CashDao();
	Cash cashData = cashDao.selectUpdateCashData(cashNo);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			#login {
			  height: 100px;
			  width: 500px;
			  margin: auto;
			  text-align: center;
			}
			
			textarea {
				width:100%;
				height: 100px;
				resize: none;
			}
		</style>
		<title>Insert title here</title>
	</head>

	<body>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
			<table border="1">
			
				<tr>
					<td>수입지출</td>
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
					<td>cash_date</td>
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
					<td>금액</td>
					<td><input type="text" name="cashPrice" value="<%=cashData.getCashPrice()%>"></td>
				</tr>
				
				<tr>
					<td>상세 내용</td>
					<td><textarea name="cashMemo"><%=cashData.getCashMemo() %></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="cashNo" value="<%=cashData.getCashNo()%>">
			<button type="submit">업데이트</button>
		</form>
		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">뒤로가기</a>
	</body>
</html>