
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2020. 7. 6      작성자명 박정민      최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>


<div class="container">
	<div class="row">
		<div class="col-9">
			첫번쨰

			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">생산보고서 번호</th>
						<th scope="col">생산 사원이름</th>
						<th scope="col">작성한 날짜</th>
					</tr>
				</thead>
				<tbody id="tablebody">

				</tbody>

				<tfoot>
					<tr>
						<td colspan="7">
							<nav aria-label="..." id="pagingArea"></nav>
							<div class="form-inline" id="searchUI">
								<select name="searchType" class="form-control mr-2">
									<option value="all"
										${pagingVO.searchVO.searchType eq 'all'?"selected":"" }>전체</option>
									<option value="emp"
										${pagingVO.searchVO.searchType eq 'emp'?"selected":"" }>직원이름</option>
									<option value="orderno"
										${pagingVO.searchVO.searchType eq 'orderno'?"selected":"" }>생산번호</option>
								</select> <input type="text" class="form-control mr-2" name="searchWord"
									value="${pagingVO.searchVO.searchWord }"> <input
									class="btn btn-success" type="button" value="검색" id="searchBtn">
							</div>
						</td>
					</tr>
				</tfoot>
			</table>

		</div>

		<div class="col-3">


			<div class="card bg-secondary text-white shadow ">
				<div class="card-body">
					상품반품목록
					<div class="text-white-50 small">#4e73df</div>
				</div>
			</div>

		</div>
	</div>

	<div class="row"></div>
</div>

<div class="modal fade" id="viewModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회원 정보 상세 조회</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="modalbody"></div>
			<div class="modal-footer">

				<button type="button" class="btn btn-secondary" data-dismiss="modal"
					onclick="SendForm(event)">폐기 작성하기</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<form id="searchForm" action="${cPath }/ware/dis">
	<input type="hidden" name="page" /> <input type="hidden"
		name="searchType" value="${pagingVO.searchVO.searchType }" /> <input
		type="hidden" name="searchWord"
		value="${pagingVO.searchVO.searchWord }" />
</form>




<script type="text/javascript"
	src="${cPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script>
	$('#tablebody').on("click", 'tr', function() {

		var modal = $(this);
		var modalbody = $(".modal-body")

		modalbody.load(modal.data("remote"));

	}).css({
		cursor : "pointer"
	});

	var listBody = $("#tablebody");
	var searchForm = $("#searchForm")
			.paging(
					{
						searchUI : "#searchUI",
						searchBtn : "#searchBtn",
						pagination : "#pagingArea",
						pageParam : "page",
						byAjax : true,
						success : function(resp) {
							let boardList = resp.dataList;
							let pagingHTML = resp.pagingHTML;
							let trTags = [];
							if (boardList.length > 0) {
								$
										.each(
												boardList,
												function(idx, pduct) {
													let trTag = $(
															"<tr data-toggle = 'modal' data-target = '#viewModal' data-remote='${cPath }/ware/dis/"+pduct.porder_no+"'>")
															.append(

																	$("<td>")
																			.text(
																					pduct.rep_no),
																	$("<td>")
																			.text(
																					pduct.emp_no),
																	$("<td>")
																			.text(
																					pduct.rep_date))
													trTags.push(trTag);
												});
								$("#pagingArea").html(pagingHTML);
							} else {
								trTags.push($("<tr>").html(
										$("<td colspan='8'>").text(
												"조건에 맞는 게시글이 없음.")));
								$("#pagingArea").empty();
							}
							listBody.html(trTags);
							listBody.data("currentpage", resp.currentPage);
							searchForm.find("[name='page']").val("");
						}
					}).submit();

	function SendForm() {

	}
</script>


