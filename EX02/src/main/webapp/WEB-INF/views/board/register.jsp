<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
    
    
<!--  includes폴더의 header.jsp 파일을 추가한다. -->
<%@include file = "../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register                            
                        </div>
                        <!-- /.panel-heading -->
            
                        <div class="panel-body">
                            <form action="/board/register" method="post">
								<div class ="form-group">
									<label>Title</label>
									<input class="form-control" name="title">
								</div>
								<div class ="form-group">
									<label>Content</label>
									<textarea rows="3" name="content" class="form-control"></textarea>
								</div>
								<div class ="form-group">
									<label>Writer</label>
									<input class="form-control" name="writer">
								</div>
								<button type="submit" class="btn btn-info">등록</button>
								<button type="reset" class="btn btn-info">취소</button>
                           </form>
                        </div>
                    </div>
                </div>
                        <!-- /.panel-body -->
<!-- includes 폴더에 있는 footer.jsp 파일을 추가한다. -->
<%@include file="../includes/footer.jsp" %>