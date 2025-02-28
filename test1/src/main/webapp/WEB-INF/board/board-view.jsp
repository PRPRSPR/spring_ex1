<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="../js/page-change.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
            제목 : {{info.title}}
        </div>
		<div>
            내용 : {{info.contents}}
        </div>
		<div>
            조회수 : {{info.cnt}}
        </div>
        <div v-if="info.userId == sessionId || sessionStatus == 'A'">
            <button @click="fnEdit()">수정</button>
            <button @click="fnRemove()">삭제</button>
        </div>
        <div>
            <button @click="fnBack()">되돌아가기</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
              boardNo:"${map.boardNo}",
              // Controller에서 보낸 값 {boardNo:boardNo}
              info:{},
              // 단일객체. map으로 넘어옴 {}
              sessionId:"${sessionId}",
              sessionStatus:"${sessionStatus}"
            };
        },
        methods: { 
            fnGetBoard(){
				var self = this;
				// var nparmap = {boardNo:self.boardNo};
				var nparmap = {boardNo:self.boardNo, option:"SELECT"};
                // 수정 버튼 눌러도 조회수 증가. 파라메터 하나 더 보내 조건주기.
                // view >> select || edit >> update
				$.ajax({
					url:"/board/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
					}
				});
            },
            fnEdit:function(){
                pageChange("/board/edit.do",{boardNo:this.boardNo,sessionId:this.sessionId})
            },
            fnRemove:function(){
                var self = this;
				var nparmap = {boardNo:self.boardNo};
                if(!confirm("정말 삭제하시겠습니까?")){
                    return;
                }
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.result == "success"){
                            alert("삭제되었습니다");
                            location.href="/board/list.do";
                        }
					}
				});
            },
            fnBack:function(){
                location.href="/board/list.do";
            }
        },
        mounted() {
            var self = this;
            self.fnGetBoard();
        }
    });
    app.mount('#app');
</script>
​