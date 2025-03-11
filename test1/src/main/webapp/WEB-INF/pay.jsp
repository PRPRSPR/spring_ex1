<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <title>view 기본 세팅 파일</title>
    </head>
    <style>
    </style>

    <body>
        <div id="app">
            <button @click="fnPayment()">결제</button>
        </div>
    </body>

    </html>
    <script>
        const userCode = "imp40283074"; //고객사 식별코드
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {

                };
            },
            methods: {
                fnPayment() {
                    IMP.request_pay({
                        // pg: "html5_inicis",
                        // pay_method: "card",
                        // merchant_uid: "merchant_"+ new Date().getTime(),
                        // name: "테스트 결제",
                        // amount: 1,
                        // buyer_tel: "010-0000-0000",
                        channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                        pay_method: "card",
                        merchant_uid: "merchant_"+ new Date().getTime(),
                        name: "테스트 결제",
                        amount: 1,
                        buyer_tel: "010-0000-0000",

                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("성공");
                            console.log(rsp);
                        } else {
                            // 결제 실패 시
                            alert("실패");
                            console.log(rsp);
                        }
                    });
                }
            },
            mounted() {

            }
        });
        app.mount('#app');
    </script>