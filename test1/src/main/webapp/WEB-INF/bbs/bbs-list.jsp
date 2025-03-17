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
    }
    table, tr, td, th {
		border: 1px solid #aaa;
		text-align: center;
		border-collapse: collapse;
		padding: 10px 10px;
		margin: 10px auto;
	}
    a{
        text-decoration: none;
    }
    .color-red{
        color: red;
    }
    .color-black{
        color: black;
    }
    .r_btn{
        float: right;
    }
    .center {
        width: 525px;
        margin: 10px auto;
    }
    .bgcolor{
        background-color: #f1f5fa;
    }
    .color-blue{
        color: rgb(41, 41, 172);
    }
    .color-black{
        color: #666;
    }
    .txt{
        text-align: center;
    }
    #index{
        margin-right: 5px;
        text-decoration: none;
    }
</style>
<body>
	<div id="app" class="container color-black">
		<table>
            <tr>
                <th>선택</th>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회</th>
            </tr>
            <tr v-for="item in list">
                <td><input type="radio" v-model="selectBbs" :value="item.bbsNum"></td>
                <td>{{item.bbsNum}}</td>
                <td v-if="item.hit >= 30">
                    <a href="javascript:;" @click="fnView(item.bbsNum)" class="color-red">{{item.title}}</a>
                </td>
                <td v-else>
                    <a href="javascript:;" @click="fnView(item.bbsNum)" class="color-black">{{item.title}}</a>
                </td>
                <td>{{item.userName}}</td>
                <td>{{item.cdateTime}}</td>
                <td>{{item.hit}}</td>
            </tr>
        </table>
        <div class="center">
            <button @click="fnAdd" class="r_btn">글쓰기</button>
            <button @click="fnRemove">삭제</button>
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
                list:[],
                selectBbs:"",
                index: 0,
                pageSize: 5,
                page: 1,
                backPage:"${map.page}"
            };
        },
        methods: {
            fnBbsList(){
				var self = this;
				var nparmap = {
					pageSize:self.pageSize,
                    page:(self.page-1)*self.pageSize
				};
				$.ajax({
					url:"/bbs/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list=data.list;

                        self.index = Math.ceil(data.count / self.pageSize);
					}
				});
            },
            fnAdd:function(){
                location.href="/bbs/add.do";
            },
            fnRemove:function(){
                var self = this;
                if(!confirm("정말 삭제하시겠습니까?")){
                    return;
                }
				var nparmap = {
					bbsNum:self.selectBbs
				};
				$.ajax({
					url:"/bbs/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.result == "success"){
                            alert("삭제되었습니다.");
                            self.fnBbsList();
                        }
					}
				});
            },
            fnView:function(bbsNum){
                pageChange("/bbs/view.do",{bbsNum:bbsNum,page:this.page});
            },
            fnPage:function(num){
                let self = this;
                self.page = num;
                self.fnBbsList();
            },
            fnPageMove:function(direction){
                let self = this;
                if(direction == "next"){
                    self.page++;
                } else {
                    self.page--;
                }
                self.fnBbsList();
            }
        },
        mounted() {
            var self = this;
            if(self.backPage != ""){
                self.page = self.backPage;
            }
            self.fnBbsList();
        }
    });
    app.mount('#app');
</script>