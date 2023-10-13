<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title><tiles:getAsString name="title"/></title>
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />
<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
<link rel="stylesheet"
	href="${path}/resources/include/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="${path}/resources/include/css/main.css" />
<link rel="stylesheet" href="/resources/include/css/header.css" />
<link rel="stylesheet" href="/resources/include/css/Remypage.css" />
<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>

</head>
<body>
	<div class="divBody">
		
			<!-- 헤더 -->
			<div id="header">
				<tiles:insertAttribute name="mypage_header" />
			</div>
	


		<div class="mypage-body">
			
			<tiles:insertAttribute name="mypage_sidebar" />
			<!-- 바디 -->
			<div class="mypage_div col-9">
					<tiles:insertAttribute name="body"/>
			</div>
			<!-- 바디 끝 -->

		</div>
		
		<div class="footer">
			<footer
				class="d-flex flex-wrap justify-content-between align-items-center py-3  border-top">
				<tiles:insertAttribute name="footer" />
			</footer>
		</div>
	</div>

</body>
</html>