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
    div{
        margin: 10px 0;
    }
    button{
        margin-right: 10px;
    }
    #contents{
        margin: 25px 50px;
        text-align: center;
    }
    .center {
        width: 625px;
        margin: 50px auto;
    }
    .box{
        border: 1px solid #999;
        padding: 30px;
    }
    .btn{
        float: right;
    }
    #comment{
        margin: 25px;
    }
    template{
        float: right;
    }
    img{
        width: 400px;
    }
</style>
<body>
	<div id="app">
        <div class="center">
            <div class="box">
                <div>
                    제목 : <strong>{{info.title}}</strong>
                </div>
                <div>
                    <!-- 내용 : {{info.contents}} -->
                    내용 : 
                    <div v-for="item in fileList">
                        <img :src="item.filePath">
                    </div>
                    <div id="contents" v-html="info.contents"></div>
                </div>
            </div>
            <div>
                조회수 : {{info.cnt}}
            </div>
            <!-- <table id="comment-table">
                <tr>
                    <th>작성자</th>
                    <th>댓글 내용</th>
                </tr>
                <tr v-for="item in commentList">
                    <th>{{item.userId}}</th>
                    <td>
                        <label>
                            {{item.contents}}
                        </label>
                    </td>
                </tr>
            </table> -->
            <hr>
            <div id="comment" v-for="item in commentList">
                {{item.userName}} : 
                <span v-if="editCommentNo == item.commentNo"><input v-model="editContents"></span>
                <span v-else>{{item.contents}}</span>
                <label class="btn" v-if="item.userId == sessionId || sessionStatus == 'A'">
                    <span v-if="editCommentNo == item.commentNo">
                        <button @click="fnUpdateCmt(item.commentNo)">저장</button>
                        <button @click="fnCancelCmt()">취소</button>
                    </span>
                    <span v-else>
                        <button @click="fnEditCmt(item)">수정</button>
                        <button @click="fnRemoveCmt(item.commentNo)">삭제</button>
                    </span>
                </label>
            </div>
            <hr>
            <div>
                <textarea v-model="comment" cols="70" rows="5"></textarea>
                <button class="btn" @click="fnCmtSave">등록</button>
            </div>
            <div class="btn" v-if="info.userId == sessionId || sessionStatus == 'A'">
                <button @click="fnEdit()">수정</button>
                <button @click="fnRemove()">삭제</button>
            </div>
            <div>
                <button @click="fnBack()">되돌아가기</button>
            </div>
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
                sessionStatus:"${sessionStatus}",
                commentList:[],
                comment:"",
                editCommentNo:null,
                editContents:"",
                fileList:[]
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
                        self.commentList = data.commentList;
                        self.fileList = data.fileList;
                        self.comment="";
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
            },
            fnCmtSave:function(){
                let self = this;
                let nparmap = {
                    boardNo: self.boardNo,
                    sessionId:self.sessionId,
                    comment: self.comment
                };
                $.ajax({
                    url:"/board/addCmt.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.result == "success"){
                            alert("등록되었습니다");
                            self.fnGetBoard();
                        }
					}
                });
            },
            fnEditCmt:function(item){
                let self = this;
                self.editCommentNo = item.commentNo;
                self.editContents = item.comment;
            },
            fnCancelCmt:function(){
                let self = this;
                self.editCommentNo = null;
            },
            fnUpdateCmt:function(commentNo){

            },
            fnRemoveCmt:function(commentNo){

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