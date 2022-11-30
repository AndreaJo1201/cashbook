<%@page import="java.text.NumberFormat"%>
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
	
	NumberFormat numberFormat = NumberFormat.getInstance();
	
	
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
			
			.center_middle {
				vertical-align: middle;
				text-align: cneter;
			}
		</style>
		<title>Cash_Date_List</title>
	</head>

	<body>
		<div class="container">
			<jsp:include page="/inc/header.jsp"></jsp:include>
		</div>
		<div class="container">
			<div class="mt-4 p-5 text-dark bg-light rounded" >
				<h1><label>수입 지출 내역</label></h1>
				<p><label><%=year %>년 <%=month+1%>월 <%=date %>일</label></p>
			</div>
			
			<div class="mt-2">		
				<!-- 임시 인설트 폼 -->
				<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
					<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
					<input type="hidden" name="year" value="<%=year %>">
					<input type="hidden" name="month" value="<%=month %>">
					<input type="hidden" name="date" value="<%=date %>">
					<table class="table table-bordered">
						<tr class="bg-dark text-light">
							<th colspan="2" class="text-center">내역 추가</th>
						</tr>
						<tr>
							<td class="text-center col-sm-1 center_middle">분류</td>
							<td class="col-sm-11">
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
							<td class="text-center col-sm-1 center_middle">일자</td>
							<%
								if(month+1 < 10) {
									if(date < 10) {
							%>
										<td class="col-sm-11"><input type="text" name="cashDate" value="<%=year%>-0<%=month+1%>-0<%=date%>" readonly="readonly"></td>
							<%
									} else {
							%>
										<td class="col-sm-11"><input type="text" name="cashDate" value="<%=year%>-0<%=month+1%>-<%=date%>" readonly="readonly"></td>
							<%
									}
								} else {
									if(date < 10) {
							%>
										<td class="col-sm-11"><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-0<%=date%>" readonly="readonly"></td>
							<%
									} else {
							%>
										<td class="col-sm-11"><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
							<%
									}
								}
							%>
						</tr>
						
						<tr>
							<td class="col-sm-1 text-center center_middle">금액</td>
							<td class="col-sm-11"><input type="text" name="cashPrice" placeholder="단위 : 원(\)"></td>
						</tr>
						
						<tr>
							<td class="col-sm-1 text-center center_middle">메모</td>
							<td class="col-sm-11"><textarea name="cashMemo" placeholder="세부 사항을 적어주세요."></textarea></td>
						</tr>
					</table>
					<div class="d-grid">
						<button type="submit" class="btn btn-success">입력</button>
					</div>
				</form>
				
				<div class="mt-4">
					<table class="table table-bordered table-hover">
						<tr>
							<th colspan="6" class="text-center bg-dark text-light"><label>상세 내역</label></th>
						</tr>
						<tr>
							<th class="col-sm-1 text-center">분류</th>
							<th class="col-sm-1 text-center">사용내역</th>
							<th class="col-sm-1 text-center">금액</th>
							<th class="col-sm-7 text-center">메모</th>
							<th class="col-sm-1 text-center">수정</th>
							<th class="col-sm-1 text-center">삭제</th>
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
								<td class="col-sm-1 text-center center_middle"><%=(String)(m.get("categoryKind"))%></td>
								<td class="col-sm-1 text-center center_middle"><%=(String)(m.get("categoryName"))%></td>
								<td class="col-sm-1 text-center center_middle">\<%=numberFormat.format((Long)(m.get("cashPrice")))%></td>
								<td class="col-sm-7"><%=(String)(m.get("cashMemo"))%></td>
								<td class="col-sm-1 text-center center_middle"><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>" class="btn btn-primary btn-sm">수정</a></td>
								<td class="col-sm-1 text-center center_middle"><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)(m.get("cashNo"))%>" class="btn btn-danger btn-sm">삭제</a></td>
								</tr><tr>
						<%
							}
						%>
						</tr>
						<tr>
							<td colspan="1" class="col-sm-1 text-center">누계</td>
							<td colspan="5" class="col-sm-11">\<%=numberFormat.format(resultPrice) %></td>
						</tr>
					</table>
				</div>
	
			</div>
			<div class="mt-2 p-2 text-end">
				<span><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month%>" class="btn btn-sm btn-dark">뒤로가기</a></span>
			</div>
		</div>	
	</body>
</html>