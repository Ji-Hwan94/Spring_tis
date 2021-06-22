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
                            Board List Page
                            <a href="/board/register" class="btn btn-primary pull-right btn-xs">글쓰기</a>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}"/></td>
                                		<td width="800">
                                			<a class="move" href='<c:out value="${board.bno}"/>'>
                                				<c:out value="${board.title}"/> <span class="badge"><c:out value="${board.replyCnt != 0 ? board.replyCnt : null}" /></span> 
                                			</a>
                                		</td>
                                		<td><c:out value="${board.writer}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>                                		
                                	</tr>
                                </c:forEach>
                            </table>
                            <!-- /.table-responsive -->
                            <!-- 검색 ----------------------------------------------------------------------->
                            <div class="row">
                            	<div class="col-lg-12">
                            		<form id="searchForm" action="/board/list" method="get">
                            			<select name="type">
                            				<option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}"/>>--</option>
                            				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
                            				<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
                            				<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
                            				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>  
                            			</select>
                            			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                            			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            			<button class="btn btn-primary">Search</button>
                            		</form>
                            	</div>
                            </div>
                            <!-- 검색 -->
                            
                            <!-- paging -------------------------------------------------------------------->
                            <div class="pull-right">
                            	<ul class="pagination">
                            		<c:if test="${pageMaker.prev}">
                            			<li class="paginate_button previous">
                            				<a href="${pageMaker.startPage-1}">Previous</a>
                            			</li>
                            		</c:if>
                            		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            			<li class="paginate_button ${pageMaker.cri.pageNum==num?'active':''}">
                            				<a href="${num}">${num}</a>
                            			</li>
                            		</c:forEach>
                            		<c:if test="${pageMaker.next}">
                            			<li class="paginate_button next">
                            				<a href="${pageMaker.endPage+1}">Next</a>
                            			</li>
                            		</c:if>
                            	</ul>
                            </div>
                            
                            <form id="actionForm" action="/board/list" method="get">
                            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                            	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                            </form>
                            
                            <!-- paging -->
                            
                            
                            
                            
                            <!-- modal ---------------------------------------------------------------------->                           
							<div id="myModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title">Modal Header</h4>
							      </div>
							      <div class="modal-body">
							        <p>처리가 완료되었습니다</p>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>							        
							      </div>
							    </div>							
							  </div>
							</div>
							<script>
								$(document).ready(function(){
									var result="<c:out value="${result}"/>";
									checkModal(result);//모달창띄우기
									
									history.replaceState({}, null, null); //history객체 state를 null로 세팅
									
									function checkModal(result){
										if(result=='' || history.state){ // history.state가 null이면 중지
											return;
										}
										if(parseInt(result)>0){
											$(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다");
										}
										$("#myModal").modal("show");
									}
									
									var actionForm=$("#actionForm");
									$(".paginate_button a").on("click",function(e){
										e.preventDefault();//다른페이지로 이동을 막는다.
										//hidden태그에 클릭한 페이지번호를 저장한다.
										actionForm.find("input[name='pageNum']").val($(this).attr("href"));
										//전송
										actionForm.submit();
									});
									
									$(".move").on("click",function(e){
										e.preventDefault();
										actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
										actionForm.attr("action","/board/get"); //action변경
										actionForm.submit();
									});
									
									//같은 엘리먼트를 여러번 탐색할 필요가 있을 때는 미리 찾아서 레퍼런스에 저장했다가
									//레퍼런스를 다시 사용하는 것이 속도 향상에 도움이 됨									
									var searchForm=$("#searchForm");
									$("#searchForm button").on("click",function(e){
										e.preventDefault();//전송방지
										
										if(!searchForm.find("option:selected").val()){
											alert("검색종류를 선택하세요");
											return;
										}
										if(!searchForm.find("input[name='keyword']").val()){
											alert("키워드를 입력하세요");
											return;
										}
										searchForm.find("input[name='pageNum']").val("1");
										searchForm.submit();
									});
								});
									
							
							</script>
                            <!-- modal -->
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
        <%@include file="../includes/footer.jsp" %>