<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img{
		width: 300px;
	}
</style>
</head>
<body>
	<h1>Upload With Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class='uploadResult'>
		<ul>
		
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(function() {
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;
			
			var cloneObj = $(".uploadDiv").clone();
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadFile(uploadResultArr){
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					if(!obj.image){
						str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
					} else {
						// str += "<li>" + obj.fileName + "</li>";
						
						// encodeURIComponent: 한글이나 특수 기호를 인코딩한다. 섬내일의 이미지 경로를 구해서 인코딩을 한 다음 fileCallPath 에 전달 한다.
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid+"_"+obj.fileName);
						
						// src옆에 이미지 주소뿐만 아니라 url 주소를 사용할 수 있다. / byte를 controller에서 가져와서 이미지를 보여준다. (url을 통해서 이미지가 있는 곳을 노출 하지 않는다.) 
						str += "<li><img src='/display?fileName="+fileCallPath+"'></li>"
					}
				});
				uploadResult.append(str);
			}
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}

			$("#uploadBtn").on("click", function (e) {
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']"); // 배열로 리턴
				console.log(inputFile);
				var files = inputFile[0].files;
				
				console.log(files);
				
				for(var i = 0; i < files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					success: function(result){
						console.log(result);
						
						showUploadFile(result);
						
						$(".uploadDiv").html(cloneObj.html()); // <input type="file"> 초기화
					}
				});
			});
		});
	</script>
</body>
</html>