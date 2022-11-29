<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%

%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>DELETE</title>
		
		<style>
			#update {
			  height: 100px;
			  width: 500px;
			  margin: auto;
			  text-align: center;
			}
		</style>
	</head>

	<body>
	<div class="container">
		<div class="mt-2 p-2 text-end">
			<span><a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-sm btn-dark">뒤로가기</a></span>
		</div>
		<div class="container" id="update">
			<div class="mt-4 p-4 text-dark">
				<h1><label>회원탈퇴</label></h1>
			</div>
			<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
				<table class="table table-bordered">
					<tr>
						<td><label>ID 확인</label></td>
						<td><input type="text" name ="memberId"></td>
					</tr>
					<tr>
						<td><label>비밀번호</label></td>
						<td><input type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td><label>비밀번호 확인</label></td>
						<td><input type="password" name="memberPwCheck"></td>
					</tr>
				</table>
				<div class="d-grid">
					<button type="submit" class="btn btn-danger btn-lg btn-block">탈퇴</button>
				</div>
			</form>
		</div>
	</div>	
	</body>
</html>