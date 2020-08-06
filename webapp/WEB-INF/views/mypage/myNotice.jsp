<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>공지사항</h1>    
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>#</th>
			<th>No.</th>
			<th>내용</th>
			<th>작성자</th>
			<th>작성날짜</th>
		</tr>
	</thead>
	<tbody id="listBody">
		
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<select name="searchType" class="form-control mr-2">
						<option value="" ${empty pagingVO.searchVO.searchType?"selected":"" }>
							<%-- <spring:message code="all" /> --%>
						</option>
						<option value="title" ${pagingVO.searchVO.searchType eq 'title'?"selected":"" }>
							<%-- <spring:message code="title" /> --%>
						</option>
						<option value="writer" ${pagingVO.searchVO.searchType eq 'writer'?"selected":"" }>
							<%-- <spring:message code="writer" /> --%>
						</option>
						<option value="content" ${pagingVO.searchVO.searchType eq 'content'?"selected":"" }>
							<%-- <spring:message code="content" /> --%>
						</option>
					</select>
					<input type="text" class="form-control mr-2" name="searchWord"
						value="${pagingVO.searchVO.searchWord }"
						onkeyup="event.keyCode==13?$('#searchBtn').trigger('click'):'';"
					>
					<input class="btn btn-success mr-2" type="button" value="검색 " id="searchBtn">
					<%-- <input class="btn btn-success mr-2" type="button" value="새글쓰기" 
						onclick="location.href='<c:url value="/emp/newNoticeDetail"/>';"
					> --%>
					
				</div>
				<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
					${pagingVO.pagingHTML }
				</nav>	
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<form id="searchForm" action="${pageContext.request.contextPath }/emp">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let noticeList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(noticeList.length>0){
				$.each(noticeList, function(idx, notice){
					let trTag = $("<tr>").append(
									$("<td>").text(notice.rnum)
									, $("<td>").html(
										$("<a>").attr("href", "${pageContext.request.contextPath }/emp/notice/"+notice.notice_no)
												.html(notice.notice_title)													
									)
									, $("<td>").text(notice.emp_name)
									, $("<td>").text(notice.notice_date)
									, $("<td>").text(notice.notice_view));
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html($("<td colspan='8'>").text("조건에 맞는 게시글이 없음.")));
				$("#pagingArea").empty();
			}
			listBody.html(trTags);
			listBody.data("currentpage", resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();

</script>