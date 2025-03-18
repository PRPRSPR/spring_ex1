<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>Gemini 챗봇</title>
</head>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background: #f4f7f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    #chat-container {
        width: 400px;
        background: white;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        overflow: hidden;
    }

    #chatbox {
        height: 400px;
        overflow-y: auto;
        padding: 15px;
        display: flex;
        flex-direction: column;
    }

    .message {
        max-width: 80%;
        padding: 10px 15px;
        margin: 5px 0;
        border-radius: 15px;
        font-size: 14px;
        word-wrap: break-word;
    }

    .user {
        background: #007bff;
        color: white;
        align-self: flex-end;
    }

    .bot {
        background: #e9ecef;
        color: black;
        align-self: flex-start;
    }

    #input-container {
        display: flex;
        padding: 10px;
        background: #fff;
        border-top: 1px solid #ddd;
    }

    input {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        outline: none;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    button {
        background: #007bff;
        color: white;
        border: none;
        padding: 10px 15px;
        margin-left: 10px;
        border-radius: 5px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #0056b3;
    }
</style>

<body>
    <div id="app">
        <div>
            <h3>Gemini 챗봇</h3>
        </div>
        <div id="chat-container">
            <div id="chatbox">
                <div v-for="msg in messages" :class="['message', msg.type]">{{ msg.text }}</div>
            </div>
            <div id="input-container">
                <input type="text" v-model="userInput" @keyup.enter="sendMessage" placeholder="메시지를 입력하세요">
                <button @click="sendMessage">전송</button>
            </div>
        </div>
    </div>
</body>

</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                userInput: '',
                messages: []
            };
        },
        methods: {
            sendMessage() {
                var self = this;
                if (!self.userInput.trim()) return;
                self.messages.push({ text: self.userInput, type: 'user' });
                var nparmap = {
                    input: self.userInput
                };
                $.ajax({
                    url: "/gemini/chat",
                    type: "GET",
                    data: nparmap,
                    success: function (response) {
                        console.log(response);
                        self.messages.push({ text: response, type: 'bot' });
                        self.userInput = '';
                        self.scrollToBottom();
                    },
                    error: function (xhr) {
                        self.messages.push({ text: "오류 발생: " + xhr.responseText, type: 'bot' });
                        self.scrollToBottom();
                    }
                });
            },
            scrollToBottom() {
                this.$nextTick(() => {
                    let chatbox = document.getElementById("chat-container");
                    chatbox.scrollTop = chatbox.scrollHeight;
                });
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>
​