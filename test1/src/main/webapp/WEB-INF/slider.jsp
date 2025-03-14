<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>첫번째 페이지</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.js"></script>
</head>
<style>
</style>

<body>
    <div id="app">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><img src=""></div>
                <div class="swiper-slide"><img src=""></div>
                <div class="swiper-slide"><img src=""></div>
            </div>
            <div class="swiper-pagination"></div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        </div>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                swiper: null
            };
        },
        methods: {

        },
        mounted() {
            var self = this;
            swiper = new Swiper('.swiper-container', {
                // 기본 옵션 설정
                loop: true, // 반복
                autoplay: {
                    delay: 2500,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                //                 // 옵션
                // 1. loop
                // 설명: 슬라이드 반복
                // 값: true, false

                // loop: true // 슬라이드가 끝나면 처음으로 돌아감

                // 2. autoplay
                // 설명: 자동 전환
                // 값: true, { delay: <시간> }

                // autoplay: {
                //   delay: 3000,  // 3초마다 자동으로 전환
                // }

                // 3. effect
                // 설명: 전환 효과
                // 값: "slide", "fade", "cube", "coverflow", "flip"

                // effect: 'fade'  // 슬라이드 전환 시 페이드 효과

                // 4. slidesPerView
                // 설명: 한 번에 표시되는 슬라이드 개수
                // 값: 숫자, "auto"

                // slidesPerView: 3  // 한 번에 3개의 슬라이드 표시

                // 5. spaceBetween
                // 설명: 슬라이드 간 간격
                // 값: 숫자 (px)

                // spaceBetween: 10  // 슬라이드 간 간격 10px

                // 6. pagination
                // 설명: 페이지네이션
                // 값: 객체 ({ el: <요소>, clickable: true/false })

                // pagination: {
                //   el: '.swiper-pagination',
                //   clickable: true,  // 클릭 가능하게 설정
                // }

                // 7. navigation
                // 설명: 네비게이션 버튼
                // 값: 객체 ({ nextEl: <다음>, prevEl: <이전> })

                // navigation: {
                //   nextEl: '.swiper-button-next',
                //   prevEl: '.swiper-button-prev',
                // }

                // 8. centeredSlides
                // 설명: 슬라이드 중앙 정렬
                // 값: true, false

                // centeredSlides: true  // 슬라이드가 중앙에 정렬

                // 9. grabCursor
                // 설명: 드래그 커서 손 모양
                // 값: true, false

                // grabCursor: true 

                // 10. breakpoints
                // 설명: 반응형 옵션
                // 값: 객체 (화면 크기별 설정)

                // breakpoints: {
                //   640: {
                //     slidesPerView: 1,  // 화면 너비가 640px 이하일 때, 슬라이드 1개 표시
                //   },
                //   768: {
                //     slidesPerView: 2,  // 화면 너비가 768px 이하일 때, 슬라이드 2개 표시
                //   },
                //   1024: {
                //     slidesPerView: 3,  // 화면 너비가 1024px 이상일 때, 슬라이드 3개 표시
                //   }
                // }
            });
        }
    });
    app.mount('#app');
</script>
​