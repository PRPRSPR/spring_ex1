<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <title>BoardAdd</title>
    </head>
    <style>
        div {
            margin-top: 20px;
        }

        .ql-snow {
            width: 600px;
        }

        .ql-container {
            height: 400px;
        }

        .container {
            width: 600px;
            margin: 20px auto;
        }
    </style>

    <body>
        <div id="app" class="container">
            <div>제목 : <input v-model="title"></div>
            <!-- <div>내용 : <textarea v-model="contents" cols="50" rows="20"></textarea></div> -->
            <div id="editor"></div>
            <!-- quill 사용해 내용 입력부분 변경 -->
            <div>
                <!-- <input type="file" id="file1" name="file1"> -->
                <input type="file" id="file1" name="file1" accept=".jpg, .png">
            </div>
            <hr>
            <div><button @click="fnAdd()">등록</button></div>
        </div>
    </body>

    </html>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    title: "",
                    contents: "",
                    sessionId: "${sessionId}"
                };
            },
            methods: {
                fnAdd: function () {
                    var self = this;
                    var nparmap = {
                        title: self.title,
                        contents: self.contents,
                        sessionId: self.sessionId
                    };
                    $.ajax({
                        url: "/board/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("저장되었습니다");
                                if($("#file1")[0].files.length > 0){
                                    // 첨부파일이 있을 때
                                    var form = new FormData();
                                    form.append("file1", $("#file1")[0].files[0]);
                                    form.append("boardNo", data.boardNo);
                                    self.upload(form);
                                } else {
                                    location.href = "/board/list.do";
                                }
                                // ajax 통신은 비동기 통신 >> 파일 용량이 크면 업로드 중 다음 코드 실행해버림
                                // upload메소드 실행 완료 시 이동하도록, 혹은 파일 업로드가 없을때 이동
                                // location.href = "/board/list.do";
                            }
                        }
                    });
                },
                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {
                            location.href = "/board/list.do";
                        }
                    });
                }
            },
            mounted() {
                var self = this;
                var quill = new Quill('#editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                            ['link', 'image'],
                            ['clean'],
                            [{ 'color': [] }, { 'background': [] }]
                            // 글자색, 배경색 변경 추가
                        ]
                    }
                });

                // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                quill.on('text-change', function () {
                    // app.contents = quill.root.innerHTML;
                    self.contents = quill.root.innerHTML;
                });
            }
        });
        app.mount('#app');
    </script>
    ​