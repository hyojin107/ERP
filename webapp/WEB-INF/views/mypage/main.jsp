    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<h1>My Page</h1>
<!-- Main content -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6" style="padding:50px;">
				<!-- 달력  -->

	<iframe src="${cPath }/myCalendar/my" style="width:100%; height:750px;" scrolling="no" ></iframe>
				

		</div> 

		<!-- /.col-md-6 -->
		<div class="col-lg-6" style="padding-top: 50px;">
			<div class="card">
				<div class="card-header">
					<h5 class="m-0">주요 업무 리스트</h5>
				</div>
				<div class="card-body">
					<li></li>
					<li></li>
					<li></li>
					<li></li>

				</div>
			</div>

			<div class="card card-primary card-outline">
				<div class="card-header">
					<h5 class="m-0">공지사항</h5>
				</div>
				<div class="card-body">
					<li></li>
					<li></li>
					<li></li>
					<li></li>

				</div>
			</div>
		</div>
		<!-- /.col-md-6 -->
		
		
	</div>
	<!-- /.row -->
</div>
<!-- /.container-fluid -->
 </div>
<!-- /.content -->
 </div>
