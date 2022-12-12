<%@page import="java.text.NumberFormat"%>
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
	
	if(request.getParameter("cashNo") == null ||
		request.getParameter("cashNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?"+year+"&month="+month+"&date="+date);
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	CashDao cashDao = new CashDao();
	Cash cashData = cashDao.selectUpdateCashData(cashNo);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	NumberFormat numberFormat = NumberFormat.getInstance();
	
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
		<title>세부 내역 수정</title>
	</head>

	<body>
		<div id="main-wrapper">
		
		<jsp:include page="/inc/header.jsp"></jsp:include>
			
			<div class="content-body">
				<div class="container-fluid table-responsive mt-2">
					<div class="container-fluid">
						<div class="card mt-2">
							<div class="card-body p-5 mt-4 text-dark">
								<h1>세부 내역 수정</h1>
							</div>
						</div>
					</div>
				
					<div class="table-reponsive container-fluid">
						<div class="mt-4">
							<div class="card">
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
										<table class="table table-bordered">
											<thead class="thead-light">
												<tr>
													<th colspan="2" class="text-center col-sm-12">수정 내역</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="text-center col-sm-1"><strong>분류</strong></td>
													<td class="text-start col-sm-11">
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
													<td class="text-center col-sm-1"><strong>일자</strong></td>
													<%
														if(date < 10) {
													%>
															<td class="text-start col-sm-11"><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-0<%=date%>" readonly="readonly"></td>
													<%
														} else {
													%>
															<td class="text-start col-sm-11"><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
													<%
														}
													%>
												</tr>
												
												<tr>
													<td class="text-center col-sm-1"><strong>금액</strong></td>
													<td class="text-start col-sm-11"><input type="text" name="cashPrice" value="<%=cashData.getCashPrice()%>" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1').replace(/^0[^.]/, '0');"></td>
												</tr>
												
												<tr>
													<td class="text-center col-sm-1"><strong>메모</strong></td>
													<td class="col-sm-11"><textarea name="cashMemo"><%=cashData.getCashMemo() %></textarea></td>
												</tr>
											</tbody>
										</table>
										<input type="hidden" name="cashNo" value="<%=cashData.getCashNo()%>">
										<input type="hidden" name="year" value="<%=year %>">
										<input type="hidden" name="month" value="<%=month %>">
										<input type="hidden" name="date" value="<%=date %>">
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
										<div class="d-grid">
											<button type="submit" class="btn btn-primary btn-block">업데이트</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div class="mt-2 p-2 text-end">
							<span><a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date %>" class="btn btn-sm btn-dark">뒤로가기</a></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>