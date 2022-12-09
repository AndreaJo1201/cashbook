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
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<style>	
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
	<div class="main-wrapper">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		
		<div class="content-body">
			<div class="container-fliud table-reponsive mt-2">
				<div class="container-fluid">
					<div class="mt-2 card" >
						<div class="card-body p-5 mt-4 text-dark">
							<span class="h1">수입 지출 내역</span>
							<p><%=year %>년 <%=month+1%>월 <%=date %>일</p>
						</div>
					</div>
				</div>
				
				<div class="table-reponsive container-fluid">
					<div class="card">
						<div class="card-body">
						<!-- 임시 인설트 폼 -->
							<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
								<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
								<input type="hidden" name="year" value="<%=year %>">
								<input type="hidden" name="month" value="<%=month %>">
								<input type="hidden" name="date" value="<%=date %>">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th colspan="2" class="text-center">내역 추가</th>
										</tr>
									</thead>
									<tbody>
										<tr class="table-light">
											<td class="text-center col-sm-1 center_middle"><strong>분류</strong></td>
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
											
										<tr class="table-light">
											<td class="text-center col-sm-1 center_middle"><strong>일자</strong></td>
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
										
										<tr class="table-light">
											<td class="col-sm-1 text-center center_middle"><strong>금액</strong></td>
											<td class="col-sm-11"><input type="text" name="cashPrice" placeholder="단위 : 원(₩)" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1').replace(/^0[^.]/, '0');"></td>
										</tr>
										
										<tr class="table-light">
											<td class="col-sm-1 text-center center_middle"><strong>메모</strong></td>
											<td class="col-sm-11"><textarea name="cashMemo" placeholder="세부 사항을 적어주세요."></textarea></td>
										</tr>
									</tbody>
								</table>
								<div class="d-grid bg-light">
				                   <%
				             	      	if(request.getParameter("msg") != null) {
				                   %>
				               	    		<div class="alert alert-danger mt-1 alert-dismissible">
				              	     			<%=request.getParameter("msg") %>
				             	      			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				           	        		</div>
				                   <%
				                   		}
				                   %>
									<button type="submit" class="btn btn-primary">입력</button>
								</div>
							</form>
						</div>
					</div>
					<%
		             	if(request.getParameter("msg") != null) {
		             %>
		             		<div class="alert alert-danger mt-1 alert-dismissible">
		             			<%=request.getParameter("msg") %>
		             			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
		             		</div>
		             <%
		             	}
		             %>
					<div class="card">
						<div class="card-body">
							<div class="mt-4">
								<table class="table table-bordered table-hover">
									<thead class="thead-light">
										<tr>
											<th colspan="6" class="text-center">상세 내역</th>
										</tr>
										<tr>
											<td class="col-sm-1 text-center"><strong>분류</strong></td>
											<td class="col-sm-1 text-center"><strong>사용내역</strong></td>
											<td class="col-sm-1 text-center"><strong>금액</strong></td>
											<td class="col-sm-7 text-center"><strong>메모</strong></td>
											<td class="col-sm-1 text-center"><strong>수정</strong></td>
											<td class="col-sm-1 text-center"><strong>삭제</strong></td>
										</tr>
									</thead>
									<tbody>
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
												<td class="col-sm-1 text-center center_middle">₩<%=numberFormat.format((Long)(m.get("cashPrice")))%></td>
												<td class="col-sm-7"><%=(String)(m.get("cashMemo"))%></td>
												<td class="col-sm-1 text-center center_middle"><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=m.get("cashNo")%>" class="btn btn-primary btn-sm">수정</a></td>
												<td class="col-sm-1 text-center center_middle"><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=(Integer)(m.get("cashNo"))%>" class="btn btn-danger btn-sm">삭제</a></td>
												</tr><tr>
										<%
											}
										%>
										</tr>
										<tr>
											<td colspan="1" class="col-sm-1 text-center"><strong>누계</strong></td>
											<td colspan="5" class="col-sm-11">₩&nbsp;<%=numberFormat.format(resultPrice) %></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="container-fluid">
					<div class="d-flex justify-content-end">
						<span><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month%>" class="btn btn-sm btn-dark">뒤로가기</a></span>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
	</body>
</html>