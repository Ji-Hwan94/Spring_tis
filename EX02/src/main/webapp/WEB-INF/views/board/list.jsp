<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
    
    
<!--  includes폴더의 header.jsp 파일을 추가한다. -->
<%@include file = "../includes/header.jsp" %>


            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board</h1>
                </div>
            </div>
                <!-- /.col-lg-12 -->
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                            <a href="/board/register" class="btn btn-info pull-right btn-xs">글쓰기</a>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>NO</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items = "${ list }" var="board">
                            		<tr>
                            			<td><c:out value="${board.bno}" /></td>
                            			<td width="800px"><c:out value="${board.title}" /></td>
                            			<td><c:out value="${board.writer}" /></td>
                            			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                            			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
                            		</tr>
                            	</c:forEach>	
                            	
                            </table>
                        </div>
                            <!-- /.table-responsive -->
                         
                        <!-- Modal -->
						<div id="myModal" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
  							<div class="modal-dialog">
					    		<div class="modal-content">
					      			<div class="modal-header">
					        			<button type="button" class="close" data-dismiss="modal">&times;</button>
					        			<h4 class="modal-title">Modal Header</h4>
					      			</div>
					      			<div class="modal-body">
					        			<p>처리가 완료 되었습니다.</p>
					      			</div>
					      			<div class="modal-footer">
					        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      			</div>
					    		</div>
					 		</div>
						</div>
					<script type="text/javascript">
						$(function() {
							var result = '<c:out value="${result}" />';
							checkModal(result);
							
							function checkModal(result) {
								if(result == ''){
									return;
								}
								
								if(parseInt(result)>0){
									$(".modal-body").html("게시글"+parseInt(result)+" 번이 등록되었습니다.");
								}
								
								$("#myModal").modal("show"); // 모달창 오픈
							}
						})
					</script>
					<!-- modal -->

 
                    </div>
                        <!-- /.panel-body -->
                </div>
<!-- includes 폴더에 있는 footer.jsp 파일을 추가한다. -->
<%@include file="../includes/footer.jsp" %>