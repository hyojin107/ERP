<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<h1>고정자산등록</h1>
<form:form id="fixAssetsForm" modelAttribute="fixAssets"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }${currentAction }">
	
	<input type="hidden" name="fixassets_no" value="${fixAssets.fixassets_no }">
	<table class="table table-bordered">
		<tr>
			<th>계정과목</th>
			<td>
				<select name="account_no">
					<c:forEach items="${accountList }" var="account">
						<option value="${account.account_no }">${account.account_name }
					</c:forEach>
				</select>
			<form:errors path="account_no" element="span" cssClass="error" /></td>
			<td>
				자산이미지등록<input type="file" name='img' value='${fixAssets.fixassets_no }' 
				accept="image/*" id="input_img">
			</td>
		</tr>
		<tr>
			<th>자산명</th>
				 <td><input type="text" name="assets_name" class="form-control"  required="required"
				 value="${fixAssets.assets_name }">
			<form:errors path="assets_name" element="span" cssClass="error" /></td>
			<td rowspan="6">
				<img id="img" style="width: auto; max-height: 500px;" alt=''/>
			</td>
		</tr>
		<tr>
			<th>취득가액</th>
			<td><input type="number" name="getcost" class="form-control" required="required"
				 value="${fixAssets.getcost }">
			<form:errors path="getcost" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>취득일자</th>
			<td><input type="date" name="getdate" class="form-control" required
				 value="${fixAssets.getdate }">
			<form:errors path="getdate" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>상각방법</th>
			<td>
			<select name='amor_way' id='amor_way' class='change'>
					<option value='ratio' ${"ratio" eq fixAssets.amor_way? "selected": "" }>정률법</option>
					<option value='fix' ${"fix" eq fixAssets.amor_way? "selected": "" }>정액법</option>
				</select>
				<form:errors path="amor_way" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>내용연수</th>
			<td>
				<select name="life_year" id='life' class='change'>
					<c:forEach items="${ratioList }" var="ratio">
						<option data-ratio='${ratio.ratio }' data-fix='${ratio.fix }'>${ratio.life_year }</option>
					</c:forEach>
				</select>
				<form:errors path="life_year" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>상각률</th>
			<td>
				<input id='ratio' type="number" readonly="readonly" class="form-control">
		</tr>
		<tr>
			<td colspan="3">
				<input type="submit" class="btn btn-success" value="저장" />
				<input type="button" class="btn btn-secondary" value="다시작성"/>
				<input type="button" class="btn btn-primary" value="목록으로" 
					onclick="location='${cPath}/account/fixAssets'"
				/>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$("#input_img").on("change", handleImgFileSelect);

var sel_file;
function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			return;
		}
		
		sel_file = f;
		var reader = new FileReader();
		reader.onload = function(e){
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}
// function setThumbnail(event) {
// 	var reader = new FileReader();
// 	reader.onload = function(event) { 
// 		var img = document.createElement("img");
// 		img.setAttribute("src", event.target.result);
// 		$("#image_container").append(img);
// 		};
		
// 		reader.readAsDataURL(event.target.files[0]); 
// 	}

var ratio = $("#ratio");
$(".change").on("change", function(){
	let way = $("#amor_way").val();
	ratio.val($("#life").find("option").eq($("#life").val()-2).data(way));
});
	var fixAssetsForm = $("#fixAssetsForm");
	$(".delBtn").on("click", function(){
		let att_no = $(this).data("attno");
		fixAssetsForm.append(
			$("<input>").attr({
				type:"text"
				, name:"deleteAttatches"
				, value:att_no
			})	
		);
		$(this).parent("span:first").remove();		
	});
	
$("input[value='다시작성']").on("click", function(){
	$("input").not(".btn").val("");
	$("select").val("");
})
$("#life").change();
</script>