<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

	<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->			
    <div class="row">
    
    	<div class="col-lg-12">
    		<div class="panel panel-default">
    		
    		<div class="panel-heading">Board Read</div>
    			
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
      					<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}" /></textarea>
      				</div>
      				
      				<div class="form-group">
      					<label>Writer</label><input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
      				</div>
					
					<button data-oper='modify' class="btn btn-default">
					<a href="<%-- /board/modify?bno=<c:out value="${board.bno}" /> --%>">Modify</a>
					</button>      				
					<button data-oper='list' class="btn btn-info">
					<a href="/board/list">List</a>
					</button>      		
					
					<form id="operForm" action="/board/modify" method="get">
						<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
  						<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  						<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
  						<input type='hidden' name='keyWord' value='<c:out value="${cri.keyWord}"/>'>
  						<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
					</form>
      					
      		</div>		
      		<!-- /.panel-body -->			
    		
    			
    		</div>	
    		<!-- /.panel panel-default -->
    		
    		<div class="panel panel-default">
    			<div class="panel-heading">
    				<i class="fa fa-comments fa-fw"></i> Reply
    				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
    			</div>
    				
    			
    			
    			
    			<!-- ./panel-heading -->
				
				<div class="panel-body">
					<ul class="chat">
						<!-- start reply -->
						<li class="left clearfix"></li>
						<!-- reply(e) -->	
					</ul>
					<!--  ul(e) -->
				</div>
				<!-- ./panel .chat-panel -->
				
				<div class="panel-footer">
					
					
					
				</div>
				
    		</div>
    		<!--  ./panel panel-default -->
    	</div>
    	<!-- /.col-lg-12-->
    </div>        
    <!-- /.row -->        


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
            		<label>Reply</label>
            		<input class="form-control" name="reply" value="newReply!!!">
            	</div>
            	<div class="form-group">
            		<label>Replyer</label>
            		<input class="form-control" name="replyer" value="replyer">
            	</div>
            	<div class="form-group">
            		<label>Reply Date</label>
            		<input class="form-control" name="replyDate" value=''>
            	</div>
            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-primay">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- srcript -->
<script src="/resources/js/reply.js"></script>
<script>
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	/* console.log(replyService); */
	
	$("button[data-oper='modify']").on("click", function(e) {
		e.preventDefault();
		operForm.attr("action", "/board/modify").submit();
			
	});
	
	$("button[data-oper='list']").on("click", function(e) {
		
		e.preventDefault();
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
			
	});
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
		showList(1); 	
		/* console.log("bno : " + bnoValue + "\n" + "replyUL : " + replyUL); */		
	
	/* 전체 댓글 목록조회해서 동적으로 생성 */
	function showList(page) {
			console.log("page: " + page);
			
			replyService.getList({bno:bnoValue, page: page || 1}, function(list) {
			
			console.log("replyCnt: " + replyCnt);	
			console.log("list: " + list);	
			console.log(list);	
			
			if(page == -1) {
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			if(list == null || list.length == 0) {
				replyUL.html("");
				
				return;
			}	
				
			for(var i = 0, len = list.length || 0; i < len; i++) {
				str += "<li class='left clearfix' data-rno=' "+list[i].rno+" '> ";
				/* 댓글 작성자 */
				str += "    <div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong></div>";
				/* 댓글작성 날짜*/
				str += " <smal class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</smal></div>";
				/* 댓글내용 */
				str += "<p>" + list[i].reply+"</p></div></li>";
			}	
			
				
			/* console.log("str: " + str); */
			replyUL.html(str);
			showReplyPage(replyCnt);
		});	
		/* end function */
	} 	
	/* end showList() */
	
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	/* 댓글 페이징 표시 */
	function showReplyPage(relyCnt) {
		
		var endNum = Math.ceil(pageNum / 10.0);
		console.log("endNum: " + endNum);
		var startNum = endNum - 9;
		console.log("startNum: " + startNum);
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt / 10.0);
		}
		
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		
		if(prev) {
			str += "<li class='page-item'><a class='page-link' href='  " + (startNum -1) + " '>Previous</a></li>";
		}

		for(var i = startNum; i <= endNum; i++) {
			
			var active = pageNum == 1 ? "active" : "";
			
			str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}		
		
		if(next) {
			str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";	
		}
	
		str += "</ul><div>";
		console.log("str: " + str);
		
		replyPageFooter.html(str);
}
	
	
	
	
	
	
	
	
			
	var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
	
    /* 모달창 닫기 */
    $("#modalCloseBtn").on("click", function(e) {
    	modal.modal('hide');
    });
    
	/* 답변 등록 버튼 클릭*/	
    $("#addReplyBtn").on("click", function(e){
        
        modal.find("input").val("");
        modalInputReplyDate.closest("div").hide(); 
        modal.find("button[id !='modalCloseBtn']").hide(); 
        	
        modalRegisterBtn.show();
        
        $(".modal").modal("show");
        
	});
	
	/* 새로운 댓글 등록 처리 */	
	modalRegisterBtn.on('click', function(e) {
		
		var reply = {
						reply: modalInputReply.val(),
						replyer: modalInputReplyer.val(),
						bno: bnoValue
					};
		replyService.add(reply, function(result) {
		
			alert(result);
				
			modal.find("input").val("");	
			modal.modal("hide");
			
			/* 전체 댓글 조회 갱신 */
			/* showList(1); */
			showList(-1);
			
		});
	});
	
	/* 댓글 클릭 이벤트 처리 */
	$(".chat").on("click", "li", function(e){
	      
	      var rno = $(this).data("rno");
	      /* console.log(rno); */
	      replyService.get(rno, function(reply){
	      
	        modalInputReply.val(reply.reply);
	        modalInputReplyer.val(reply.replyer);
	        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
	        .attr("readonly","readonly");
	        modal.data("rno", reply.rno);
	        
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();
	        	
	        $(".modal").modal("show");
	            	
	      });
	  });
	
	/* 댓글 수정 */
	modalModBtn.on("click", function(e) {
		
		var reply = {rno: modal.data("rno"), reply: modalInputReply.val()};
		console.log(reply); 
		
		replyService.update(reply, function(result) {
			
			alert(result);
			modal.modal("hide");
			showList(1);	
		});
			
	});
	
	/* 댓글 삭제 */
	modalRemoveBtn.on("click", function (e){
	   	  
	   	  var rno = modal.data("rno");
	   	  
	   	  replyService.remove(rno, function(result){
	   	        
	   	      alert(result);
	   	      modal.modal("hide");
	   	      showList(1);
	   	      			
	   	  });
	});
	
	
	
	
});

</script>
   
   
 <%@include file="../includes/footer.jsp" %>	