<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="../js/page-change.js"></script>
	<title>BoardList</title>
</head>
<style>
    table, tr, td, th {
		border: 1px solid #aaa;
		text-align: center;
		border-collapse: collapse;
		padding: 10px 10px;
		margin: 10px 0;
	}
    th{
        background-color: antiquewhite;
    }
    a{
        text-decoration: none;
    }
    input,select{
        margin-right: 10px;
    }
    button{
        margin-right: 10px;
    }
    #index{
        margin-right: 5px;
        text-decoration: none;
    }
    .bgcolor{
        background-color: #ddd;
    }
    .color-blue{
        color: rgb(54, 54, 224);
    }
    .color-black{
        color: #666;
    }
    .txt{
        text-align: center;
    }
    .center {
        width: 625px;
        margin: 10px auto;
    }
    .title{
        width: 250px;
    }
    .ps{
        float: right;
        margin-top: 10px;
    }
    .addBtn{
        float: right;
    }
</style>
<body>
	<div id="app">
        <div class="center">
            <select v-model="searchOption">
                <option value="all">::전체::</option>
                <option value="title">제목</option>
                <option value="userName">작성자</option>
            </select>
            <input placeholder="검색어" @keyup.enter="fnBoardList" v-model="keyword">
            <button @click="fnBoardList">검색</button>
            <select class="ps" v-model="pageSize" @change="fnBoardList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="15">15개씩</option>
                <option value="20">20개씩</option>
            </select>
        </div>
		<table class="center">
            <tr>
                <th v-if="sessionStatus=='A'"><input type="checkbox" @click="fnAllCheck"></th>
                <th>번호</th>
                <th class="title">제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th>
            </tr>
            <tr v-for="item in list">
                <td v-if="sessionStatus=='A'"><input type="checkbox" v-model="selectList" :value="item.boardNo"></td>
                <td>{{item.boardNo}}</td>
                <td>
                    <a href="javascript:;" @click="fnView(item.boardNo)">
                        {{item.title}}
                    </a>
                </td>
                <td v-if="sessionStatus=='A' || item.userId==sessionId">
                    <a href="javascript:;" @click="fnUserInfo(item.userId)">
                        {{item.userName}}
                    </a>
                </td>
                <td v-else>
                    {{item.userName}}
                </td>
                <td>{{item.cnt}}</td>
                <td>{{item.cdateTime}}</td>
            </tr>
        </table>
        <div class="center">
            <button class="addBtn" @click="fnAdd()">글쓰기</button>
            <button v-if="sessionStatus=='A'" @click="fnRemove()">선택삭제</button>
        </div>
        <div class="txt">
            <a v-if="page != 1" id="index" href="javascript:;" class="color-black" @click="fnPageMove('prev')"> < </a>
            <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                <span v-if="page==num" class="bgcolor color-blue">
                    {{num}}
                </span>
                <span v-else class="color-black">
                    {{num}}
                </span>
            </a>
            <a v-if="page != index" id="index" href="javascript:;" class="color-black" @click="fnPageMove('next')"> > </a>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                keyword:"",
                searchOption:"all",
                sessionId:"${sessionId}",
                sessionStatus:"${sessionStatus}",
                selectList:[],
                checked:false,
                index: 0,
                pageSize: 5,
                page: 1
            };
        },
        methods: {
            fnBoardList(){
				var self = this;
				var nparmap = {
                    keyword:self.keyword,
                    searchOption:self.searchOption,
                    pageSize:self.pageSize,
                    page:(self.page-1)*self.pageSize
                };
				$.ajax({
					url:"/board/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
                        self.index = Math.ceil(data.count / self.pageSize);
					}
				});
            },
            fnAdd : function(){
				location.href="/board/add.do";
            },
            fnView:function(boardNo){
                pageChange("/board/view.do",{boardNo:boardNo})
            },
            fnUserInfo:function(userId){
                var self = this;
				var nparmap = {
                    userId:userId
                };
                $.ajax({
					url:"/member/get.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
					}
				});
            },
            fnRemove:function(){
                let self = this;
                console.log(self.selectList);
                var nparmap = {
                    // selectList:self.selectList
                    selectList:JSON.stringify(self.selectList)
                };
                // json 형태의 문자로 보냄.
                $.ajax({
					url:"/board/remove-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("삭제되었습니다.");
                        self.fnBoardList();
					}
				});
            },
            fnAllCheck:function(){
                let self = this;
                self.checked = !self.checked;
                // false > true, true > false
                if(self.checked){
                    // true일 때 실행
                    for(let i=0; i<self.list.length; i++){
                        self.selectList.push(self.list[i].boardNo)
                        // 리스트에 보드넘버 채우기
                    }
                } else {
                    self.selectList = [];
                    // false 일때 리스트 값 비우기 (체크해제)
                }
            },
            fnPage:function(num){
                let self = this;
                self.page = num;
                self.fnBoardList();
            },
            fnPageMove:function(direction){
                let self = this;
                if(direction == "next"){
                    self.page++;
                } else {
                    self.page--;
                }
                self.fnBoardList();
            }
        },
        mounted() {
            var self = this;
            self.fnBoardList();
        }
    });
    app.mount('#app');
</script>
​