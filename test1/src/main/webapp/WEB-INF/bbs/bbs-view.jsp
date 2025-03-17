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
    .container {
        width: 625px;
        margin: 50px auto;
    }
    .r-float{
        float: right;
    }
    #contents{
        padding: 10px;
    }
    img{
        width: 400px;
    }
</style>
<body>
	<div id="app">
		<div class="container">
            <div>
                제목 : {{info.title}}
            </div>
            <hr>
            <div>
                <span>조회수 : {{info.hit}}</span>
                <span class="r-float">작성일 : {{info.cdateTime}}</span>
            </div>
            <hr>
            <div v-for="item in fileList">
                <img :src="item.filePath">
            </div>
            <div id="contents" v-html="info.contents"></div>
            <hr>
            <button @click="fnEdit(info.contents)" v-if="sessionId==info.userId">수정</button>
            <button @click="fnBack" class="r-float">되돌아가기</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                bbsNum:"${map.bbsNum}",
                page:"${map.page}",
                sessionId:"${sessionId}",
                info:{},
                fileList:[]
            };
        },
        methods: {
            fnInfo(){
				var self = this;
				var nparmap = {
					bbsNum:self.bbsNum,
                    option:"select"
				};
				$.ajax({
					url:"/bbs/view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        self.fileList = data.fileList;
						
					}
				});
            },
            fnBack:function(){
                pageChange("/bbs/list.do",{page:this.page})
            },
            fnEdit:function(contents){
                pageChange("/bbs/edit.do",{bbsNum:this.bbsNum,userId:this.sessionId,contents:contents})
            }
        },
        mounted() {
            var self = this;
            self.fnInfo();
        }
    });
    app.mount('#app');
</script>
​