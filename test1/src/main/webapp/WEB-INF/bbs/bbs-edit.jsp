<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    <title>첫번째 페이지</title>
</head>
<style>
    .container {
        width: 625px;
        margin: 50px auto;
    }
    .r-float{
        float: right;
    }
    .contents div{
        margin: 10px;
    }
    .ql-snow {
        width: 600px;
    }

    .ql-container {
        height: 400px;
    }
    
</style>

<body>
    <div id="app" class="container contents">
        <div>제목 : <input v-model="info.title"></div>
        <div>내용 : <div id="editor"></div>
        <div><button class="r-float" @click="fnSave()">저장</button></div>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                bbsNum: "${map.bbsNum}",
                userId: "${userId}",
                content: "",
                info: {}
            };
        },
        methods: {
            fnGetInfo() {
                var self = this;
                var nparmap = { bbsNum: self.bbsNum, option: "UPDATE" };
                $.ajax({
                    url: "/bbs/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        if (self.info.contents) {
                            const quill = self.quill;
                            if (quill) {
                                quill.root.innerHTML = self.info.contents;
                            }
                        }
                    }
                });
            },
            fnSave() {
                var self = this;
                var nparmap = {
                    bbsNum: self.bbsNum,
                    title:self.info.title,
                    contents: self.contents
                };
                console.log(self.contents);
                $.ajax({
                    url: "/bbs/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        if(data.result == "success"){
                            alert("저장 되었습니다.");
                            location.href="/bbs/list.do"
                        }
                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.quill = new Quill('#editor', {
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
            self.quill.on('text-change', function () {
                self.contents = self.quill.root.innerHTML;
            });
            self.fnGetInfo();
        }
    });
    app.mount('#app');
</script>