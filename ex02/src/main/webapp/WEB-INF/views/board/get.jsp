<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

	<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->			
    <div class="row">
    
    	<div class="col-lg-12">
    		<div class="panel panel-default">
    		
    		<div class="panel-heading">Board Register</div>
    			
    		<!-- /.panel-heading -->
      		<div class="panel-body">
      				
      				<div class="form-group">
      					<label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
      				</div>
      				
      				<div class="form-group">
      					<label>Title</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
      				</div>
      				
      				<div class="form-group">
      					<label>Text area</label>
      					<textarea class="form-control" rows="3" name="content" value='<c:out value="${board.content}"/>' readonly="readonly"></textarea>
      				</div>
      				
      				<div class="form-group">
      					<label>Writer</label><input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
      				</div>
					
					<button data-oper='modify' class="btn btn-default">
					<a href="/board/modify?bno=<c:out value="${board.bno}" />">Modify</a>
					</button>      				
					<button data-oper='list' class="btn btn-default">
					<a href="/board/list">List</a>
					</button>      					
      				
      		</div>		
      		<!-- /.panel-body -->		
    		
    			
    		</div>
    		<!-- /.panel panel-default -->
    		
    		
    	</div>
    	<!-- /.col-lg-12-->
    
    </div>        
    <!-- /.row -->        
   
   
   
 <%@include file="../includes/footer.jsp" %>	


