<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="vo.*" %>
<%@ page import="dao.*" %>

<%
	//categoryNo, memberID, cashDate, cashPrice, cashMemo를 받아서 저장
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("categoryNo") == null ||
	request.getParameter("categoryNo").equals("") ||
	request.getParameter("memberId") == null ||
	request.getParameter("memberId").equals("") ||
	request.getParameter("cashDate") == null ||
	request.getParameter("cashDate").equals("") ||
	request.getParameter("cashPrice") == null ||
	request.getParameter("cashPrice").equals("") ||
	request.getParameter("cashMemo") == null ||
	request.getParameter("cashMemo").equals("")) {
		String msg = "빈칸을 입력해주세요.";
		response.sendRedirect(request.getContextPath()+"/member/cashDateList.jsp?year="+request.getParameter("year")+"&month="+request.getParameter("month")+"&date="+request.getParameter("date"));
		return;
	}
	
	Cash insertCash = new Cash();
	insertCash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	insertCash.setMemberId(request.getParameter("memberId"));
	insertCash.setCashDate(request.getParameter("cashDate"));
	insertCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	insertCash.setCashMemo(request.getParameter("cashMemo"));
	
	System.out.println(insertCash.getCategoryNo());
	
	CashDao cashDao = new CashDao();
	int insertCashList = cashDao.insertCashListByDate(insertCash);
	
	if(insertCashList == 0) {
		System.out.println("INSERT 실패, 에러");
		String msg = "내역 저장 실패";
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+request.getParameter("year")+"&month="+request.getParameter("month")+"&date="+request.getParameter("date")+"&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	} else {
		System.out.println("INSERT 성공");
		String msg = "내역 저장 성공";
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?year="+request.getParameter("year")+"&month="+request.getParameter("month")+"&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

%>