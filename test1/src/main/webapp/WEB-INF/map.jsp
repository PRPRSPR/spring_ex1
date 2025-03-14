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
        <div id="map" style="width:500px;height:400px;"></div>
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b11d0cfc04c4c20450d241190fb11da0&libraries=services"></script>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                infowindow: null,
                map: null,
                ps: null,
                markers:[]
            };
        },
        methods: {
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < data.length; i++) {
                        displayMarker(data[i]);
                    }
                }
            },
            displayMarker(place) {
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(place.y, place.x)
                });

                kakao.maps.event.addListener(marker, 'click', function () {
                    infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                    infowindow.open(map, marker);
                });
            }
        },
        mounted() {
            var self = this;

            var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
            var map = new kakao.maps.Map(mapContainer, mapOption);
            var ps = new kakao.maps.services.Places(map);

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.491004, 126.720718), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };
            self.ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true });
        }
    });
    app.mount('#app');
</script>
​