<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <title>쇼핑몰 헤더</title>
        <link rel="stylesheet" href="../css/product-style.css">
    </head>

    <body>
        <div id="header">
            <header>
                <div class="logo">
                    <img src="logo.png" alt="쇼핑몰 로고">
                </div>

                <nav>
                    <ul>
                        <li class="dropdown">
                            <a href="#">한식</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">비빔밥</a></li>
                                <li><a href="#">김치찌개</a></li>
                                <li><a href="#">불고기</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">중식</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">짜장면</a></li>
                                <li><a href="#">짬뽕</a></li>
                                <li><a href="#">마파두부</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">양식</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">피자</a></li>
                                <li><a href="#">파스타</a></li>
                                <li><a href="#">스테이크</a></li>
                            </ul>
                        </li>
                        <li><a href="#">디저트</a></li>
                        <li><a href="#">음료</a></li>
                    </ul>
                </nav>
                <div class="search-bar">
                    <input type="text" placeholder="상품을 검색하세요...">
                    <button>검색</button>
                </div>
                <div class="login-btn">
                    <button>로그인</button>
                </div>
            </header>
        </div>
    </body>

    </html>
    <script>
        const header = Vue.createApp({
            // 다른 jsp파일에서 불러왔을때 충돌날 수 있음. app >> header
            data() {
                return {

                };
            },
            methods: {
                fnLogin() {
                    var self = this;
                    var nparmap = {};
                    $.ajax({
                        url: "login.dox",
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
            }
        });
        header.mount('#header');
    </script>