<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">	
<title>boardList</title>	
</head>	
<body>	
			<sec:authorize access="isAnonymous()">
			<div class="panel-heading">
				<button id='signUp' type="button" class="btn btn-info pull-left">sign Up</button>
			</div>		
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.username" var="user_id" />
					<div class="panel-heading loginArea">welcome~! <span class="userArea">${user_id}</span></div>
			</sec:authorize>		
							
			<div class="panel-heading">
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
			</div>
			<!-- /.panel-heading -->
						
	<table class="table table-striped table-bordered table-hover">
			<caption>boardList</caption>
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
					<!-- <th scope="col">내용</th> -->	
					<th scope="col">작성자</th>			
					<th scope="col">작성일</th>			
					<th scope="col">수정일</th>			
				</tr>	
			</thead>	
			<tbody>
				<c:forEach items="${list}" var="board">	
						<tr>	
							<td><c:out value="${board.bno}"/></td>						
							<td><a class="move" href='<c:out value="${board.bno}"/>'>
										<c:out value="${board.title}"/>	
											<b>[ <c:out value="${board.replyCnt}" /> ]</b>
									</a>
							</td>						
							<%-- <td><c:out value="${board.content}"/></td> --%>						
							<td><c:out value="${board.writer}"/></td>							
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>						
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>						
						</tr>
				</c:forEach>		
			</tbody>			
	</table>
	
	<div class="row">
		<div class="col-lg-12">
			
			<form id='searchForm' action="/board/list" method="get">
				<select name='type' id="selectBox">
					<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>선택 해주세요.</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" />>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />>내용</option>
					<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" />>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" />>제목 or 내용</option>
					<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" />>제목 or 작성자</option>
					<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
				</select>
				<input id="keyWord" type="text" name='keyWord' value='<c:out value='${pageMaker.cri.keyWord}' />'/>	
				<input type="hidden" name='pageNum' value="${pageMaker.cri.pageNum}"/>	
				<input type="hidden" name='amount' value="${pageMaker.cri.amount}"/>	
				<button class="btn btn-default">Search</button>
			</form>
		</div>	
		<!-- / .col-lg-12-->			
	</div>
	<!--  / .row -->	
	
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
	
	
	<!-- pagination -->
	<div class='pull-right'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">Previous</a></li>
			</c:if>	
			
			<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">	
				<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
					<a href="${num}">${num}</a></li>			
			</c:forEach>
			
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next">
					<a href="${pageMaker.endPage + 1}">Next</a></li>	
			</c:if>
					
			
		
		
		
		
		
		
		
		</ul>
	</div>
	<!-- end of pagination add -->
	
	
	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}' />">
		<input type="hidden" name="keyWord" value="<c:out value='${pageMaker.cri.keyWord}' />">
	</form>
	
	
		
	
	
	
<script>
		$(document).ready(function() {
			var result = '<c:out value="${result}"/>';	
			console.log("result: " + result);
			
			checkModal(result);
			
			history.replaceState({}, null, null);
			
			// 모달관련 function
			function checkModal(result) {
				
				if(result == "" || history.state) {
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
			
			// 회원가입 버튼 이벤트 리스너
			$("#signUp").on("click", function() {
				self.location = "/board/sign_up";	
			});		
				
			var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click", function(e) {
				e.preventDefault();
					
				console.log('click');
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click", function(e) {
				
				e.preventDefault();
				actionForm
				.append("<input type='hidden' name='bno' value='"
						+ $(this).attr("href")+ "'>");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			});	
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				
				if(!searchForm.find("option:selected").val()) {
					alert("검색종류를 선택 하세요.");
					return false;
				}
				
				if(!searchForm.find("input[name='keyWord']").val()) {
					alert("키워드를 입력 하세요.");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				
				searchForm.submit();	
			});
			
				
					
		}); 
		// end of $(document).ready(function()
	
	
</script>
</body>
</html>            
<%@include file="../includes/footer.jsp" %>    		