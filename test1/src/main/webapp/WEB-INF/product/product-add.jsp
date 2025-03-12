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
    <div id="app">
        <!-- 헤더 -->
        <jsp:include page="../common/header.jsp" />

        <!-- 제품 등록 기능 -->
        <div class="body">
            <div class="form-container">
                <div class="form-group">
                    <label for="itemName">제품명:</label>
                    <input class="form-input" id="itemName" v-model="itemName" placeholder="제품명을 입력하세요">
                </div>
                <!-- <div>
                    <input type="file" id="file1" name="file1" accept=".jpg, .png">
                    멀티플 지원 X 썸네일용
                </div> -->
                <div>
                    <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
                </div>
                <div class="form-group">
                    <label for="price">가격:</label>
                    <input class="form-input" id="price" v-model="price" placeholder="가격을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="itemInfo">설명:</label>
                    <textarea class="form-input" id="itemInfo" v-model="itemInfo"
                        placeholder="제품설명을 입력하세요"></textarea>
                </div>
                <div class="form-group">
                    <button class="form-button" @click="fnAddProduct">제품 등록</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                itemName: "",
                price: "",
                itemInfo: ""
            };
        },
        methods: {
            fnAddProduct() {
                var self = this;
                var nparmap = {
                    itemName: self.itemName,
                    price: self.price,
                    itemInfo: self.itemInfo
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        // data 안에 itemNo 들어있음
                        if (data.result == "success") {
                            if ($("#file1")[0].files.length > 0) {
                                var form = new FormData();
                                for (let i = 0; i < $("#file1")[0].files.length; i++) {
                                    form.append("file1", $("#file1")[0].files[i]);
                                }
                                form.append("itemNo", data.itemNo);
                                self.upload(form);
                            }
                            alert("등록되었습니다.");
                        } else {
                            alert("등록실패");
                            console.log(self.itemName);
                            console.log(self.price);
                            console.log(self.itemInfo);
                        }
                    }
                });
            },
            upload: function (form) {
                var self = this;
                $.ajax({
                    url: "/product/fileUpload.dox"
                    , type: "POST"
                    , processData: false
                    , contentType: false
                    , data: form
                    , success: function (response) {
                        location.href = "/product/list.do";
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