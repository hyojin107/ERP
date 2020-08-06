<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

<table class="table table-bordered">
	<tbody>
		<tr>
			<td>제목: ${notice.notice_title}</td>
			<td>조회수 : ${notice.notice_view}</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td> 작성자 : ${notice.emp_no}</td>
			<td> 작성날짜 :${notice.notice_date}</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:forEach items="${notice.attatchList}" var="attatch" varStatus="vs">
					<a href="<c:url value='${cPath}/emp/register/notice/file/${attatch.att_no}' />">${attatch.att_filename}</a> ${not vs.last?"&nbsp;":"" }
				</c:forEach>
			</td>
		</tr>	
		<tr>
			<td colspan="2">내용:${notice.notice_content}</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<input type="button" class="btn btn-success" value="수정하기" 
					onclick="location.href='<c:url value="${cPath}/emp/register/notice/${notice.notice_no}/form"/>';"
				/>
				<input type="button" class="btn btn-success" value="삭제하기" id="deleteBtn" />
				<input type="button" class="btn btn-secondary" value="뒤로가기" 
					onclick="history.back();"
				/>
<%-- 
				<c:url value="/board/form" var="childBoardURL">
					<c:param name="bo_parent" value="${board.bo_no }" />
				</c:url>
				<input type="button" class="btn btn-primary" value="답글쓰기" 
					onclick="location.href='${childBoardURL}';"
				> --%>
			</td>
		</tr>
	</tfoot>
</table>
<!-- modal?? -->
<form class="form-inline" method="post" action="${pageContext.request.contextPath}/emp/register/update/${notice.notice_no}">
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시글 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
	      <input type="hidden" name="_method" value="delete">
	      <div class="modal-body">
	        <p>비밀번호 : <input class="form-control" type="text" id="inputPass">
	      </div>
	      <div class="modal-footer justify-content-right">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="submit" class="btn btn-primary" id="deleteModal">Delete</button>
	      </div>
    </div>
  </div>
</div>
</form> 
<script type="text/javascript">
 	$("#deleteBtn").on("click", function(){
		 $("{#deleteModal}").modal("show");   // 삭제 버튼을 누르면 모달창이 나오는거 
		
	})
	
	
	$("#deleteModal").on("click"),function(event){
 		var authUser = "${authUser.emp_pass}";
 		var inputPass = $("#inputPass").val();
 		if(authUser != inputPass){
 			event.preventDefault();
 			alert("비밀번호가 틀렸습니다.");
 		}
 	}
</script>









