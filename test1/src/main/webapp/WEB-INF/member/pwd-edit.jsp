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
            비밀번호 : <input type="password" v-model="pwd">
        </div>
        <div>
            비밀번호 확인 : <input type="password" v-model="pwdCheck">
        </div>
        <div>
            <button @click="fnEditPwd">변경</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                userId:"${map.userId}",
                pwd:"",
                pwdCheck:""
            };
        },
        methods: {
            fnEditPwd(){
				var self = this;
                if(self.pwd == ""){
                    alert("비밀번호를 입력해주세요");
                    return;
                }
                if(self.pwd != self.pwdCheck){
                    alert("비밀번호를 확인해주세요");
                    return;
                }
				var nparmap = {
                    userId:self.userId,
					password:self.pwd
				};
				$.ajax({
					url:"/member/editPwd.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result == "success"){
                            alert("변경되었습니다");
                            location.href="/member/login.do"
                        } else{
                            alert("오류발생");
                            console.log(self.userId);
                            console.log(self.pwd);
                            console.log(self.pwdCheck);
                        }
					}
				});
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>
​