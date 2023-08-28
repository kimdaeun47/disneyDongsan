<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="text-center"><h5>학과테이블 등록</h5></div>
<form id="insertForm" name="insertForm" class="form-horizontal">
	<input type="hidden" id="sno" name="no" value="0" />
	
	<table class="table table-striped">
		<tbody>
			<tr>
				<td>학과번호</td>
				<td class="text-left">
					<input type="text" class="firm-control" name="s_num" id="s_num" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>학과명</td>
				<td class="text-left">
					<input type="text" class="firm-control" name="s_name" id="s_name" placeholder="학과명 입력" maxlength="10"/>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="text-right">
		<button type="button" class="btn btn-default" id="insertBtn">학과정보등록</button>
		<button type="button" class="btn btn-default" id="cencelBtn">다시입력</button>
	</div>
</form>

