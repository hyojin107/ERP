<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<form:form id="boardForm" modelAttribute="board"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }${currentAction }">
	
	<c:if test="${not empty methodType }">
		<input type="hidden" name="_method" value="${methodType }" >
	</c:if>	
	
	<input type="hidden" name="bo_no" value="${board.bo_no }">
	<input type="hidden" name="bo_parent" value="${board.bo_parent }" >
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<td><input type="text" name="bo_title" class="form-control"
				 value="${board.bo_title }">
			<form:errors path="bo_title" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="bo_writer" class="form-control"
				 value="${board.bo_writer }">
			<form:errors path="bo_writer" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="text" name="bo_pass" class="form-control"
				 value="${board.bo_pass }">
			<form:errors path="bo_pass" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>아이피</th>
			<td><input type="text" name="bo_ip" class="form-control"  readonly
				value="${pageContext.request.remoteAddr }">
			<form:errors path="bo_ip" element="span" cssClass="error" /></td>
		</tr>
		<c:if test="${not empty board.attatchList }">
			<tr>
				<th>기존파일</th>
				<td>
					<c:forEach items="${board.attatchList }" var="attatch" varStatus="vs">
						<span class="eachAttatch">${attatch.att_filename }
							<span class="delBtn" data-attno="${attatch.att_no }">[DEL]</span>${not vs.last?"&nbsp;":"" }</span>
					</c:forEach>
				</td>
			</tr>
		</c:if>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="bo_files" >
				<input type="file" name="bo_files" >
				<input type="file" name="bo_files" >
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea id="bo_content" class="form-control" name="bo_content">${board.bo_content }</textarea>
				<form:errors path="bo_content" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="reset" class="btn btn-warning" value="취소" />
				<input type="button" class="btn btn-secondary" value="뒤로가기" 
					onclick="history.back();"
				/>
				<input type="button" class="btn btn-primary" value="목록으로" 
					onclick="<c:url value='/board'/>"
				/>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	var boardForm = $("#boardForm");
	$(".delBtn").on("click", function(){
		let att_no = $(this).data("attno");
		boardForm.append(
			$("<input>").attr({
				type:"text"
				, name:"deleteAttatches"
				, value:att_no
			})	
		);
		$(this).parent("span:first").remove();		
	});
	CKEDITOR.replace( 'bo_content', {
		// Adding drag and drop image upload.
	      uploadUrl: '${pageContext.request.contextPath}/board/image?command=QuickUpload&type=Files&responseType=json',

	      // Configure your file manager integration. This example uses CKFinder 3 for PHP.
	      filebrowserImageUploadUrl: '${pageContext.request.contextPath}/board/image?command=QuickUpload&type=Images',
} );
</script>