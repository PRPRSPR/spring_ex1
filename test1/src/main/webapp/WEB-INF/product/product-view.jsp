<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>첫번째 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>
<style>
</style>

<body>
    <jsp:include page="../common/header.jsp" />
    <!-- header.jsp에서 헤더 데려오기 -->

    <div id="app">
        <div class="detail-container body" v-if="productImg.thumbnail == 'Y'">
            <div class="image-wrapper">
                <img class="main-image" :src="productImg.filePath" alt="제품 이미지">
            </div>
            <div class="thumbnail-container" v-for="img in productImg">
                <img :src="img.filePath" alt="제품 설명 이미지" class="thumbnail-item">
            </div>
            <div class="info-wrapper">
                <h1 class="product-title">{{product.itemName}}</h1>
                <p class="product-description">{{product.itemInfo}}</p>
                <p class="product-cost">₩{{product.price}}</p>


                <button class="purchase-btn" @click="fnPayment">구매하기</button>
            </div>
        </div>
    </div>
</body>

</html>
<script>
    const thumbnails = document.querySelectorAll('.thumbnail-item');
    const mainImage = document.querySelector('.main-image');

    thumbnails.forEach((thumbnail) => {
        thumbnail.addEventListener('click', (e) => {
            mainImage.src = e.target.src;
        });
    });
    const userCode = "imp40283074"; //고객사 식별코드
    IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
                itemNo: "${map.itemNo}",
                product: {},
                productImg: [],
                sessionId:"${sessionId}"
            };
        },
        methods: {
            fnProductView() {
                var self = this;
                var nparmap = {
                    itemNo: self.itemNo
                };
                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data.product);
                        console.log(data.productImg);
                        self.product = data.product;
                        self.productImg = data.productImg;

                    }
                });
            },
            fnPayment() {
                let self = this;
                IMP.request_pay({
                    channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                    pay_method: "card",
                    merchant_uid: "merchant_" + new Date().getTime(),
                    name: "테스트 결제",
                    amount: self.product.price,
                    buyer_tel: "010-0000-0000",

                }, function (rsp) { // callback
                    if (rsp.success) {
                        // 결제 성공 시
                        alert("성공");
                        self.fnPaymentHistory(rsp.merchant_uid);
                        console.log(rsp);
                    } else {
                        // 결제 실패 시
                        alert("실패");
                        console.log(rsp);
                    }
                });
            },
            fnPaymentHistory:function(merchant_uid){
                var self = this;
                var nparmap = {
                    orderId:merchant_uid,
                    userId:self.sessionId,
                    amount:self.product.price,
                    itemNo:self.itemNo
                };
                $.ajax({
                    url: "/product/payment.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);

                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.fnProductView();
        }
    });
    app.mount('#app');
</script>
​