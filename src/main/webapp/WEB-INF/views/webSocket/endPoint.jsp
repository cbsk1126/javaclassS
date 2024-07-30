<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
	  let socket;
	
	  function startChat() {
		  $("#endChatBtn").show();
      const username = document.getElementById('username').value;
      if (username) {
        socket = new WebSocket('ws://192.168.50.20:9090/javaclassS/webSocket/endPoint/' + username);

        socket.onmessage = (event) => {
        	if (event.data.startsWith("USER_LIST:")) {
            updateUserList(event.data.substring(10));
          } 
        	else {
	          const item = document.createElement('li');
	          item.textContent = event.data;
	          document.getElementById('messages').appendChild(item);
	          window.scrollTo(0, document.body.scrollHeight);
        	}
        };
        
        // 웹소켓 접속을 종료할때 처리되는 코드
        socket.onclose = () => {
          alert('채팅창에서 접속을 종료합니다.');
          document.getElementById('chat').style.display = 'none';
          document.getElementById('username').style.display = 'block';
          document.querySelector('button[onclick="startChat()"]').style.display = 'block';
        };

        // 소켓 접속후 기본 아이디를 화면에 출력시켜주고 있다.(접속 종료후도 계속 유지된다.)
        document.getElementById('chat').style.display = 'block';
        document.getElementById('username').style.display = 'none';
        document.querySelector('button[onclick="startChat()"]').style.display = 'none';
        document.getElementById('currentId').innerHTML = '<font color="red"><b>${sMid}</b></font>';
      }
	  }
	  
	  // 채팅 종료버튼을 클릭하면 소켓을 닫도록 처리한다.
	  function endChat() {
      location.reload();	// 다시 reload하므로서 새롭게 세션이 생성되기에 기존 세션이 사라져서 접속사용자 아이디도 리스트상에서 제거되게 된다.
      /* 소켓을 완전히 종료시키려면 아래코드를 추가해도 된다.
	    if (socket) {
        socket.close();
        $("#endChatBtn").hide();
	    }
      */
		}
	  
	  // 사용자가 새롭게 추가되거나 접속종료시에 회원목록을 업데이트 한다.
	  function updateUserList(userList) {
	    const users = userList.split(",");
	    const usersElement = document.getElementById('users');
	    usersElement.innerHTML = '';  // Clear current list
	    users.forEach(user => {
        //const item = document.createElement('li');
        const item = document.createElement('li');
        item.textContent = user;
        usersElement.appendChild(item);
	    });
		}
	
	  // 폼이 모두 로드되고 나면 아래 루틴을 처리해서 채팅접속자의 아이디를 화면에 출력할수 있게처리한다.
	  document.addEventListener('DOMContentLoaded', () => {
      const form = document.getElementById('form');
      form.addEventListener('submit', (e) => {
        e.preventDefault();		// 이전 스크립트 내용은 무시하고 아래의 내용을 처리하게 한다.
        const target = document.getElementById('target').value;
        const input = document.getElementById('input').value;
        if (target && input) {
          socket.send(target + ":" + input);
          const item = document.createElement('li');
          item.textContent = "To " + target + ": " + input;
          document.getElementById('messages').appendChild(item);
          document.getElementById('input').value = '';
        }
      });
	  });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <label for="username">접속중인 사용자 : <span id="currentId"></span></label>
  <input type="text" id="username" value="${sMid}" readonly />
  <button onclick="startChat()">채팅시작</button>
  <button onclick="endChat()" id="endChatBtn" class="ml-3" style="display:none;">채팅종료</button> <!-- 채팅 종료 버튼 -->
  <div id="chat" style="display:none;">
    <h2>현재 접속중인 사용자</h2>
      <!-- <ul id="users"></ul> -->
      <p id="users"></p>
      <h3>메세지</h3>
      <ul id="messages"></ul>
      <form id="form">
        <input id="target" autocomplete="off" placeholder="받는회원 아이디" />
        <input id="input" autocomplete="off" placeholder="메세지를 입력하세요." />
        <button>메세지보내기</button>
      </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>