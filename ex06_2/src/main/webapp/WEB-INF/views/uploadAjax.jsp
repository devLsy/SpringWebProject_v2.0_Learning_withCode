<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.uploadResult { width: 100%; background-color: gray; }
.uploadResult ul { display: flex; flex-flow: row; justify-content: center; align-items: center; }
.uploadResult ul li { list-style: none; padding: 10px; align-content: center; text-align: center;}
.uploadResult ul li img { width: 100px;}
.uploadResult ul li span {color: white; cursor: pointer;}
.bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center; top:0%; width: 100%; height: 100%; background-color: gray; z-index: 100;}
.bigPicture {position: relative; display: flex; justify-content: center; align-items: center;}
.bigPicture img {width: 600px;}
</style>
</head>	
<body>
<h1>Upload With Ajax</h1>

<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
</div>

<div class="uploadResult">
	<ul>
	
	</ul>
</div>

<div class="bigPictureWrapper">
	<div class="bigPicture"></div>
</div>

<button id="uploadBtn">Upload</button>




<script>

function showImage(fileCallPath) {
 	/* alert(fileCallPath); */
 	$(".bigPictureWrapper").css("display", "flex").show();
 	
 	$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'> ").animate({width: '100%', height: '100%'}, 1000); 
 	
 	$(".bigPictureWrapper").on("click", function(e) {
 		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
 		/* chrome에서는 정상 동작 */
 		/* setTimeout( () => {$(this).hide();}, 1000 ) */
 		/*  */
 		setTimeout(function() {
 			$(".bigPictureWrapper").hide();
 		}, 1000);
 	});	
} 

$(document).ready(function() {
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 524288000; 
	
	function checkExtension(fileName, fileSize) {

		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");	
			return false;
		}

		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var cloneObj = $(".uploadDiv").clone();
	/* console.log(cloneObj); */	
	
	$("#uploadBtn").on("click", function(e) {
		
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
			
		for(var i = 0; i < files.length; i++) {
			
			if(!checkExtension(files[i].name, files[i].size) ) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					alert("File upload Success!!");	
					
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());	
				}	
		});
	});
	
	var uploadResult = $(".uploadResult ul");
	/* console.log(uploadResult); */
	
function showUploadedFile(uploadResultArr){
	    
	    var str = "";
	    
	    $(uploadResultArr).each(function(i, obj){
	        
	        if(!obj.image){
	          
	          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
	          console.log("not_image_fileCallPath: " + fileCallPath);
	          str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
	           "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
	           "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
	           "<div></li>"
	        }else{
	          
	          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "\\s_"+obj.uuid +"_"+obj.fileName);
	          
	          var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
	          originPath = originPath.replace(new RegExp(/\\/g),"/");
	          
	          console.log("image_fileCallPath: " + fileCallPath);
	          console.log("originPath: " + originPath);
	          str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
              "<img src='display?fileName="+fileCallPath+"'></a>"+
              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
              "<li>";
	        }
	    });
	    
	    uploadResult.append(str);
	  
	  }
	
	$(".uploadResult").on("click", "span", function(e) {
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			dataType: 'text',
			type: 'POST',
				success: function(result) {
					alert(result);
				}
		}); // end ajax
	
	});
	
	  
		
});	
	

</script>
</body>
</html>