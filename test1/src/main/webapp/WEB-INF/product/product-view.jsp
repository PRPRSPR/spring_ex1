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
        <jsp:include page="../common/header.jsp" />
        <!-- header.jsp에서 헤더 데려오기 -->

        <div class="detail-container">
            <div class="image-wrapper">
                <img class="main-image" src="" alt="제품 이미지">
            </div>
            <div class="thumbnail-container">
                <img src="" alt="썸네일 이미지 1" class="thumbnail-item">
                <img src="" alt="썸네일 이미지 2" class="thumbnail-item">
                <img src="" alt="썸네일 이미지 3" class="thumbnail-item">
            </div>
            <div class="info-wrapper">
                <h1 class="product-title">{{product.itemName}}</h1>
                <p class="product-description">{{product.itemInfo}}</p>
                <p class="product-cost">₩{{product.price}}</p>
    
    
                <button class="purchase-btn">구매하기</button>
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

    const app = Vue.createApp({
        data() {
            return {
                itemNo: "${map.itemNo}",
                product: {},
                productImg:[]
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