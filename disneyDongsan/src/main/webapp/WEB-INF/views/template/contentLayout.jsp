<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<link rel="stylesheet" href="/resources/include/css/main.css" />
<link href="/resources/include/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css" />
<script type="text/javascript">
	// Add your JavaScript logic here if needed
</script>
<script src="/resources/include/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

	<div>
		<!-- 헤더 -->
		<div class="header">
			<tiles:insertAttribute name="header" />
		</div>

		<div>
			<tiles:insertAttribute name="body"/>
		</div>

		<!-- 풋터 -->
		<div class="container">
			<footer
				class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
				<tiles:insertAttribute name="footer" />
			</footer>
		</div>
	</div>
</body>
</html>