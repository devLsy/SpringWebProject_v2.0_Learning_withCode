<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<%@include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">	
<title>Sign Up</title>	
</head>	
<body>

<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Join to Member</h1>
                </div>
                <!-- /.col-lg-12 -->
</div>


<sec:authorize access="permitAll">
<form id="signUpForm" action="/board/signUpProcess" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="row">	
    
    	<div class="col-lg-12">
    		<div class="panel panel-default">
    			
    		<div class="panel-heading">Membership registration form</div>
    			
    		<!-- /.panel-heading -->
      		<div class="panel-body">	
      				<div class="form-group">
      					<label>UserId</label>
      					<input type="text" class="form-control" name="userid" value=''>
      				</div>
      				
      				<div class="form-group">
      					<label>UserName</label>
      					<input type="text" class="form-control" name="userName" value=''>
      				</div>
      				
      				<div class="form-group">		
      					<label>Password</label>		
      					<input type="password" class="form-control" name="userpw" value=''>
      				</div>
					
					<button type="submit" id="submit" class="btn btn-info">Submit Button</button>
					<input type="reset" id="reset" class="btn btn-default" value="Reset Button">	
</form>
</sec:authorize>
      		</div>			
      		<!-- /.panel-body -->			
    	</div>	
		<!-- /.panel panel-default -->
    		<!--  ./panel panel-default -->
    </div>
    	<!-- /.col-lg-12-->
</div>

<script>
	$(document).ready(function() {
		// 회원가입 등록 버튼
		$("#submit").on("click", function(e) {
				
			
			
		});			
				
		
			
		
			
		
	});
</script>









</body>
</html>            
<%@include file="../includes/footer.jsp" %>    			