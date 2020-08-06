<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<form:form id="fixAssetsForm" modelAttribute="fixAssets"  method="post" enctype="multipart/form-data" class="w-100"
	action="${pageContext.request.contextPath }${currentAction }">
	<input type="hidden" name="_method" value="put" >
	
	<table class="table table-bordered">
		<tr>
			<th>고정자산코드</th>
			<td colspan="3"><input type="text" name="fixassets_no" class="code form-control" readonly
				 value="${fixAssets.fixassets_no}">
			<form:errors path="fixassets_no" element="span" cssClass="error" /></td>
			<td>
				<input type="file" name='img' accept="image/*" disabled="disabled" class="form-control" id="input_img" placeholder="자산이미지등록" tabindex="ewkl" title="qwfreq" > 
			</td>
		</tr>
		<tr>
			<th>계정과목</th>
			<td colspan="3">
				<select name="account_no" class="form-control" disabled>
					<c:forEach items="${accountList }" var="account">
						<option value="${account.account_no }" ${account.account_no eq fixAssets.account_no?'selected':'' }
						>${account.account_name }</option>
					</c:forEach>
				</select>
			<form:errors path="account_no" element="span" cssClass="error" /></td>
			<td rowspan="12">
				<img src="${cPath }/resources/fixImages/${fixAssets.fixassets_no}" style="max-width: 600px; max-height: 500px;" id='img'>
			</td>
		</tr>
		<tr>
			<th>자산명</th>
				 <td colspan="3"><input type="text" name="assets_name" class="form-control" readonly 
				 value="${fixAssets.assets_name }">
			<form:errors path="assets_name" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>취득가액</th>
			<td colspan="3"><input type="number" name="getcost" class="form-control" readonly
				 value="${fixAssets.getcost }">
			<form:errors path="getcost" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>취득일자</th>
			<td colspan="3"><input type="date" name="getdate" class="form-control" readonly
				 value="${fixAssets.getdate }">
			<form:errors path="getdate" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>상각방법</th>
			<td>
			<select name='amor_way' id='amor_way' disabled class="change form-control" >
					<option value='ratio' ${"ratio" eq fixAssets.amor_way? "selected": "" }>정률법</option>
					<option value='fix' ${"fix" eq fixAssets.amor_way? "selected": "" }>정액법</option>
				</select>
				<form:errors path="amor_way" element="span" cssClass="error" /></td>
			<th>내용연수</th>
			<td>
			<select name="life_year" id='life' class='change form-control' disabled="disabled">
					<c:forEach items="${ratioList }" var="ratio">
						<option data-ratio='${ratio.ratio }' data-fix='${ratio.fix }' 
						${fixAssets.life_year eq ratio.life_year? "selected":"" }>${ratio.life_year }</option>
					</c:forEach>
				</select>
				<form:errors path="life_year" element="span" cssClass="error" /></td>
		</tr>
		<tr>
			<th>상각률</th>
			<td>
				<input id='ratio' type="number" readonly="readonly" class="form-control code">
			<th>자산상태</th>
			<td colspan="3">
				<span>${fixAssets.status }</span>
			</td>
		</tr>
		<tr>
			<th>당기상각액</th>
			<td colspan="3">
				<span>${fixAssets.now }</span>
			</td>
		</tr>
		<tr>
			<th>상각누계액</th>
			<td colspan="3">
				<span>${fixAssets.total }</span>
			</td>
		</tr>
		<tr>
			<th>잔존가액</th>
			<td colspan="3">
				<span>${fixAssets.getcost - fixAssets.total }</span>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td colspan="3">
				<select name='use_status' disabled="disabled" class='change form-control'>
					<option value='G001' ${"G001" eq account.use_status? "selected": "" }>사용</option>
					<option value='G002' ${"G002" eq account.use_status? "selected": "" }>사용중지</option>
				</select>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript">
$("#input_img").on("change", handleImgFileSelect);
	var fixAssetsForm = $("#fixAssetsForm");
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
	var ratio = $("#ratio");
	$(".change").on("change", function(){
		let way = $("#amor_way").val();
		ratio.val($("#life").find("option").eq($("#life").val()-2).data(way));
	}).change();
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
</script>