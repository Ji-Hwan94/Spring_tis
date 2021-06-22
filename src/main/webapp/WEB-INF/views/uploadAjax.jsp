<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none; /* 기호 없애기 */
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>
</head>
<body>
	<h1>Upload With Ajax</h1>
	<div class='bigPictureWrapper'>
	  <div class='bigPicture'>
	  </div>
	</div>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		function showImage(fileCallPath){
		  
		  //alert(fileCallPath);
		
		  $(".bigPictureWrapper").css("display","flex").show();
		  
		  $(".bigPicture")
		  .html("<img style='cursor:pointer' src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
		  .animate({width:'100%', height: '100%'}, 1000);
		}	
		
		$(document).ready(function(){
			var cloneObj=$(".uploadDiv").clone();
			
			$("#uploadBtn").on("click",function(e){
				var formData=new FormData();
				var inputFile=$("input[name='uploadFile']");//배열로 리턴				
				var files=inputFile[0].files;				
				
				for(var i=0;i<files.length;i++){
					formData.append("uploadFile",files[i])
				}
				$.ajax({
					url:'/uploadAjaxAction',
					processData:false,
					contentType:false,
					data:formData,
					type:'POST',
					dataType: 'json',
					success:function(result){
						console.log(result);
						
						showUploadedFile(result);						
						
						$(".uploadDiv").html(cloneObj.html()); //<input type="file">초기화
					}
				});
			});
			
			$(".bigPictureWrapper").on("click", function(e){
				  $(".bigPicture").animate({width:'0%', height: '0%'}, 1000,function() {
					  $(".bigPictureWrapper").hide();
				  });
			
				 /*  setTimeout(function() {
					  $(".bigPictureWrapper").hide();
				  }, 1000); */
				  
				});
			
			
			var uploadResult=$(".uploadResult ul");
			function showUploadedFile(uploadResultArr){
			   var str = "";
				   
			   $(uploadResultArr).each(function(i, obj){
			     
			     if(!obj.image){			       
			       var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			       
			       str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
		           "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
		           "<span style='cursor:pointer' data-file=\'"+fileCallPath+"\' data-type='file'> &times; </span>"+
		           "<div></li>"
			     }else{			       
			    	 var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);			         
			         var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;			         
			         originPath = originPath.replace(new RegExp(/\\/g),"/");
			         
			         str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
			                "<img src='display?fileName="+fileCallPath+"'></a>"+
			                "<span style='cursor:pointer' data-file=\'"+fileCallPath+"\' data-type='image'> &times; </span>"+
			                "<li>";
			     }
			   });
			   
			   uploadResult.append(str);
			}
			
			$(".uploadResult").on("click","span", function(e){				   
				  var targetFile = $(this).data("file");
				  var type = $(this).data("type");
				  console.log(targetFile);
				  
				  $.ajax({
				    url: '/deleteFile',
				    data: {fileName: targetFile, type:type},
				    dataType:'text',
				    type: 'POST',
				      success: function(result){
				         alert(result);
				       }
				  }); //$.ajax
				  
				});		
			
		});
	</script>
</body>
</html>