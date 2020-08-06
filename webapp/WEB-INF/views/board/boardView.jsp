<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<table class="table table-bordered">
	<tbody>
		<tr>
			<td>${board.bo_title }</td>
			<td>조회수 : ${board.bo_hit }</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td>${board.bo_writer }(${board.bo_ip })</td>
			<td>${board.bo_date }</td>
		</tr>
		<tr>
			<td colspan="2">
			<form id="delForm" method="post">
			<input type="hidden" name="bo_pass" id="bo_pass"/>
			<input type="hidden" name="_method" value="delete"/>
			<input type="hidden" name="bo_no" value="${board.bo_no }"/>
				<c:forEach items="${board.attatchList }" var="attatch" varStatus="vs">
					<input type="hidden" id="delAtt" name="deleteAttatches" value="${attatch.att_no }">
					<a href="<c:url value='/board/file/${attatch.att_no }'/>">${attatch.att_filename }</a> ${not vs.last?"&nbsp;":"" }
				</c:forEach>
			</form>
			</td>
		</tr>	
		<tr>
			<td colspan="2">${board.bo_content }</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<input type="button" class="btn btn-success" value="수정하기" 
					onclick="location.href='<c:url value="/board/${board.bo_no }/form"/>';"
				/>
				<input type="button" class="btn btn-success" value="삭제하기" id="del"	/>
				<input type="button" class="btn btn-secondary" value="뒤로가기" 
					onclick="history.back();"
				/>
				<input type="button" class="btn btn-primary" value="목록으로" 
					onclick="location.href='<c:url value='/board'/>';"
				/>
				<c:url value="/board/form" var="childBoardURL">
					<c:param name="bo_parent" value="${board.bo_no }" />
				</c:url>
				<input type="button" class="btn btn-primary" value="답글쓰기" 
					onclick="location.href='${childBoardURL}';"
				>
			</td>
		</tr>
	</tfoot>
</table>

<script>
	var bo_pass = $("#bo_pass");
	$("#del").on("click", function(){
		let pass = prompt("비번입력");
		bo_pass.val(pass);
		$("#delForm").submit();
	});
</script>







