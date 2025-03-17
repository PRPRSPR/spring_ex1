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
    <title>첫번째 페이지</title>
</head>
<style>
    .container {
        width: 600px;
        margin: 20px auto;
    }

    div {
        margin-top: 20px;
    }

    .ql-snow {
        width: 600px;
    }

    .ql-container {
        height: 400px;
    }
</style>

<body>
    <div id="app" class="container">
        <div>제목 : <input v-model="title"></div>
        <div id="editor"></div>
        <hr>
        <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
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
            fnAdd() {
                var self = this;
                var nparmap = {
                    title: self.title,
                    contents: self.contents,
                    userId: self.sessionId
                };
                $.ajax({
                    url: "/bbs/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data.bbsNum);
                        if (data.result == "success") {
                            alert("저장되었습니다.");
                            if ($("#file1")[0].files.length > 0) {
                                var form = new FormData();
                                for (let i = 0; i < $("#file1")[0].files.length; i++) {
                                    form.append("file1", $("#file1")[0].files[i]);
                                }
                                form.append("bbsNum", data.bbsNum);
                                self.upload(form);
                            } else {
                                location.href = "/bbs/list.do";
                            }
                        }
                    }
                });
            },
            upload: function (form) {
                var self = this;
                $.ajax({
                    url: "/bbs/fileUpload.dox"
                    , type: "POST"
                    , processData: false
                    , contentType: false
                    , data: form
                    , success: function (response) {
                        location.href = "/bbs/list.do";
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
                    ]
                }
            });

            quill.on('text-change', function () {
                self.contents = quill.root.innerHTML;
            });
        }
    });
    app.mount('#app');
</script>