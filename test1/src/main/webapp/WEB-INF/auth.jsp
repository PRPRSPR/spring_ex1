<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <script src="../js/page-change.js"></script>
        <title>view 기본 세팅 파일</title>
    </head>
    <style>
        button{
            margin: 50px 50px;
        }
    </style>

    <body>
        <div id="app">
            <button @click="fnAuth()">본인인증</button>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp40283074"; //고객사 식별코드
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    userId:"${map.userId}"
                };
            },
            methods: {
                fnAuth() {
                    let self = this;
                    IMP.certification({
                        channelKey: "channel-key-f1df3d67-9d42-42fd-84ce-f980e164925c",
                        merchant_uid: "merchant_"+ new Date().getTime(),
                    // });
                    }, function(rsp){
                        if (rsp.success) {
                            alert("성공");
                            console.log(rsp);
                            pageChange("/member/editPwd.do",{userId:self.userId})
                        } else {
                            // alert("실패");
                            alert(rsp.error_msg);
                            console.log(rsp);
                        }
                    });
                }
            },
            mounted() {
                let self = this;
                console.log(self.userId);
            }
        });
        app.mount('#app');
    </script>