<%@page import="java.util.HashMap"%>
<%@page import="dao.HelpDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	int beginRow = 0;
	int rowPerPage = 5;
	
	
	//Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	//최근 공지사항 5개, 최근 가입한 멤버 5명
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	ArrayList<HashMap<String,Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>MainByAdmin</title>
		
		<style>
			.leftcolumn {
				float:left;
				width:75%
			}
			
			.rightcolumn {
				float: left;
				width: 25%;
				padding-left: 20px;
			}
			
			th {
				vertical-align: middle;
				text-align: cneter;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1>INDEX</h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="row mt-2 p-2">
			<!-- adminMain contents... -->
			<!-- 최근 공지 5,ㅡ 최근 가입 멤버 5 -->
			<div class="leftcolumn">
				<table class="table table-bordered text-center">
					<tr>
						<th colspan="3"><label>최신 공지사항</label></th>
					</tr>
					<tr>
						<%
							for(Notice n : noticeList) {
						%>
									<td><label><%=n.getNoticeNo() %></label></td>
									<td><label><%=n.getNoticeMemo() %></label></td>
									<td><label><%=n.getCreatedate() %></label></td>
								</tr><tr>
						<%
							}
						%>
					</tr>
				</table>
			</div>
			
			<div class="rightcolumn">
				<table class="table table-bordered text-center">
					<tr>
						<th colspan="3"><label>신규 가입회원</label></th>
					</tr>
					<tr>
						<%
							for(Member m : memberList) {
						%>
									<td><label><%=m.getMemberNo() %></label></td>
									<td><label><%=m.getMemberName() %></label></td>
									<td><label><%=m.getCreatedate() %></label></td>
								</tr><tr>
						<%
							}
						%>
					</tr>
				</table>
			</div>
		</div>
		
		<div class="leftcolumn">
			<table class="table table-bordered text-center">
				<tr>
					<th colspan="3"><label>신규 문의사항</label></th>
				</tr>
				<tr>
					<%
						for(HashMap<String,Object> h : helpList) {
					%>
								<td class="col-sm-1"><label><%=h.get("helpNo") %></label></td>
								<td class="col-sm-8"><label><%=h.get("helpMemo") %></label></td>
								<td class="col-sm-3"><label><%=h.get("helpCreateDate") %></label></td>
							</tr><tr>
					<%
						}
					%>
				</tr>
			</table>
		</div>
	</div>	
	</body>
</html>