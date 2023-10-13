<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
      
      <title>noticeDetail</title>
      
      <link rel="shortcut icon" href="/resources/image/icon.png" />
      <link rel="apple-touch-icon" href="/resources/image/icon.png" />
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
      
      <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css"/>
      <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
      
      <script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
      <script type="text/javascript" src="/resources/include/js/common.js"></script>
      <script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
      
      <link rel="stylesheet" href="/resources/include/css/commonDetail.css"/>
      
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <style type="text/css">
      	.n_content{
      		text-align: center;
      	}
      	.head{
      		float:none;
      	}
      	.clear{
      		clear: both;
      	}
      	.event_btn{
      		margin-top: 20px;
      	}
      	
      	h1{margin-top: 70px; margin-bottom: 10px;}
      	
      	.content{margin-top: 30px; margin-bottom: 10px; padding: 35px; }
      	.notice-header > img {width: 350px; height: 60px; padding: 0; margin: 0;}
      	
      	.prevNext{padding: 30px;}
      	.prevNext a {text-decoration: none; color:gray; margin-left: 30px;}
      	.prevNext p {margin-left: 40px;}
      	
      	.notice-title{font-size: 30px; padding: 0; font-weight: bold; margin: 0;}
      	.notice-content{margin-top: 30px; text-align:center;}

      	
      	.text-left{text-align: left;}
      	.text-right{text-align: right;}
      	.text-center{text-align: center;}
      	
      </style>
      
      <script type="text/javascript">
      	// 목록 버튼 처리
      	$(function(){
      		$("#listBtn").click(function(){
				location.href="/notice/noticeView";
			})
      	})
      	
      </script>
      
   </head>
   <body>
   		<div class="container">
   			<form name="f_data" id="f_data">
	        	<input type="hidden" name="n_num" value="${detail.n_num}" />
	        </form>
	   		
<!-- 	           <div class="text-center head"><h1><strong>공지 사항</strong></h1></div> -->
	           
	            
	           <div class="content">
	           		<div class="notice-header">
	           			<img src="/resources/images/notice_header.jpg"/>
	           			<div class="notice-title">${detail.n_title }</div>
	           			<div class="notice-date">${detail.n_date }</div>
	           			<hr/>
	           		</div>
	           		<div class="notice-body">
	           			<div class="notice-content">${detail.n_content }</div>
	           		</div>
	           </div>
	           
	           
	           
<!-- 		       <div class="contentTB text-center"> -->
<!-- 		         <table class="table table-bordered"> -->
		         	
<!-- 		            <tbody> -->
<!-- 		               <tr> -->
<%-- 		                  <td class="col-md-8 text-left">${detail.n_title}</td> --%>
<!-- 		               </tr> -->
<!-- 		               <tr> -->
<%-- 		                  <td class="col-md-3 text-left">${detail.n_date}</td> --%>
<!-- 		               </tr> -->
<!-- 		               <tr class="table-tr-height"> -->
<%-- 		                  <td class="col-md-8 text-left">${detail.n_content}</td> --%>
<!-- 		               </tr> -->
<!-- 		            </tbody> -->
<!-- 		         </table> -->
<!-- 		      </div> -->
		  <br/><br/>
		  <div class="prevNext">
		       <hr />
		        <c:choose>
			        <c:when test="${prevNext.prevNum ne 0}">
			            <p>이전글 <a href="/notice/noticeDetail?n_num=${prevNext.prevNum}">${prevNext.prevTitle}</a></p>
			        </c:when>
			        <c:otherwise>
			            <p>이전글이 없습니다.</p>
			        </c:otherwise>
			    </c:choose>
			    <hr />
			    <c:choose>
			        <c:when test="${prevNext.nextNum ne 0}">
			            <p>다음글 <a href="/notice/noticeDetail?n_num=${prevNext.nextNum}">${prevNext.nextTitle}</a></p>
			        </c:when>
			        <c:otherwise>
			            <p>다음글이 없습니다.</p>
			        </c:otherwise>
			    </c:choose>
	            <hr />
	        </div>
           
           <div class='text-center'>
                <button type="button" id="listBtn" class="btn sty_btn">목록</button>
           </div>
        </div>
   </body>
</html>