<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<script>
	var userListArea = $("#userList").on("click", "li:not(.me)", function(event){
		let email = $(this).data("email"); 
		alert(email);
	});
	
	const protocol = location.protocol == "http:"?"ws":"wss";
	const domain = location.hostname;
	const port = location.port != ""?":"+location.port:"";
	const address = protocol+"://"+domain+port+"${cPath}/pushMessage";
	$("#url").val(address);
	var ws = null;
		ws = new WebSocket(address);
		ws.onopen=function(event){
			console.log(event);
		}
		ws.onclose=function(event){
			console.log(event);
		}
		ws.onmessage=function(event){
			let userList = event.data;
			userList = JSON.parse(userList);
			console.log(userList);
			let liTags = [];
			for(let i=0; i<userList.lenth; i++){
				let user = userList[i];
				let liTag = $("<li>").text(user.mem_name).data("email", user.mem_mail);
				if(user.mem_id=="${authUser.mem_id}"){
					liTag.addClass("me");
				}
				liTags.push(liTag);
			}
			userListArea.html(liTags);
		}
		ws.onerror=function(event){
			console.log(event);
		}
</script>
</body>
</html>