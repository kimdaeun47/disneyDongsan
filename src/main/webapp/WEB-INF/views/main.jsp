<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<title>웹 MVC 관련 예제</title>
		
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />
		<script type="text/javascript" src="/resources/js/jquery-3.7.0.min.js" ></script>
		<script type="text/javascript" src="/resources/dist/js/bootstrap.min.js" ></script>
		<script type="text/javascript">
			$(function(){
				$("#btn1").click(function(){
					$("#exam01Form").attr({
						method:"get",
						action:"/sample/exam01"
					});
					$("#exam01Form").submit();
				});
				$("#btn2").click(function(){
					$("#exam01Form").attr({
						method:"get",
						action:"/sample/exam02"
					});
					$("#exam01Form").submit();
				});
				$("#ceckBtn").click(function(){
					$("#exam02Form").attr({
						method:"get",
						action:"/sample/exam02Arrat"
					});
					$("#exam02Form").submit();
				});
				$("#exam02ListBtn").click(function(){
					$("#exam02ListForm").attr({
						method:"get",
						action:"/sample/exam02List"
					});
					$("#exam02ListForm").submit();
				});
				$("#btnBean").click(function(){
					$("#exam02BeanForm").attr({
						method:"get",
						action:"/sample/exam02Bean"
					});
					$("#exam02BeanForm").submit();
				});
				$("#btnBean03").click(function(){
					$("#exam03BeanForm").attr({
						method:"post",
						action:"/sample/exam02Bean2"
					});
					$("#exam03BeanForm").submit();
				});
				$("#btn03").click(function(){
					$("#exam03Form").attr({
						method:"post",
						action:"/sample/exam03"
					});
					$("#exam03Form").submit();
				});
				$("#jsonBtn").click(function(){
					$.ajax({
						type:"get",
						url: "/example/getExample",
						dataType:"json",
						error: function(xhr, textStatus, errorThrown){
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						},
						success:function(resultData){
							let no = resultData.no;
							let name = resultData.name;
							let phone = resultData.phone;
							
							let noLi = $("<li>").html(no);
							let nameLi = $("<li>").html(name);
							let phoneLi = $("<li>").html(phone);
							
							$("#dataArea").append(noLi).append(nameLi).append(phoneLi);
							
						}
					});
				});
				$("#listBtn").click(function(){
					$("#list").css("display", "block");
					$("#listData").empty();
					
					$.getJSON('/example/getList', function(data){
						$(data).each(function(){
							let no = this.no;
							let name = this.name;
							let phone = this.phone;
							
							let noTd = $("<td>").html(no);
							let nameTd = $("<td>").html(name);
							let phoneTd = $("<td>").html(phone);
							
							let tr = $("<tr>").append(noTd).append(nameTd).append(phoneTd);
							$("#listData").append(tr);
						});
					}).fail(function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					});
				});
			});
		</script>
	</head>
	<body>
		<div>
			<h1>웹 MVC 관련 예제</h1>
			<form id="exam01Form" class="form-inline">
				<h3>매개변수 처리예제</h3>
				<div>
					<input type="text" placeholder="이름을 입력하세요" id="name" name="name" />
					<input type="text" placeholder="나이를 입력하세요" id="age" name="age" />
					<button type="button" id="btn1">exam01 예제 확인</button>
					<button type="button" id="btn2">exam02 예제 확인</button>
				</div>
			</form>
			<form id="exam02Form">
				<div>
					<h3>매개변수 값을 배열(Array)처리 예제</h3>
					<div>
						<input type="checkbox"  name="hobby" value="여행" >여행</input>
						<input type="checkbox"  name="hobby" value="영화, 드라마 감상" >영화, 드라마 감상</input>
						<input type="checkbox"  name="hobby" value="운동" >운동</input>
						<input type="checkbox"  name="hobby" value="독서" >독서</input>
						<input type="checkbox"  name="hobby" value="맛집 탐방" >맛집 탐방</input>
						<button type="button" id= "ceckBtn">exam02Array 예제 확인</button>	
					</div>
				</div>
			</form>
			<h5>매개변수 값을 ArrayList 타입에 대입 예제</h5>
			<form id="exam02ListForm">
				<label class="checkbox-inline">
					<input type="checkbox" name="language" value="java" />java
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" name="language" value="jsp" />jsp
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" name="language" value="oracle" />oracle
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" name="language" value="spring" />"spring"
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" name="language" value="jquery" />jquery
				</label>
				<button type="button" id= "exam02ListBtn" class="btn btn-success">exam02ListBtn 예제 확인</button>	
			</form>
			<h5>SampleDTOList 값 처리 예제</h5>
			<Form id="exam02BeanForm">
				<input type="text" placeholder="이름을 입력" name="list[0].name" id="list[0].name" />
				<input type="text" placeholder="나이를 입력" name="list[0].age" id="list[0].age" /><br />
				<input type="text" placeholder="이름을 입력" name="list[1].name" id="list[1].name" />
				<input type="text" placeholder="나이를 입력" name="list[1].age" id="list[1].age" /><br />
				<input type="text" placeholder="이름을 입력" name="list[2].name" id="list[2].name" />
				<input type="text" placeholder="나이를 입력" name="list[2].age" id="list[2].age" />
				<button type="button" id="btnBean">exam02Bean 예제 확인</button>
			</Form>
			<h5>SampleDTOList 값 처리 예제</h5>
			<Form id="exam03BeanForm">
				<input type="text" placeholder="번호를 입력" name="list[0].no" id="no0" />
				<input type="text" placeholder="이름을 입력" name="list[0].name" id="name0" />
				<input type="text" placeholder="전화번호를 입력" name="list[0].phone" id="phone0" /><br />
				<input type="text" placeholder="번호를 입력" name="list[1].no" id="no1" />
				<input type="text" placeholder="이름을 입력" name="list[1].name" id="name1" />
				<input type="text" placeholder="전화번호를 입력" name="list[1].phone" id="phone1" /><br />
				<input type="text" placeholder="번호를 입력" name="list[2].no" id="no2" />
				<input type="text" placeholder="이름을 입력" name="list[2].name" id="name2" />
				<input type="text" placeholder="전화번호를 입력" name="list[2].phone" id="phone2" />
				<button type="button" id="btnBean03">exam03Bean 예제 확인</button>
			</Form>
			<h5>DTO와 일반 매개변수 값 처리 예제</h5>
			<Form id="exam03Form">
				<input type="text" placeholder="이름을 입력" name="name" id="name" />
				<input type="text" placeholder="나이를 입력" name="age" id="age" />
				<input type="text" placeholder="상품번호 입력" name="number" id="number" /><br />
				<button type="button" id="btn03">exam03 예제 확인</button>
			</Form>
			
			<h5>XML/JSON 값 요청 예제</h5>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(단순 문자열)</div>
				<div class="col-md-9"><a href="/example/getText">getText</a></div>
			</div>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(json-1)</div>
				<div class="col-md-9"><a href="/example/getExample">getExample</a></div>
			</div>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(xml)</div>
				<div class="col-md-9"><a href="/example/getExample2">getExample2</a></div>
			</div>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(xml-기본값)</div>
				<div class="col-md-9"><a href="/example/getExample3">getExample3</a></div>
			</div>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(json-List)</div>
				<div class="col-md-9"><a href="/example/getList">getList</a></div>
			</div>
			<div class="row">
				<div class="col-md-3">데이터로만 반환(json-Map)</div>
				<div class="col-md-9"><a href="/example/getMap">getMap</a></div>
			</div>
			<div>
				<h5>Ajax 요청</h5>
				<button type="button" id="jsonBtn">json 데이터 요청</button>
				<div id="dataArea"></div>
			</div>
			<div>
				<button type="button" id="listBtn">List 데이터 요청</button>
				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>핸드폰</th>
						</tr>
					</thead>
					<tbody id="listData"></tbody>
				</table>
			</div>

		</div>
	</body>
</html>