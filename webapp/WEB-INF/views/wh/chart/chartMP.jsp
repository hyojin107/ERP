<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현황관리 : 상품별, 원자재별 입고 , 출고현황을 보여준다. </title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
</head>
<body>
<h1>현황관리 : 상품별 원재별 입고출고폐기현황을 보여준다.</h1>
<div>
<table class="table">
<thead>
	<tr>
	<th>분류</th>
	<th>제품명</th>
	<th>상태</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td>
			<select>
				<option>상품</option>
				<option>원자재</option>
			</select>
		</td>
		<td><input type="text" name="search_name"></td>
		<td>
			<select>
				<option>입고</option>
				<option>출고</option>
				<option>폐기</option>
			</select>
		</td>
	</tr>
</tbody>
</table>
	
</div>
<br/>
<div>
	<form action="">
		<table  class="table table-striped">
			<thead>
				<tr>
					<th>상품분류</th>	
					<th>상태</th>
					<th>창고</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>원자재</td>
					<td>입고/폐기/출고</td>
					<td>C창고</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<hr>
<script src="js/chart/Chart.js"></script>
<canvas id="myChart" width="400" height="400"></canvas>
<script>
var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>

</body>
</html>