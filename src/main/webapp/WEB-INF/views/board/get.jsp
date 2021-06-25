<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

            <style>
            
            	* {
				    margin: 0px;
				    padding: 0px;
				}
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
				  position: fixed;
				  display: none;
				  justify-content: center;
				  align-items: center;
				  top: 0px;
				  right: 0px;
				  width:100%;
				  height:100%;
				  background-color: gray; 
				  overflow:visible;
				  z-index: 100;
				}
				
				.bigPicture {
				  position: relative;
				  display:flex;
				  justify-content: center;
				  align-items: center;
				}
			</style>

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
                            Board Read Page                           
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">   
                        		<div class="form-group">
                        			<label>Bno</label>
                        			<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly>
                        		</div>                     	
                        		<div class="form-group">
                        			<label>Title</label>
                        			<input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly>
                        		</div>
                        		<div class="form-group">
                        			<label>Content</label>
                        			<textarea rows="3" name="content" class="form-control" readonly><c:out value="${board.content}"/></textarea>
                        		</div>
                        		<div class="form-group">
                        			<label>Writer</label>
                        			<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly>
                        		</div>                		                   	
                        	
                        	
                        		<%-- <a href="/board/modify?bno=<c:out value='${board.bno}'/>" class="btn btn-primary">Modify</a>
                                     <a href="/board/list"  class="btn btn-primary">List</a> --%>
	                        	
	                           	<button data-oper='modify' class="btn btn-primary">Modify</button>
								<button data-oper='list' class="btn btn-primary">List</button>
								
								
								
								<form id='operForm' action="/boad/modify" method="get">
								  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
								  <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
						          <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
						          <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                            	  <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
								</form>
								
								
								<script type="text/javascript" src="/resources/js/reply.js"></script> 
								<script type="text/javascript">
									$(document).ready(function() {
									  
									  var operForm = $("#operForm"); 
									  
									  $("button[data-oper='modify']").on("click", function(e){
									    
									    operForm.attr("action","/board/modify").submit();
									    
									  });
									  
									    
									  $("button[data-oper='list']").on("click", function(e){
									    
									    operForm.find("#bno").remove();
									    operForm.attr("action","/board/list")
									    operForm.submit();
									    
									  }); 
									  
									  var bnoValue='<c:out value="${board.bno}"/>';
										
										//댓글목록 UL
										var replyUL=$(".chat");
										
										showList(1); //기본값 1page
										
										function showList(page){
											replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){											
												if(page == -1){
										          pageNum = Math.ceil(replyCnt/10.0);
										          showList(pageNum);
										          return;
										        }
												
												var str="";
												
												//서버에서 전달되는 list가 없으면 중지
												if(list==null||list.length==0){													
													return;
												}
												
												for(var i=0,len=list.length||0;i<len;i++){
													str+="<li class='left clearfix' data-rno='"+list[i].rno+"' style='cursor:pointer'>";
													str+="	<div>";
													str+="		<div class='header'>";
													str+="			<strong>"+list[i].replyer+"</strong>";
													str+="			<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small>";
													str+="		</div>";
													str+="		<p>"+list[i].reply+"</p>";
													str+="	</div>";
													str+="</li>";                					
												}
												console.log(str);
												replyUL.html(str);
												
												//페이지번호 출력
												showReplyPage(replyCnt);
											});
										}
										
																				
										var pageNum = 1;
									    var replyPageFooter = $(".panel-footer");
									    
									    function showReplyPage(replyCnt){
									      console.log("replyCnt:"+replyCnt)
									      var endNum = Math.ceil(pageNum / 10.0) * 10;  
									      var startNum = endNum - 9; 
									      
									      var prev = startNum != 1;
									      var next = false;
									      
									      if(endNum * 10 >= replyCnt){
									        endNum = Math.ceil(replyCnt/10.0);
									      }
									      
									      if(endNum * 10 < replyCnt){
									        next = true;
									      }
									      
									      var str = "<ul class='pagination pull-right'>";
									      
									      if(prev){
									        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
									      }
									      
									       
									      
									      for(var i = startNum ; i <= endNum; i++){
									        
									        var active = pageNum == i? "active":"";
									        
									        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
									      }
									      
									      if(next){
									        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
									      }
									      
									      str += "</ul>";
									      
									      console.log(str);
									      
									      replyPageFooter.html(str);
									    }
									  	//delegate
									    replyPageFooter.on("click","li a", function(e){
									        e.preventDefault();
									        console.log("page click");
									        
									        var targetPageNum = $(this).attr("href");
									        
									        console.log("targetPageNum: " + targetPageNum);
									        
									        pageNum = targetPageNum;
									        
									        showList(pageNum);
									      });   
									    
									    /* modal ************************************************************/
									  	var modal=$(".modal");									  
									  
									    var modalInputReply = modal.find("input[name='reply']");
									    var modalInputReplyer = modal.find("input[name='replyer']");
									    var modalInputReplyDate = modal.find("input[name='replyDate']");
									    
									    var modalModBtn = $("#modalModBtn");
									    var modalRemoveBtn = $("#modalRemoveBtn");
									    var modalRegisterBtn = $("#modalRegisterBtn");
									    
									    $("#modalCloseBtn").on("click", function(e){
									    	
									    	modal.modal('hide');
									    });
									    
									    $("#addReplyBtn").on("click", function(e){
									      
									      modal.find("input").val("");
									      modalInputReplyDate.closest("div").hide();
									      modal.find("button[id !='modalCloseBtn']").hide();
									      
									      modalRegisterBtn.show();
									      
									      $(".modal").modal("show");
									      
									    });
									    
									    //댓글등록
									    modalRegisterBtn.on("click",function(e){
									    	var reply={
									    			reply:modalInputReply.val(),
									    			replyer:modalInputReplyer.val(),
									    			bno:bnoValue									    			
									    	};
									    	replyService.add(reply,function(result){
									    		alert(result);
									    		modal.find("input").val("");
									    		modal.modal("hide");
									    		
									    		showList(-1);
									    	});
									    });
									    //delegate
									    $(".chat").on("click","li",function(e){
									    	var rno=$(this).data("rno");//클릭한 댓글번호
									    	replyService.get(rno,function(reply){
									    		modalInputReply.val(reply.reply);
									    		modalInputReplyer.val(reply.replyer);
									    		modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
									    		.attr("readonly","readonly");
									    		modal.data("rno",reply.rno);
									    		
									    		modal.find("button[id!='modalCloseBtn']").hide();
									    		modalModBtn.show();
									    		modalRemoveBtn.show();
									    		$(".modal").modal("show");
									    	});	
									    });
									    //댓글수정
									    modalModBtn.on("click",function(e){
									    	var reply={rno:modal.data("rno"),reply:modalInputReply.val()};
									    	replyService.update(reply,function(result){
									    		alert(result);
									    		modal.modal("hide");
									    		showList(pageNum);
									    	});
									    });
									  //댓글삭제
									    modalRemoveBtn.on("click",function(e){
									    	var rno=modal.data("rno");
									    	replyService.remove(rno,function(result){
									    		alert(result);
									    		modal.modal("hide");
									    		showList(pageNum);
									    	});
									    });
									  //첨부파일 클릭
									    $(".uploadResult").on("click","li", function(e){	
									        
									        var liObj = $(this);									        
									        var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
									        
									        if(liObj.data("type")){
									          //원본이미지보기
									          showImage(path.replace(new RegExp(/\\/g),"/"));
									        }else {
									          //download 
									          self.location ="/download?fileName="+path
									        }	
									      });
									    function showImage(fileCallPath){
									        $(".bigPictureWrapper").css("display", "flex").show();
									        
									        $(".bigPicture")
									        .html("<img src='/display?fileName="+fileCallPath+"' >")
									        .animate({width:'100%', height: '100%', position:'absolute'}, 1000);
									        
									      }
										//원본이미지창 닫기
									    $(".bigPictureWrapper").on("click", function(e){
									      $(".bigPicture").animate({width:'0%', height: '0%'}, 1000,function(){
									        $('.bigPictureWrapper').hide();
									      });
									     
									    }); 
										//첨부파일목록
										var bno = '<c:out value="${board.bno}"/>';
									    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){									        
									        var str = "";
									        
									        $(arr).each(function(i, attach){
									        
									          //image type
									          if(attach.fileType){
									            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
									            
									            str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
									            str += "<img src='/display?fileName="+fileCallPath+"'>";
									            str += "</div>";
									            str +"</li>";
									          }else{
									              
									            str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
									            str += "<span> "+ attach.fileName+"</span><br/>";
									            str += "<img src='/resources/img/attach.png'></a>";
									            str += "</div>";
									            str +"</li>";
									          }
									        });
									        
									        $(".uploadResult ul").html(str);
									        
									        
									      });
									    
									}); 
								</script>
								
								
								
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <!-- 첨부파일목록 ------------------------------------------------------------>

					
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
	                    			<div class="uploadResult">
										<ul>
										
										</ul>
									</div>
	                    		</div>
                    		</div>
                    	</div>
                    </div>
                    <!-- 첨부파일목록 -->
                    <!-- reply list ----------------------------------------------------------------->
                    <div class="row">
                    	<div class="col-lg-12">
                    		<div class="panel panel-default">
                    			<div class="panel-heading">
                    				<i class="fa fa-comments fa-fw"></i> Reply
                    				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">
                    					New Reply
                    				</button>
                    			</div>
	                    		<div class="panel-body">
	                    			<ul class="chat">
	                    				
	                    			</ul>
	                    		</div>
	                    		<div class="panel-footer">
	                    		
	                    		</div>
                    		</div>
                    	</div>
                    </div>
                    <!-- reply list -->
                    <!-- modal ----------------------------------------------------------------------->
                	<div id="myModal" class="modal fade" role="dialog">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">Reply Modal</h4>
					      </div>
					      <div class="modal-body">
					        <div class="form-group">
					        	<label>Reply</label>
					        	<input class="form-control" name="reply"> 
					        </div>
					        <div class="form-group">
					        	<label>Replyer</label>
					        	<input class="form-control" name="replyer"> 
					        </div>
					        <div class="form-group">
					        	<label>Reply Date</label>
					        	<input class="form-control" name="replyDate"> 
					        </div>
					      </div>
					      <div class="modal-footer">
					      	<button id="modalModBtn" type="button" class="btn btn-primary" data-dismiss="modal">Modify</button>
					      	<button id="modalRemoveBtn" type="button" class="btn btn-primary" data-dismiss="modal">Remove</button>
					      	<button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">Register</button>
					        <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>							        
					      </div>
					    </div>							
					  </div>
					</div>
                    
                    <!-- modal -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
        <%@include file="../includes/footer.jsp" %>