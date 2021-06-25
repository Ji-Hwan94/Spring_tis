<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Logout Page</h1>
	<form action="customLogout" method="post">
		<!-- csrf 공격을 막기 위한 hidden 테그 (post와 ajax 방식일때는 필수로 사용한다.) -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<button>로그아웃</button>
	</form>
	
	
</body>
</html>