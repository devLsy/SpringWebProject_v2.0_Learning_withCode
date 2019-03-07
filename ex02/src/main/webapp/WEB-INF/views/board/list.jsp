<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">	
<title>boardList</title>	
</head>	
<body>
			<div class="panel-heading">
				Board List Page
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
			</div>
			<!-- /.panel-heading -->
			
			
			
	<table class="table table-striped table-bordered table-hover">
			<caption>게시판 리스트</caption>
			<colgroup>
				<col width="100">
				<col>	
				<col width="110">
				<col width="100">	
				<col width="80">	
			</colgroup>
			<thead>		
				<tr>	
					<th scope="col">글번호</th>
					<th scope="col">제목</th>
					<th scope="col">내용</th>	
					<th scope="col">작성자</th>			
					<th scope="col">작성일</th>			
					<th scope="col">수정일</th>			
				</tr>	
			</thead>	
			<tbody>
				<c:forEach items="${list}" var="board">	
						<tr>	
							<td><c:out value="${board.bno}"/></td>						
							<td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>
							<c:out value="${board.title}"/></a></td>						
							<td><c:out value="${board.content}"/></td>						
							<td><c:out value="${board.writer}"/></td>							
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>						
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>						
						</tr>
				</c:forEach>		
			</tbody>			
	</table>
	
	<!-- Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Modal title</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
	
	
	
	
<script>
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';	
			console.log("result: " + result);
					
			checkModal(result);
			
			// 모달관련 function
			function checkModal(result) {
				
				if(result == "") {
					return;
				}	
				
				if(parseInt(result) > 0) {
					$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
				}
				
				$("#myModal").modal("show");
			}
			
			// 등록 버튼 이벤트 리스너
			$("#regBtn").on("click", function() {
				self.location = "/board/register";	
			});		
			
			
				
			
		}); 
		// end of $(document).ready(function()
	
	
</script>
</body>
</html>            
<%@include file="../includes/footer.jsp" %>    		