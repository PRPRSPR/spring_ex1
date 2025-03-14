<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="../js/page-change.js"></script>
    <title>첫번째 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="../common/header.jsp" />

    <div id="app">
        <div class="product-list body">
            <div class="product-card" v-for="item in list">
                <img :src="item.filePath" alt="">
                <h3 class="product-name">{{item.itemName}}</h3>
                <p class="product-info">{{item.itemInfo}}</p>
                <p class="product-price">₩{{item.price}}</p>
                <button class="buy-button" @click="fnProductView(item.itemNo)">구매하기</button>
            </div>
            <!-- <div class="product-card">
                <img src="../img/블루투스 이어폰_커널형.png" alt="블루투스 이어폰">
                <h3 class="product-name">블루투스 이어폰</h3>
                <p class="product-price">₩ 30,000</p>
                <button class="buy-button">구매하기</button>
            </div>
            <div class="product-card">
                <img src="../img/게이밍 마우스.jpg" alt="게이밍 마우스">
                <h3 class="product-name">게이밍 마우스</h3>
                <p class="product-price">₩ 50,000</p>
                <button class="buy-button">구매하기</button>
            </div>
            <div class="product-card">
                <img src="../img/기계식 키보드.jpg" alt="기계식 키보드">
                <h3 class="product-name">기계식 키보드</h3>
                <p class="product-price">₩ 100,000</p>
                <button class="buy-button">구매하기</button>
            </div> -->
        </div>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list:[]
            };
        },
        methods: {
            fnProductList(keyword) {
                var self = this;
                console.log(keyword);
                var nparmap = {
                    keyword:keyword
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            },
            fnProductView:function(itemNo){
                pageChange("/product/view.do",{itemNo:itemNo})
            }
        },
        mounted() {
            var self = this;
            self.fnProductList();
        }
    });
    app.mount('#app');
</script>