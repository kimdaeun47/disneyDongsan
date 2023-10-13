<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

	
	<style>
		#item-template{display:none;}
		.panel-success{
			background-color: #f1f3f5;
			border: 1px solid black;
			height: 100px;
		}
		
		.image{
			float: left;
			width: 100px;
			height: 100px;
			object-fit: cover;
		}
		.panel-heading img{
			object-fit: cover;
			width: 97px;
			height: 97px;
		}
		
		.reviewList{
         background-color: #f1f3f5;
         border: 1px solid black;
         height: 100px;
         display : flex;
		  justify-content : center;
		  align-items : center;
         
      }
		
	</style>
	<script type="text/javascript">
		$(function(){
			/* 기본 덧글 목록 불러오기 */
			let g_id = ${detail.g_id};
			listAll(g_id);
			
			
		});
		
		function listAll(g_id){
	         $(".reply").detach();
	         let url = "/goods/all/"+g_id;
	         
	         $.getJSON(url, function(data){
	            let hasReviews = false;
	            
	            $(data).each(function(index){
	                  
	               let re_id = this.re_id;
	               let r_member_id = this.r_member_id;
	               let re_content = this.re_content;
	               let re_date = this.re_date;
	               let re_image = this.re_image;
	               re_content = re_content.replace(/(\r\n|\r|\n)/g, "<br />");
	                  
	               template(re_id, r_member_id, re_content, re_date, re_image);
	               
	               if(re_id){
	                  hasReviews = true;
	               }
	            });
	            
	            if(!hasReviews){
	               $("#reviewList").html("<h3> 등록된 리뷰가 없습니다 </h3>");
	            }
	            
	         }).fail(function(jqXHR, textStatus, errorThrown){
	            console.error("덧글 목록 불러오기 실패: " + textStatus, errorThrown);
	            alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
	         });
	      }
		
		function template(re_id, r_member_id, re_content, re_date, re_image){
			let $div = $('#reviewList');
			
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-num", re_id);
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .name').html("  " + r_member_id);
			$element.find('.panel-heading > .panel-title > .date').html(" / " + re_date);


			let $imageElement = $element.find('.panel-heading > .panel-title > .image');
		    $imageElement.html(""); // 기존 내용을 지우고 이미지를 추가합니다.
		    let $image = $('<img>').attr('src', "/dongsanStorage/goods/" + re_image);
		    $image.click(function() {
		        window.open($(this).attr('src'), '_blank');
		      });
		    
		    $imageElement.append($image);
			
			
			
			$element.find('.panel-body').html(re_content);
			
			$div.append($element);
		}
		
		
		
	</script>
	</head>
	<body>
	
		<div id="myModal" class="modal">
		  <span class="close">&times;</span>
		  <img class="modal-content" id="modalImage">
		</div>
	
		<%-- 리스트 영역 --%>
		<div id="reviewList" class="reviewList">
			<div id="item-template" class="panel panel-success">
				<div class="panel-heading">
					<h5 class="panel-title">
						<span class="image"></span>
						<span class="name"></span>
						<span class="date"></span>
						
					</h5>
				</div>
				<div class="panel-body"></div>
			</div>	
		</div>
		
	
		
		
		
		
		
		
		
		
	</body>
</html>