<%@page import="dao.CashDao"%>
<%@page import="vo.Member"%>
<%@page import="util.DBUtil"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	// Controller : session, request 요청
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
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

	Member loginMember = (Member)session.getAttribute("loginMember");

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCashListByDate(cashNo);
	String deleteMsg = null;
	
	if(row == 1) {
		deleteMsg = "삭제완료";
	} else {
		deleteMsg = "삭제실패";
	}
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	
%>