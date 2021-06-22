var replyService=(function(){
	//목록
	function getList(param, callback, error) {
	    var bno = param.bno;
	    var page = param.page || 1;	    
	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
	        function(data) {
	        console.log("data.replyCnt:"+data.replyCnt);
	        console.log(data.list);	    	 
	          if (callback) {
	            //callback(data); // 댓글 목록만 가져오는 경우 
	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
	          }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }	
	//시간변환
	function displayTime(timeValue){
		var today=new Date();
		var gap=today.getTime()-timeValue;
		var dateObj=new Date(timeValue);
		var str="";
		//현재시간과 댓글작성시간 차이(gap)가 24시간 이내인 경우
		if(gap<(1000*60*60*24)){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();			
			return [(hh>9?'':'0')+hh,':',(mi>9?'':'0')+mi,':',(ss>9?'':'0')+ss].join('');
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;
			var dd=dateObj.getDate();			
			return [yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
		}	
	}	
	//등록
	function add(reply,callback,error){
		$.ajax({
			type:'post',
			url:'/replies/new',
			data:JSON.stringify(reply),
			contentType:'application/json; charset=utf-8',
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}	
	//상세보기
	function get(rno,callback,error){
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(){
			if(error){
				error();
			}
		});
	}	
	//수정
	function update(reply,callback,error){
		$.ajax({
			type:'put',
			url:'/replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:'application/json; charset=utf-8',
			success:function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}	
	//삭제
	function remove(rno,callback,error){
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,			
			success:function(deleteResult,status,xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}
		});
	}		
	return {
		getList:getList,
		displayTime:displayTime,
		add:add,
		get:get,
		update:update,
		remove:remove
	}
})();//즉시실행함수


// 간소화
// var replyService = {
// 	getList:function(param, callback, error) {

// 	    var bno = param.bno;
// 	    var page = param.page || 1;
	    
// 	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
// 	        function(data) {
// 	        console.log("data.replyCnt:"+data.replyCnt);
// 	        console.log(data.list);	    	 
// 	          if (callback) {
// 	            //callback(data); // 댓글 목록만 가져오는 경우 
// 	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
// 	          }
// 	        }).fail(function(xhr, status, err) {
// 	      if (error) {
// 	        error();
// 	      }
// 	    });
// 	},
// 	displayTime:function(timeValue) {
// 		var today=new Date();
// 		var gap=today.getTime()-timeValue;
// 		var dateObj=new Date(timeValue);
// 		var str="";
// 		//현재시간과 댓글작성시간 차이(gap)가 24시간 이내인 경우
// 		if(gap<(1000*60*60*24)){
// 			var hh=dateObj.getHours();
// 			var mi=dateObj.getMinutes();
// 			var ss=dateObj.getSeconds();
			
// 			return [(hh>9?'':'0')+hh,':',(mi>9?'':'0')+mi,':',(ss>9?'':'0')+ss].join('');
// 		}else{
// 			var yy=dateObj.getFullYear();
// 			var mm=dateObj.getMonth()+1;
// 			var dd=dateObj.getDate();
			
// 			return [yy,'/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
// 		}	
// 	},
// 	add:function(reply,callback,error){
// 		$.ajax({
// 			type:'post',
// 			url:'/replies/new',
// 			data:JSON.stringify(reply),
// 			contentType:'application/json; charset=utf-8',
// 			success:function(result,status,xhr){
// 				if(callback){
// 					callback(result);
// 				}
// 			},
// 			error:function(xhr,status,er){
// 				if(error){
// 					error(er);
// 				}
// 			}
// 		});
// 	},
// 	get:function(rno,callback,error){
// 		$.get("/replies/"+rno+".json",function(result){
// 			if(callback){
// 				callback(result);
// 			}
// 		}).fail(function(){
// 			if(error){
// 				error();
// 			}
// 		});
// 	},
// 	update:function(reply,callback,error){
// 		$.ajax({
// 			type:'put',
// 			url:'/replies/'+reply.rno,
// 			data:JSON.stringify(reply),
// 			contentType:'application/json; charset=utf-8',
// 			success:function(result,status,xhr){
// 				if(callback){
// 					callback(result);
// 				}
// 			},
// 			error:function(xhr,status,er){
// 				if(error){
// 					error(er);
// 				}
// 			}
// 		});
// 	},
// 	remove:function(rno,callback,error){
// 		$.ajax({
// 			type:'delete',
// 			url:'/replies/'+rno,			
// 			success:function(deleteResult,status,xhr){
// 				if(callback){
// 					callback(deleteResult);
// 				}
// 			},
// 			error:function(xhr,status,er){
// 				if(error){
// 					error(er);
// 				}
// 			}
// 		});
// 	}
// };



//호출방법
//replyService.getList();