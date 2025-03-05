<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <title>첫번째 페이지</title>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <div>
                아 이 디 : <input v-model="userId">
                <button @click="fnIdcheck">중복체크</button>
            </div>
            <div>
                비밀번호 : <input type="password" v-model="pwd">
            </div>
            <div>
                이 름 : <input v-model="userName">
            </div>
            <div>
                주 소 : <input v-model="address">
                <button @click="fnSearchAddr">주소검색</button>
            </div>
            <div>
                휴대폰번호 : <input v-model="phoneNum" placeholder="번호 입력">
                <button @click="fnSmsAuth">문자인증</button>
            </div>
            <div v-if="authFlg">
                <div v-if="joinFlg" style="color: red;">
                    문자인증 완료
                </div>
                <div v-else>
                    <input v-model="authInputNum" :placeholder="timer">
                    <!-- placeholder 앞에 : 붙이면 timer 변수를 그대로 불러온다 -->
                    <button @click="fnNumAuth">인증</button>
                </div>
            </div>
            <div>
                권한 :
                <label><input type="radio" v-model="status" value="C" checked>일반</label>
                <label><input type="radio" v-model="status" value="A">관리자</label>
            </div>
            <div>
                <button @click="fnJoin">가입</button>
            </div>
        </div>
    </body>

    </html>
    <script>
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            window.vueObj.fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr);
            // vue 객체를 먼저 만들어 접근
        }
        const app = Vue.createApp({
            data() {
                return {
                    userId: "",
                    pwd: "",
                    userName: "",
                    address: "",
                    status: "C",
                    phoneNum:"",
                    authNum:"",
                    // 인증번호 (서버에서 만든 랜덤 숫자)
                    authInputNum:"",
                    // 사용자가 문자로 받고 입력한 인증번호
                    authFlg:false,
                    // 인증번호 입력 상태
                    joinFlg:false,
                    // 문자 인증 완료 상태
                    timer:"",
                    count:180
                    // user : {userId:"",pwd:"",userName:"",address:"",status:"C"}
                };
            },
            methods: {
                fnJoin() {
                    var self = this;
                    if(self.joinFlg == false){
                        alert("문자 인증을 완료해주세요");
                        return;
                    }
                    var nparmap = {
                        userId: self.userId,
                        pwd: self.pwd,
                        userName: self.userName,
                        address: self.address,
                        status: self.status
                    };
                    // 위에서 user{}로 묶어놓으면 self.user 를 보낼 수 있음
                    $.ajax({
                        url: "add.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("저장되었습니다");
                                location.href = "/member/login.do"
                            }
                        }
                    });
                },
                fnIdcheck: function () {
                    var self = this;
                    if (self.userId == "") {
                        alert("아이디를 입력해주세요");
                        return;
                    }
                    // 유효성검사
                    var nparmap = {
                        userId: self.userId
                    };
                    // 위에서 user{}로 만들었으면 userId:self.user.userId 보내주기
                    $.ajax({
                        url: "idCheck.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.count == 1) {
                                alert("이미 존재하는 아이디 입니다");
                            } else {
                                alert("사용 가능한 아이디 입니다");

                            }
                        }
                    });
                },
                fnSearchAddr: function () {
                    //팝업으로 addr.do 호출
                    window.open("/addr.do", "addr", "width=500,height=500")
                },
                fnResult:function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr){
                    console.log(roadFullAddr);
                    let self = this;

                    self.address=roadFullAddr;
                },
                fnSmsAuth:function(){
                    var self = this;
                    var nparmap = {
                        phoneNum:self.phoneNum
                    };
                    $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            // 콘솔 ranStr : "217323" 출력확인
                            if(data.response.statusCode == 2000){
                                alert("문자 발송 완료");
                                self.authNum = data.ranStr;
                                self.authFlg = true;
                                setInterval(self.fnTimer,1000);
                                // 1초마다 count--;
                                if(self.count == 0){
                                    alert("인증 시간이 만료되었습니다. 잠시후 다시 시도해주세요");
                                    self.authFlg = false;
                                }
                            } else {
                                alert("잠시후 다시 시도해주세요");
                            }
                        }
                    });
                },
                fnNumAuth:function(){
                    let self = this;
                    if(self.authNum == self.authInputNum){
                        alert("인증되었습니다.");
                        self.joinFlg = true;
                    } else {
                        alert("인증번호를 다시 확인해주세요");
                    }
                },
                fnTimer:function(){
                    let self = this;

                    let min = "";
                    let sec = "";
                    min = parseInt(self.count/60);
                    sec = parseInt(self.count%60);

                    min = min < 10 ? "0"+min : min;
                    sec = sec < 10 ? "0"+sec : sec;

                    self.timer = min+":"+sec;
                    
                    self.count--;
                }
            },
            mounted() {
                var self = this;
                window.vueObj = this;
            }
        });
        app.mount('#app');
    </script>
    ​