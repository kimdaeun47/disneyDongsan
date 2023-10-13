<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
		<style type="text/css">
		.div1{
		  width: 1000px;
		  margin: auto;
		}
		.container #title {
			text-align:center;
			font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
			padding: 50px;
			}
		.dir{ 
		  display: flex;
		  justify-content: center;
		  margin: auto;
		  padding-bottom:30px;
		}
		.dir img{
		  margin: auto;
		  width: 1000px;
		}
		.dir_span ul {list-style-type: none;}
		.dir_span ul li{padding: 10px;}
		.dir_span{ display: inline-block;}
		
		.textColer1 {
		  padding: 3px;
		  font-size: 20px;
		  font-weight: 600;
		  color: #F9FFFF;
		  border: 2px solid #5AD2FF;
		  background-color: #B4E5FF;
		  border-radius: 20px;
		} 
		.textColer2 {

		  font-size: 20px;
		  font-weight: 600;
		  color: #4B73E1;
		}
		#title img{width: 150px; padding-left: 20px;}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="div1">
					<h1 id="title">오시는 길<img alt="이미지 파일" src="/resources/images/facilityInfo/mickey.PNG" /></h1>
				<div class='dir'>
					<img src="/resources/images/facilityInfo/map10.PNG" alt="이미지 파일" />
				</div>
				<div class='dir_span'>
					<h3>디즈니 동산(경기도 안산시 상록구 충장로 98)</h3>
					<h4>
						<img alt="이미지 파일" src="/resources/images/facilityInfo/subway.PNG">
						지하철 이용시
					</h4>
					<ul>
						<li><span class="textColer2"> 수인분당선 </span>사리역 1번 출구</li>
					</ul>
					<h4>
						<img alt="이미지 파일" src="/resources/images/facilityInfo/bus.PNG">
						버스 이용시
					</h4>
					<ul>
						<li><span class="textColer2"> 지선 </span>101번, 52번, 61번, 21번</li>
						<li><span class="textColer2"> 광역 </span>1007번, 1100번, 1700번</li>
					</ul>
				</div>
			</div>
		</div>
	
	</body>
</html>