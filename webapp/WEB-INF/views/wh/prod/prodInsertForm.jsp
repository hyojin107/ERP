<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- Modal -->
<form:form id="searchForm" modelAttribute="prodVO" action="${cPath }/ware/prod/search" method="get">
<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="searchModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchModalLabel">원자재 검색</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<thead>
						<tr><!-- 검색 -->
							<th>
								<label for="matAutocomplete">
									<spring:message code="mat.mat_name"/>
								</label>
							</th>
							<td>
								<input type="text" id="matAutocomplete" name="mat_name" placeholder="검색어를 입력하세요" >
							</td>
							<td>
								<select name="mat_use">
									<option value="">사용여부</option>
									<c:forEach items="${matUserruleList }" var="use">
										<option value="${use.code }">${use.name }</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<button type="button" class="btn btn-info" id="searchBtn">검색</button>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<div><!-- 검색어 추천 div -->
									<div id="log" style="overflow:auto;"></div>
								</div>
							</td>
						</tr>
						<tr class="table-info"><!-- 원자재 출력 table -->
							<th>
								체크
							</th>
							<th scope="col">
								<spring:message code="mat.mat_no"/>
							</th>
							<th scope="col">
								<spring:message code="mat.mat_name"/>
							</th>
							<th scope="col">
								<spring:message code="mat.mat_stock_size"/>
							</th>
							<th scope="col">
								<spring:message code="mat.lprod_no"/>
							</th>
							<th scope="col">
								<spring:message code="mat.mat_use"/>
							</th>
							<th scope="col">
								창고구역
							</th>
						</tr>
					</tbody>
					<tfoot id="resultbody"></tfoot>
				</table>
			</div>
			<div class="modal-footer">
			 <button type="button" id="matInsertBtn" class="btn btn-primary" data-dismiss="modal" >원자재 등록</button>
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
</form:form>

<h1>상품관리 : 상품 등록 폼</h1>

<form:form id="prodForm" modelAttribute="prodVO" method="post" action="${cPath }/ware/prod" enctype="multipart/form-data">
	<c:if test="${not empty methodType }">
		<input type="hidden" name="_method" value="${methodType }" />
	</c:if>
	<table class="table">
		<tr>
			<th>
				<spring:message code="prod.prod_no"/>
			</th>
			<td>
				<input type="text" name="prod_no" value="${prodVO.prod_no }" placeholder="자동생성" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_name"/>
			</th>
			<td>
				<input type="text" name="prod_name" value="${prodVO.prod_name }"/>
				<form:errors path="prod_name" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_img"/>
			</th>
			<td>
				<img id="img" style="height: 50px; width: 50px;" src="${cPath }/resources/prodImg/${prodVO.prod_no }"/>
				<input type="file" name="prod_image" value="${prodVO.prod_image }" accept="image/*" id="input_img"/>
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_safe_stock"/>
			</th>
			<td> 
				<input type="number" name="prod_safe_stock" value="${prodVO.prod_safe_stock }"/>
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_stock_size"/>
			</th>
			<td> 
				<input type="text" name="prod_stock_size" value="${prodVO.prod_stock_size }"/>
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_standard"/>
			</th>
			<td>
				<input type="number" value="${prodVO.prod_standard }" name="prod_standard"/>
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_stand_size"/>
			</th>
			<td>
				<input type="text" value="${prodVO.prod_stand_size }" name="prod_stand_size"/> 
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_out_price"/>
			</th>
			<td>
				<input type="number" value="${prodVO.prod_out_price }" name="prod_out_price"/> 
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_validity"/>
			</th>
			<td>
				<input type="date" name="prod_validity" value="${prodVO.prod_validity }"/> 
			</td>
		</tr>
		<tr>
			<th>
				<spring:message code="prod.prod_use"/>
			</th>
			<td> 
			<select name="prod_use">
				<option value="">사용여부</option>
				<c:forEach items="${ruleList }" var="use">
					<option value="${use.code }"
					${not empty prodVO and not empty prodVO.prod_use and prodVO.prod_use.contains(use.code) ? "selected" : "" }>
					${use.name }</option>
				</c:forEach>
			</select>
				<form:errors path="prod_use" element="span" cssClass="error"/>
			</td>
		</tr>
		
		<tr>
			<th>
				<spring:message code="prod.lprod_no"/>
			</th>
			<td>
				<select name="lprod_no" >
					<option value>상품분류</option>
					<c:forEach items="${lprodList }" var="lprod">
						<option value="${lprod.lprod_no}"
							${not empty prodVO.lprod_no and prodVO.lprod_no.contains(lprod.lprod_no) ? "selected":""}>
							${lprod.lprod_name }
						</option>
					</c:forEach>
				</select>
				<form:errors path="lprod_no" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<th>BOM</th>
			<td>
				<input type="checkbox" name="allchk" id="allchk"/><label for="allchk">모두 선택</label>
				<input type="button" id="deleteMatBtn" class="btn btn-danger" onclick="delRow()" data-mat="mat_no" value="원자재 삭제" disabled="disabled"/>
				<input type="button" id="searchMatBtn" class="btn btn-info" onclick="" value="원자재 찾기"/>
				<p>상품 등록시 체크박스로 원자재 삭제, 상품 수정시 수량을 0으로 지정하면 원자재 삭제</p>
				<table id="matTable">
					<thead class="table-primary">
						<tr>
							<td>선택</td>
							<td>원자재 코드</td>
							<td>원자재 명</td>
							<td>제품 수량</td>
							<td>수량 단위</td>
						</tr>
					</thead>
					<tbody><!-- 모달에서 선택된 원자재가 들어갈 공간 -->
					<!-- insert를 통해서 들어오면 bomlist는 무조건 null이고 , 수정을 통해서 들어오면 null이거나 값이 존재한다.   -->
						<c:choose>
							<c:when test="${not empty prodVO.bomlist or not empty bomVO}">
								<c:forEach items="${prodVO.bomlist }" var="bom">
									<tr>
										<td>
											<input type="checkbox" name="inputchk" class="rowchk">
										</td>
										<td>
											<input type="text" value="${bom.mat_no}" name="mat_no" readonly="readonly" class="bomMat">
										</td>
										<td>
											<input type="text" value="${bom.matVO.mat_name }" name ="mat_name" readonly="readonly"/>
										</td>
										<td>
											<input type="number" value="${bom.mat_number }" name="mat_number"/>
										</td>
										<td>
											<input type="text" value="${bom.mat_size }" name="mat_size" readonly="readonly">
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th></th>
									<th colspan="4">BOM 정보 없음</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody> 
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit"  class="btn btn-success" value="저장"/>
				<input type="reset"  class="btn btn-secondary" value="다시쓰기"/>
				<input type="button" class="btn btn-info" value="뒤로가기" onclick="history.back();"/>
				<input type="button"  class="btn btn-primary" value="목록으로 " onclick="location.href='${pageContext.request.contextPath}/ware/prod/list';"/>
			</td>
		</tr>
	</table>
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<!-- 초성검색을 위해 추가한 github에서 받은 js -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/hangul.js"></script>
<script type="text/javascript">
	
	// 이미지 등록할 때 미리보기 기능
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
	
	//모달창에서 선택한 원자재를 matTable에 자료 뿌려주기 
	var index=0;
	$(document).on("click","#matInsertBtn",function(){
			var chkArr = [];
			var bomArr = [];
			
			$("#matTable tr").find("input[class=bomMat]").each(function(idx,item){
				let bom = $(item).val();
				console.log("bom >>> " + bom);
				bomArr.push(bom);
			});
// 				index = bomArr.length;
		
				$("input[name=chkMat]:checked").each(function() {
					let chkMat = $(this).parent().parent().find(".mat_no").text();  // 모달에서 선택된 원자재 
					let inx = $.inArray(chkMat,bomArr);
						if(inx != -1){ // 등록할때 if문
							alert("이미 추가된 원자재 입니다.");
						}
						else{
							let mat_no = $(this).parent().parent().find(".mat_no").text();
							let mat_name = $(this).parent().parent().find(".mat_name").text();
							let mat_stock_size = $(this).parent().parent().find(".mat_stock_size").text();
							let str = $("<tr>").addClass('trTag').append(
// 									$("<th>").html($("<input>").attr({type:"checkbox",name:"inputchk"}).addClass('rowchk')),
// 									$("<td>").html($("<input readonly/>").attr({type : "text", name:"matList["+index+"].mat_no", value:mat_no}).addClass('bomMat')),
// 									$("<td>").html($("<input readonly/>").attr({type : "text", name: "matList["+index+"].mat_name", value:mat_name})),
// 									$("<td>").html($("<input />").attr({type : "text", name : "matList["+index+"].mat_number"})),
// 									$("<td>").html($("<input readonly/>").attr({type : "text", name : "matList["+index+"].mat_stock_size", value : mat_stock_size}))
									$("<th>").html($("<input>").attr({type:"checkbox",name:"inputchk"}).addClass('rowchk')),
									$("<td>").html($("<input readonly/>").attr({type : "text", name:"mat_no", value:mat_no}).addClass('bomMat')),
									$("<td>").html($("<input readonly/>").attr({type : "text", name: "mat_name", value:mat_name})),
									$("<td>").html($("<input />").attr({type : "text", name : "mat_number"})),
									$("<td>").html($("<input readonly/>").attr({type : "text", name : "mat_size", value : mat_stock_size}))
								)
								$("#matTable tbody").append(str);
// 								index++;
						}
						
				});
	});
	
	// true : 비활성화 , false : 활성화 
	// 모두선택 클릭시 체크박스 전체 선택 , 삭제 버튼 활성화
	var deleteMatBtn = document.getElementById('deleteMatBtn');
	$("#allchk").click(function(){
		var chk = $("#allchk").prop("checked");
		
		// 삭제버튼 활성화 비활성화
		if(deleteMatBtn.disabled){
			// 버튼이 비활성화 되어있으면 활성화 시킴
			deleteMatBtn.disabled = false; 
		}else{
			deleteMatBtn.disabled=true;
		}
		
		if(chk){
			$(".rowchk").prop("checked",true);
		}else{
			$(".rowchk").prop("checked",false);
		}
	});
	
	// 모두 선택 후 체크박스 하나 해제하면 모두선택 체크박스를 선택해제 함
	$("#matTable").on("click",".rowchk",(function(){
		$("#allchk").prop("checked",false);

		//체크 상태 엘리먼트가 0이면 비활성화
		if(deleteMatBtn.disabled){ 
			// 버튼이 비활성화 되어있으면 활성화 시킴
			deleteMatBtn.disabled = false;
		}
		let cnt = $("input:checkbox[name=inputchk]:checked").length;
		if(cnt==0){
			// 체크된 갯수가 0이면 비활성화 시키기
			deleteMatBtn.disabled = true; 
		}
	}));
	
	// jquery 로 테이블  tr 삭제 
	function delRow(){ 
		var mTable = document.getElementById('matTable');
		var lastRow = mTable.rows.length;
		var confirm_val = confirm("선택한 원자재를 삭제하시겠습니까?");
		if(confirm_val){
			for(var i=lastRow; i>=1; i--){
				if($("#matTable").find("input:checkbox").eq(i-1).is(":checked")){
					mTable.deleteRow(i);
				}
			}
		}
		
		if(lastRow==1){
			alert("삭제할 원자재가 없습니다.");
		}
		
		$("#deleteMatBtn").attr('disabled',true);
		$(".rowchk").prop("checked",false);
		$("#allchk").prop("checked",false);
// 		return;
	}

	// 원자재 검색 모달창 띄우기
	var sampleModal = $("#searchModal").modal({
		show:false
	}).on("hidden.bs.modal", function() { //modal창이 사라질때 실행할 이벤트 
		sampleModal.find("#matAutocomplete").val("");
		sampleModal.find(".modal-body table tfoot").empty();
	});
	
	// 원자재 입력시 나오는 추천검색어 영역을 모달창 위로 나오게끔 설정하는 부분
	$("#searchModal").on("show.bs.modal",function(){
		$("#matAutocomplete").autocomplete("option","appendTo","#searchModal")
	});

	// 버튼 눌렀을때 모달창 띄우기 (모달은 맨위에 )
	var searchModal = $("#searchMatBtn").on("click",function(){
		sampleModal.modal("show"); 	
	});
	
	// autocomplete 
	// 추천검색어를 log영역에서 띄운다. 
	function log(message){
		$("<div>").text(message).prependTo("#log");
		$("#log").scrollTop(0);
	}
	// 비동기로 원자재 이름만 불러오기 
	var textArr = [];
	$.ajax({
			type:"GET",
			url:"${cPath}/ware/prod/search/matnamesearch",
			cache : true,
// 			success:function(html){
// 				$.each(html,function(idx,item){
// 					textArr.push(item);
// 				});
// 			}
			success : function(data){
				// 초성가능하게 만들어 주는 부분
				let source = $.map(data,function(item){
				ch = "";
				Hangul.d(item,true).forEach(function(strItem, index){
					if(strItem[0] != " "){
						ch += strItem[0];
					}
				});
				return {
					label : ch + "|" + item, // 실제 검색어랑 비교 대상 이 저장된다. (ㅇㅈㅈ3|원자재3)
					value : item, // 단어
					ch : ch // 초성
				}
			});
	$("#matAutocomplete").autocomplete({
// 		source : textArr,
		source : source,
		focus : function(event, ui){ 
			return false; // 한글 에러 잡기 용도 > 한글검색 가능 
		},
		autoFocus:true, // 첫번째 항목 자동 포커스 (기본값 : false)
		position : {my:"right top",at:"right bottom"} // log부분 위치 지정 
				}).autocomplete("instance")._renderItem = function(ul, item){
					return $("<li>") // 기본 태그가 li로 잡혀져 있고
					.append("<div>"+item.value+"</div>") // 원하는 모앙의 html을 만들면 ui가 원하는 형태로변한다
					.appendTo(ul); // 웹에서는 완성된 단어의 형태가 보여지겠지만 내부에서는  'ㅇㅇㅈ3|원자재3' 에서 검색을 한다.
				};
			}
		});
	
	// 비동기로 검색하기 
	var resultbody = $("#resultbody");
	var searchForm = $("#searchForm").paging({
		searchUI : "#searchUI",
		searchBtn : "#searchBtn",
		pagination : "#pagingArea",
		pageParam : "page",
		byAjax : true,
		success : function(resp){
			let matList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(matList.length > 0){
				$.each(matList, function(idx,mat){
					let trTag = $("<tr>").append(
						$("<td>").html(
							$("<input>").attr("type","checkbox").attr("name", "chkMat").attr("value","chkbox")
						),
						$("<td class='mat_no'>").html(
							$("<input readonly>").attr("name","modalMat").attr("value",mat.mat_no).text(mat.mat_no)		
						),
// 						$("<td class='mat_no' value='mat.mat_no'>").text(mat.mat_no),
						$("<td class='mat_name'>").text(mat.mat_name),
						$("<td class='mat_stock_size'>").text(mat.mat_stock_size),
						$("<td>").text(mat.lprod_no),
						$("<td>").text(mat.mat_use == 'G001' ? '사용중' : '사용중지'),
						$("<td>").text(mat.sector_no)
					).data("mat_no",mat.mat_no);
					trTags.push(trTag);
				});
			$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<td colspan='4'>").text("조건에 맞는 원자재가 없습니다.")		
				));
				$("#pagingArea").empty();
			}
			resultbody.html(trTags);
			resultbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	});
</script>
