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
	                        	
	                           	<button data-oper='modify' class="btn btn-info">Modify</button>
								<button data-oper='list' class="btn btn-default">List</button>
								<button data-oper="remove" class="btn btn-danger">Remove</button>
								
								<form id='operForm' action="/boad/modify" method="get">
								  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}" />' >
								  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}" />' > 
								  <input type='hidden' name='amount' value='<c:out value="${cri.amount}" />' > 
								  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}" />' >
								  <input type='hidden' name='type' value='<c:out value="${cri.type}" />' >
								</form> 
								<script type="text/javascript">
									$(document).ready(function() {
									  
									  var operForm = $("#operForm"); 
									  var formObj=$("form");
									  
									  $("button[data-oper='modify']").on("click", function(e){
									    operForm.attr("action","/board/modify").submit();
									  	});
									  
									    
									  $("button[data-oper='list']").on("click", function(e){
									    operForm.find("#bno").remove();
									    operForm.attr("action","/board/list")
									    operForm.submit();
									  	});  
									  
									  $("button[data-oper='remove']").on("click", function(e) {
										  var confDel = confirm("삭제하시겠습니까?");
										  if(confDel){
											operForm.attr("action", "/board/remove").submit(); 
											operForm.attr("method", "post").submit();
										  } else {
											return;
										  }
										
										});
									});
								</script>
								
								<!-- reply ----------------------------------------------------------->
								<script type="text/javascript" src="/resources/js/reply.js"></script>
								<script>
									var bnoValue = '<c:out value="${board.bno}" />';
									
									replyService.getList({bno:bnoValue, page:1}, 
										// server에서 날라온 data를 list에 넣는다.
										function(list){
											// list의 길이가 있는 경우 len에 값을 넣는다. 없는 경우 0을 len에 넣는다.
											for(var i=0, len = list.length||0; i<len; i++){
												console.log(list[i]);
											}
									});							
								</script>
								<!-- ./reply -->
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
        <%@include file="../includes/footer.jsp" %>