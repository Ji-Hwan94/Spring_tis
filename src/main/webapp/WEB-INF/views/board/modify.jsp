<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify                           
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">  
                        	<form role="form" action="/board/modify" method="post"> 
                        		<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                        		<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                        		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                            	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                        		
                        		
                        		<div class="form-group">
                        			<label>Bno</label>
                        			<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly>
                        		</div>                     	
                        		<div class="form-group">
                        			<label>Title</label>
                        			<input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
                        		</div>
                        		<div class="form-group">
                        			<label>Content</label>
                        			<textarea rows="3" name="content" class="form-control"><c:out value="${board.content}"/></textarea>
                        		</div>
                        		<div class="form-group">
                        			<label>Writer</label>
                        			<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly>
                        		</div>   
                        		<div class="form-group">
                        			<label>RegDate</label>
                        			<input class="form-control" name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly>
                        		</div> 
                        		<div class="form-group">
                        			<label>Update Date</label>
                        			<input class="form-control" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly>
                        		</div>              		                   	
                        	
	                        	<button type="submit" data-oper="modify" class="btn btn-primary">Modify</button>
	                        	<button type="submit" data-oper="remove" class="btn btn-primary">Remove</button>
	                        	<button type="submit" data-oper="list" class="btn btn-primary">List</button>
	                        	
	                        	<%-- <a href="/board/remove?bno=<c:out value='${board.bno}'/>" class="btn btn-primary">Remove</button>
	                        	<a href="/board/list" class="btn btn-primary">List</button> --%>
                           
                           		<script>
                           			$(document).ready(function(){
                           				var formObj=$("form");
                           				$("button").on("click",function(e){
                           					e.preventDefault(); //전송방지
                           					var operation=$(this).data("oper");
                           					if(operation==="remove"){
                           						formObj.attr("action","/board/remove"); //action변경
                           					}else if(operation==="list"){
                           						formObj.attr("action","/board/list"); //action변경
                           						formObj.attr("method","get"); //method변경
                           						//hidden태그 4개만 전달하기 위해서, 백업->form태그 empty->백업한거 추가
                           						var pageNumTag=$("input[name='pageNum']").clone();
                           						var amountTag=$("input[name='amount']").clone();
                           						var keywordTag=$("input[name='pageNum']").clone();
                           						var typeTag=$("input[name='pageNum']").clone();
                           						
                           						formObj.empty();
                           						
                           						formObj.append(pageNumTag);
                           						formObj.append(amountTag);
                           						formObj.append(keywordTag);
                           						formObj.append(typeTag);                          						
                           						
                           					}else if(operation==='modify'){ 
	                           			        var str = "";
	                           			        
	                           			        $(".uploadResult ul li").each(function(i, obj){
	                           			          
	                           			          var jobj = $(obj);
	                           			          
	                           			          console.dir(jobj);
	                           			          
	                           			          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	                           			          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	                           			          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	                           			          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	                           			          
	                           			        });
	                           			        formObj.append(str).submit();
                           					}
                           					formObj.submit();
                           				});
                           			});
                           		</script>
                           </form> 
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <!-- 첨부파일목록 ------------------------------------------------------------>
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
						text-align: center;
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
					.btn-circle{
						font-size:10px;
						width: 20px;
						height: 20px;
						padding: 0;
					}
					</style>
					<div class='bigPictureWrapper' style='cursor:pointer'>
					  <div class='bigPicture'>
					  </div>
					</div>
					<div class="row">
                    	<div class="col-lg-12">
                    		<div class="panel panel-default">
                    			<div class="panel-heading">
                    				Files                    				
                    			</div>
	                    		<div class="panel-body">
		                    		<div class="form-group uploadDiv">
							            <input type="file" name='uploadFile' multiple="multiple">
							        </div>
	                    			<div class="uploadResult">
										<ul>
										
										</ul>
									</div>
	                    		</div>
                    		</div>
                    	</div>
                    </div>
                    <!-- 첨부파일목록 -->
					<script>
					$(document).ready(function(){
						var bno = '<c:out value="${board.bno}"/>';
					    
					    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){					    			      
					      var str = "";

					      $(arr).each(function(i, attach){					          
					          //image type
					          if(attach.fileType){
					            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
					            
					            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
					            str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					            str += "<span>"+ attach.fileName+"</span>";
					            str += " <button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
					            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					            str += "<img src='/display?fileName="+fileCallPath+"'>";
					            str += "</div>";
					            str +"</li>";
					          }else{					              
					            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
					            str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					            str += "<span>"+ attach.fileName+"</span>";
					            str += " <button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
					            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					            str += "<img src='/resources/img/attach.png'></a>";
					            str += "</div>";
					            str +"</li>";
					          }
					       });
					      
					      $(".uploadResult ul").html(str);					      
					    });
					    
					    $(".uploadResult").on("click", "button", function(e){	
					        if(confirm("Remove this file? ")){					        
					          var targetLi = $(this).closest("li");
					          targetLi.remove();
					        }
					      });  
					    
					    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						var maxSize = 5242880; //5MB
						 
						function checkExtension(fileName, fileSize){
						  
						  if(fileSize >= maxSize){
						    alert("파일 사이즈 초과");
						    return false;
						  }
						  
						  if(regex.test(fileName)){
						    alert("해당 종류의 파일은 업로드할 수 없습니다.");
						    return false;
						  }
						  return true;
						}
						  
						$("input[type='file']").change(function(e){
						    var formData = new FormData();	    
						    var inputFile = $("input[name='uploadFile']");				    
						    var files = inputFile[0].files;				    
						    for(var i = 0; i < files.length; i++){
						      if(!checkExtension(files[i].name, files[i].size) ){
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
						      dataType:'json',
						      success: function(result){
						          console.log(result); 
								  showUploadResult(result); //업로드 결과 처리 함수 

						      }
						    }); 
						  }); 
						
						function showUploadResult(uploadResultArr){
						    
						    if(!uploadResultArr || uploadResultArr.length == 0){ return; }				    
						    var uploadUL = $(".uploadResult ul");
						    
						    var str ="";
						    
						    $(uploadResultArr).each(function(i, obj){				    
						        //image인 경우
						    	if(obj.image){
									var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
									str += "<li data-path='"+obj.uploadPath+"'";
									str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
									str +" ><div>";
									str += "<span>"+obj.fileName+"</span>";
									str += " <button type='button' data-file=\'"+fileCallPath+"\' "
									str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/display?fileName="+fileCallPath+"'>";
									str += "</div>";
									str +"</li>";
								}else{
									var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
								    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
								      
									str += "<li "
									str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
									str += "<span>"+ obj.fileName+"</span>";
									str += " <button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
									str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/resources/img/attach.png'></a>";
									str += "</div>";
									str +"</li>";
								}
						    });
						    
						    uploadUL.append(str);
						  }
					});
					
					</script>                    
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
        <%@include file="../includes/footer.jsp" %>