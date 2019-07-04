/**
 *  답변 관련 js 모듈화
console.log("Reply Module...");
 */

/*즉시 실행 함수*/
var replyService = (function() {
	
	/*댓글 추가*/
	function add(reply, callback) {
		/*console.log("reply.................");*/
		
		$.ajax({
			type: 'post',
			url: '/replies/new',	
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	/*댓글 전체목록 조회*/
	function getList(param, callback, error) {
	
		var bno = param.bno;
		var page = param.page || 1;	
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if(callback) {
						//callback(data); // 댓글 목록만 가져오는 경우
						callback(data.replyCnt, data.list);	// 댓글 숫자, 목록 둘다 가져오는 경우
						/*console.log("replyCnt: " + data.replyCnt);*/
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	/*댓글 삭제*/	
	function remove(rno, replyer, callback, error) {
		
		console.log("--------------------------------------");  
		console.log(JSON.stringify({rno:rno, replyer:replyer}));  
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			data:  JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			}, 
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	/*댓글 수정*/	
	function update(reply, callback, error) {
		console.log(JSON.stringify(reply));
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	/*댓글 조회*/
	function get(rno, callback, error) {

		$.get("/replies/" + rno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	/*날짜 표시*/
	function displayTime(timeValue) {
		var today = new Date();
		/*console.log("timeValue: " + timeValue);*/
		
		
		var gap = today.getTime() - timeValue;
		/*console.log("today - timeValue: " + gap);*/
		
		var dateObj = new Date(timeValue);
		/*console.log("dateObj: " + dateObj);*/
		var str = "";
		
		/*24시간 지나지 않은 댓글*/
		if(gap < (1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi  = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
				
			return [(hh > 9 ? '' : '0' ) + hh, ':', (mi > 9 ? '' : '0') + mi, ':' , (ss > 9 ? '' : '0') + ss].join('');
		
		/*24시간 지난 댓글*/	
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
		}
	};
	
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
})();



		