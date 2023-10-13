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
      
      <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css"/>
      <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
      <link rel="stylesheet" href="/resources/include/css/commonList.css">
      
      <script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
      <script type="text/javascript" src="/resources/include/js/common.js"></script>
      <script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
      
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
      
      <link rel="stylesheet" href="/resources/include/css/commonDetail.css"/>
      	
      
      <script type="text/javascript">
      	$(function(){
      		let errorMsg = "${errorMsg}";
      		if(errorMsg != ''){
      			alert(errorMsg);
      			errorMsg = '';
      		};
      		
      		//var n_num = ${detail.n_num};
      		
      		$("#updateFormBtn").click(function(){
      			$("#f_data").attr({
      				"method":"get",
      				"action":"/admin/notice/noticeUpdateForm"
      			});
      			$("#f_data").submit();
      		});
      		
      		
      		$("#noticeDeleteBtn").click(function(){
      	        if(confirm("삭제하시겠습니까?")){
      	        	
      	        	$("#f_data").attr({
    	        		"method":"post",
    	        		"action":"/admin/notice/noticeDelete"
    	        	});
    	        	$("#f_data").submit();
    	        	
      	            /* $.ajax({
      	                type: "POST",
      	                url: "/admin/notice/noticeDelete",
      	                data: $("#f_data").serialize(),
      	                success: function(response) {
      	                    if (response === "success") {
      	                        alert("삭제되었습니다.");
      	                    } else {
      	                        alert("삭제에 실패했습니다.");
      	                    }
      	                },
      	                error: function() {
      	                    alert("삭제에 실패했습니다.");
      	                }
      	            }); */
      	        }
      	    });
      		
      	})// $ 종료
      </script>
      
   </head>
   <body>
   		<div class="contentContainer container">
	   		<form name="f_data" id="f_data">
	        	<input type="hidden" id="n_num" name="n_num" value="${detail.n_num}" />
	        </form>	
   			<div class="contentTB text-center">
   			
	         <table class="table table-bordered detailTable">
	         	<colgroup>
                   <col width="20%" />
                   <col width="80%" />
                </colgroup>
	            <tbody>
	               <tr>
	                  <td>제목</td>
	                  <td colspan="3" class="text-left">${detail.n_title}</td>
	               </tr>
	               <tr>
	                  <td>작성일</td>
	                  <td colspan="3" class="text-left">${detail.n_date}</td>
	               </tr>
	               <tr class="table-tr-height">
	                  <td>내용</td>
	                  <td colspan="3" class="text-left">${detail.n_content}</td>
	               </tr>
	            </tbody>
	         </table>
	          
	          <div class="text-right">
	            	<input type="button" value="수정" id="updateFormBtn" class="btn sty_btn" />
	            	<input type="button" value="삭제" id="noticeDeleteBtn" class="btn sty_btn" />
	          </div>
          </div>
   		</div>
   
   </body>
</html>