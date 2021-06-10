var replyService = (function(){
	
//	function add(reply, callback, error) {
//		$.ajax({
//			type: 'post',
//			url: '/replies/new',
//			data: JSON.stringify(reply),
//			contentType: "application/json; charset=utf-8",
//			success: function(result, status, xhr){
//				if(callback){
//					callback(result);
//				}
//			},
//			error: function(xhr, status, er){
//				if(error){
//					error(er);
//				}
//			}
//		})
//		return {
//			add : add
//		};
//	}
	
	// 댓글 목록 (data, 성공했을 때 처리하는 함수의 이름, 실패했을 때 처리하는 함수의 이름)
	function getList(param, callback, error){
		var bno = param.bno;

//		위와 아래와 같은 의미다.
//		var page;
//		if(param.page){
//			page = param.page;
//		} else {
//			page = 1;
//		}

		// js는 값이 있는 경우 1 
		var page = param.page || 1; // page가 없으면 1로 설정, page가 있으면 page로 설정
		
		// getJSON(서버의 주소, 서버에서 날라오는 데이터.실패한 경우)
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
		function(data){ // 서버에서 날라오는 data
			if(callback){
				callback(data); // callback 함수가 있으면, callback 함수 호출(data를 넘겨준다.)
			}
		}).fail(function(xhr, status, err){
			if(error){
					error(); // error 함수가 있으면 error 함수 호출
				}
			}); // 함수 getList에 parameter로 받는 error가 없다.(getJSON에서 error가 발생한 경우를 정의 했기 때문이다.)
	
    	}    
    	
    return {
    // 객체 속성 값 이름 : 함수 이름
    	// add: add,
    	getList : getList
    };
})(); // 즉시 실행 함수

// 즉시 실행 함수 호출 하는 방법 (객체 속성 값 이름을 불러온다.) 
// replyService.getList();