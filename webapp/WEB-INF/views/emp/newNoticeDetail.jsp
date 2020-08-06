<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<h1>공지사항- 작성</h1>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>

<form:form id="boardForm" modelAttribute="notice"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }/emp/register/notice/register">
	
	<c:if test="${not empty methodType }">
		<input type="hidden" name="_method" value="${methodType }" >
	</c:if>	
	
	<table class="table table-bordered">
		<input type="hidden" name="notice_no" value="${notice.notice_no }">
		<!-- input type="hidden" name="bo_parent" value="${board.bo_parent }" -->
		<tr>
			<th>제목</th>
			<td><input type="text" name="notice_title" class="form-control"
				 value="${notice.notice_title }">
			<form:errors path="notice_title" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="emp_no" class="form-control"
				 value="${notice.emp_no }">
			<form:errors path="emp_no" element="span" cssClass="error" /></td>
		</tr>
		<%-- <tr>
			<th>비밀번호</th>
			<td><input type="text" name="bo_pass" class="form-control"
				 value="${board.bo_pass }">
			<form:errors path="bo_pass" element="span" cssClass="error" /></td>
		</tr> --%>
		<%-- <tr>
			<th>아이피</th>
			<td><input type="text" name="bo_ip" class="form-control"  readonly
				value="${pageContext.request.remoteAddr }">
			<form:errors path="bo_ip" element="span" cssClass="error" /></td>
		</tr> --%>
		<c:if test="${not empty notice.attatchList }">
			<tr>
				<th>기존파일</th>
				<td>
					<c:forEach items="${notice.attatchList }" var="attatch" varStatus="vs">
						<span class="eachAttatch">${attatch.att_filename }
							<span class="delBtn" data-attno="${attatch.att_no }">[DEL]</span>${not vs.last?"&nbsp;":"" }</span>
					</c:forEach>
				</td>
			</tr>
		</c:if>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name="notice_file" >
				<input type="file" name="notice_file" >
				<input type="file" name="notice_file" >
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="form-control" id="notice_content" name="notice_content">${notice.notice_content }</textarea>
				<form:errors path="notice_content" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="reset" class="btn btn-warning" value="취소" />
				<input type="button" class="btn btn-secondary" value="뒤로가기" 
					onclick="history.back();"
				/>
				<%-- <input type="button" class="btn btn-primary" value="목록으로" 
					onclick="<c:url value='/emp'/>"
				/> --%>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
	CKEDITOR.replace("notice_content",{
		  // Adding drag and drop image upload.
// 	      extraPlugins: 'print,format,font,colorbutton,justify,uploadimage',
	      uploadUrl: '${pageContext.request.contextPath}/emp/image?command=QuickUpload&type=Files&responseType=json',

	      // Configure your file manager integration. This example uses CKFinder 3 for PHP.
	      filebrowserImageUploadUrl: '${pageContext.request.contextPath}/emp/image?command=QuickUpload&type=Images',

		
	});	
	

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
</script>