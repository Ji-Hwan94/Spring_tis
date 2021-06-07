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
                        	
	                        	<button type="submit" data-oper="modify" class="btn btn-info">Modify</button>
	                        	<!-- <button type="submit" data-oper="remove" class="btn btn-primary">Remove</button> -->
	                        	<button type="submit" data-oper="list" class="btn btn-default">List</button>
	                        	
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
                           						self.location="/board/list";
                           						return;
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
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
        <%@include file="../includes/footer.jsp" %>