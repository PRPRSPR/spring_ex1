<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>첫번째 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>

<body>
    <jsp:include page="../common/header.jsp" />
    <!-- header.jsp에서 헤더 데려오기 -->

    <div id="app">
        <div class="detail-container body">
            <!-- 메인 이미지 표시 -->
            <div class="image-wrapper" v-if="mainImage">
                <img class="main-image" :src="mainImage" alt="제품 이미지">
                <!-- 썸네일 이미지들 -->
                <div class="thumbnail-container" v-if="productImg.length > 0">
                    <div v-for="(img, index) in productImg" :key="index">
                        <!-- 'thumbnail' 속성 존재 확인 -->
                        <div v-if="img && img.thumbnail && img.thumbnail === 'N'">
                            <img :src="img.filePath" alt="제품 설명 이미지" class="thumbnail-item" 
                                 @click="swapImages(img, index)">
                        </div>
                    </div>
                </div>
            </div>
    
            <!-- 제품 정보 표시 -->
            <div class="info-wrapper">
                <h1 class="product-title">{{ product.itemName }}</h1>
                <p class="product-description">{{ product.itemInfo }}</p>
                <p class="product-cost">₩{{ product.price }}</p>
                <button class="purchase-btn" @click="fnPayment">구매하기</button>
            </div>
        </div>
    </div>    
</body>

<script>
    const userCode = "imp40283074"; // 고객사 식별코드
    
    document.addEventListener("DOMContentLoaded", function () {
        if (typeof IMP !== 'undefined') {
            IMP.init(userCode);  // 결제 시스템 초기화
        } else {
            console.error('IMP is not loaded properly');
        }
    });

    const app = Vue.createApp({
    data() {
        return {
            itemNo: "${map.itemNo}",
            product: {},
            productImg: [],
            sessionId: "${sessionId}",
            mainImage: "",
            prevMainImage: ""
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
                    self.productImg = data.productImg || [];

                    if (self.productImg.length > 0) {
                        const thumbnailImage = self.productImg.find(img => img.thumbnail === 'Y');
                        if (thumbnailImage) {
                            self.mainImage = thumbnailImage.filePath;
                        } else if (self.productImg[0] && self.productImg[0].filePath) {
                            self.mainImage = self.productImg[0].filePath;
                        }
                    }
                },
                error: function (err) {
                    console.error('상품 정보 로딩 오류:', err);
                }
            });
        },

        fnPayment() {
            let self = this;
            if (typeof IMP === 'undefined') {
                console.error('IMP is not initialized');
                return;
            }

            IMP.request_pay({
                channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b", // 결제 시스템 키
                pg: "html5_inicis",
                pay_method: "card", // 결제 수단
                merchant_uid: "merchant_" + new Date().getTime(),
                name: "테스트 결제",
                amount: self.product.price,
                buyer_tel: "010-0000-0000", // 구매자 전화번호
            }, function (rsp) { // 결제 결과 콜백
                if (rsp.success) {
                    alert("결제 성공");
                    self.fnPaymentHistory(rsp.merchant_uid);
                    console.log(rsp);
                } else {
                    alert("결제 실패");
                    console.log(rsp);
                }
            });
        },

        fnPaymentHistory: function (merchant_uid) {
            var self = this;
            var nparmap = {
                orderId: merchant_uid,
                userId: self.sessionId,
                amount: self.product.price,
                itemNo: self.itemNo
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
        },

        swapImages(clickedImg, index) {
            if (this.mainImage !== clickedImg.filePath) {
                this.prevMainImage = this.mainImage;
                this.mainImage = clickedImg.filePath;

                this.productImg[index].filePath = this.prevMainImage;
            }
        }
    },
    mounted() {
        var self = this;
        self.fnProductView();
    }
});
app.mount('#app');

</script>
</html>
