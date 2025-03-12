<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="../css/header.css">
    <style>
        
    </style>
</head>

<body>
    <div id="header">
        <header>
            <!-- 로고 -->
            <div class="logo">
                <a href="/product/list.do">
                    <img src="https://mblogthumb-phinf.pstatic.net/MjAyMjEyMTVfMTg4/MDAxNjcxMDkwNTc1ODM5.72xNKr7Hvw77FSfnoIFYYCoRneDoxXIH5jqXXA3T5v8g.5rfVNPZ9_DVsOO4sDPenHZ7L_e6kYh1SHUkzqRjjnL4g.PNG.y2kwooga/%EB%84%A4%EC%9D%B4%EB%B2%84_AI-18.png?type=w800" alt="쇼핑몰 로고">
                </a>
            </div>

            <!-- 네비게이션 메뉴 -->
            <nav>
                <ul>
                    <li class="dropdown">
                        <a class="link" href="#">PC</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">키보드</a></li>
                            <li><a href="#">마우스</a></li>
                            <li><a href="#">모니터</a></li>
                            <li><a href="#">부품/악세서리</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="link" href="#">Phone</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">이어폰</a></li>
                            <li><a href="#">스마트워치</a></li>
                            <li><a href="#">무선충전패드</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="link" href="#">가정용</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">손난로</a></li>
                            <li><a href="#">가습기</a></li>
                            <li><a href="#">냉풍기</a></li>
                        </ul>
                    </li>
                    <li><a class="link" href="#">기타</a></li>
                    <li><a class="link" href="#">고객지원</a></li>
                </ul>
            </nav>

            <!-- 검색 바 -->
            <div class="search-bar">
                <input type="text" placeholder="상품을 검색하세요...">
                <button>검색</button>
            </div>

            <!-- 로그인 버튼 -->
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>
    </div>

    <script>
        const header = Vue.createApp({
            data() {
                return {
                    list: []
                };
            },
            methods: {},
            mounted() {
                var self = this;
            }
        });
        header.mount('#header');
    </script>
</body>

</html>