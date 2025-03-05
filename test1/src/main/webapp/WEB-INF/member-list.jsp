<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
	table, tr, td, th {
		border: 1px solid black;
		text-align: center;
		border-collapse: collapse;
		padding: 10px 10px;
		margin: 10px 0;
	}
</style>
<body>
	<div id="app">
		<!-- 3. 테이블 만들기 -->
		<table>
			<tr>
				<th>선택</th>
				<th>아이디</th>
				<th>이름</th>
				<th>주소</th>
				<th>삭제</th>
			</tr>
			<tr v-for="item in list">
				<!-- 4. 반복문으로 테이블에 데이터 채우기-->
				<td><input type="checkbox" v-model="selectList" :value="item.userId"></td>
				<td>{{item.userId}}</td>
				<td>{{item.userName}}</td>
				<td>{{item.address}}</td>
				<td><button @click="fnRemove(item.userId)">삭제</button></td>
				<!-- 5. 삭제버튼으로 함수 호출 -->
			</tr>
		</table>
		<button @click="fnSelectRemove">선택삭제</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
              list:[],
			  // 1. list 변수 선언
			  selectList:[]
            };
        },
        methods: {
            fnMemberList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					// url:"member/list.dox", >> member가 중복되는 상황.
					// '/member/list.dox', 'list.dox' 사용
					url:"list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.list);
						self.list = data.list;
						// 2. 만든 변수에 전송받은 data.list 담기
					}
				});
            },
			
			fnRemove : function(userId){
				// 6. 함수 만들기 ajax 그대로 가져오기
				var self = this;
				var nparmap = {userId:userId};
				// 7. 파라메터 보내기
				$.ajax({
					url:"remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result == "success"){
							alert("삭제되었습니다");
							self.fnMemberList();
						}
					}
				});
			},
			fnSelectRemove:function(){
				var self = this;
				var nparmap = {selectList:JSON.stringify(self.selectList)};
				$.ajax({
					url:"remove-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result == "success"){
							alert("삭제되었습니다");
							self.fnMemberList();
						}
					}
				});
			}
        },
        mounted() {
            var self = this;
			self.fnMemberList();
        }
    });
    app.mount('#app');
</script>
​