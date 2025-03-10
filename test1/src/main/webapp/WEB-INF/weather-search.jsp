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
    span{
        margin-right: 20px;
    }
</style>
<body>
	<div id="app">
		<div>
            <span>
                시 : 
                <select v-model="selectSi" @change="fnSi">
                    <option value="">::선택::</option>
                    <option v-for="item in siList" :value="item.si">{{item.si}}</option>
                </select>
            </span>
            <span>
                구 : 
                <select v-model="selectGu" @change="fnArea">
                    <option value="">::선택::</option>
                    <option v-for="item2 in guList" :value="item2.gu">{{item2.gu}}</option>
                </select>
            </span>
            <span>
                동 : 
                <select v-model="selectDong" @change="fnArea">
                    <option value="">::선택::</option>
                    <option v-for="item3 in dongList" :value="item3.dong">{{item3.dong}}</option>
                </select>
            </span>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
              siList:[],
              guList:[],
              dongList:[],
              selectSi:"",
              selectGu:"",
              selectDong:""
            };
        },
        methods: {
            fnArea(){
				var self = this;
				var nparmap = {
					selectSi:self.selectSi,
					selectGu:self.selectGu
				};
				$.ajax({
					url:"/search/Area.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.siList = data.siList;
						self.guList = data.guList;
						self.dongList = data.dongList;
					}
				});
            },
            fnSi(){
				var self = this;
                self.selectGu = "";
                self.selectDong = "";
				self.fnArea();
            }
        },
        mounted() {
            var self = this;
            self.fnArea();
        }
    });
    app.mount('#app');
</script>
​