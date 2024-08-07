<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
/*
	// 로그인창에 아이디 체크 유무에 대한 처리
	// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
*/
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberLogin.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>	<!-- 카카오로그인 js파일 -->
  <script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>		<!-- 네이버로그인 js파일 -->
  <script>
    'use strict';
    
    $(function(){
    	$("#searchPassword").hide();
    });
    
    // 비밀번호 찾기
    function pwdSearch() {
    	$("#searchPassword").show();
    }
    
    // 임시비밀번호 등록시켜주기
    function newPassword() {
    	let mid = $("#midSearch").val().trim();
    	let email = $("#emailSearch2").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
    		$("#midSearch").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberNewPassword",
    		type : "post",
    		data : {
    			mid   : mid,
    			email : email
    		},
    		success:function(res) {
    			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
  				location.reload();
    		},
    		error : function() {
    			alert("전송오류!!")
    		}
    	});
    }
    
    // 카카오 로그인(자바스크립트 앱키 등록)
    window.Kakao.init("158c673636c9a17a27b67c95f2c6be5c");
    
    function kakaoLogin() {
    	window.Kakao.Auth.login({
    		scope: 'profile_nickname, account_email',
    		success:function(autoObj) {
    			console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...");
    			window.Kakao.API.request({
    				url : '/v2/user/me',
    				success:function(res) {
    					const kakao_account = res.kakao_account;
    					console.log(kakao_account);
    					location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
    				}
    			});
    		}
    	});
    }
    
    // QR 로그인
    function qrLogin() {
    	let mid = myform.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요\n아이디 분실시는 QR로그인할수 없습니다.");
    		return false;
    	}
    	let url = "${ctp}/member/qrLogin?mid="+mid;
      let windowName = "childWindow";
      let windowWidth = 250;
      let windowHeight = 400;
      let x = (window.screen.width / 2) - (windowWidth / 2);
      let y = (window.screen.height / 2) - (windowHeight / 2);
      let opt = "width="+windowWidth+"px, height="+windowHeight+"px, left="+x+", top="+y;

      newWin = window.open(url, windowName, opt);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2"><font size="5">로 그 인</font></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" value="${mid}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" value="1234" required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="로그인" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
          <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary mr-4"/>
          <a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakao_login_medium_narrow.png" width="150px"/></a>
          <input type="button" value="QR 로그인" onclick="qrLogin()" class="btn btn-outline-primary mr-4"/>
          <!-- <input type="button" value="네이버 로그인" onclick="" class="btn btn-success mr-4"/> -->
          <span id="naver_id_login"></span>
        </td>
      </tr>
    </table>
    <table class="table table-bordered p-0">
      <tr>
        <td class="text-center">
	    		<input type="checkbox" name="idSave" checked /> 아이디 저장 &nbsp;&nbsp;&nbsp;
          [<a href="javascript:midSearch()">아이디 찾기</a>] /
          [<a href="javascript:pwdSearch()">비밀번호 찾기</a>]
        </td>
      </tr>
    </table>
  </form>
  <div id="searchPassword">
    <hr/>
  	<table class="table table-bordered p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>비밀번호 찾기</b></font>
  	      (가입시 입력한 아이디와 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>아이디</th>
  	    <td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="새비밀번호발급" onclick="newPassword()" class="btn btn-secondary form-control" placeholder="메일주소를 입력하세요"/>
  	    </td>
  	  </tr>
  	</table>
  </div>
</div>
<p><br/></p>
<!-- 네이버 로그인 버튼 노출 영역 -->
<script type="text/javascript">
	var naver_id_login = new naver_id_login("kkAPvCBYqT0rdLmu8L16", "http://localhost:9090/javaclassS/member/memberNaverLoginNew");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain("http://localhost:9090/javaclassS/member/memberNaverLoginNew");
	naver_id_login.setState(state);
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>