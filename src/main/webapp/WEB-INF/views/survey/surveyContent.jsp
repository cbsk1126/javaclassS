<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>svContent.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    function svDelCheck() {
    	var ans = confirm("삭제 하시겠습니까?");
    	if(ans)
    		location.href="svDelete.su?idx=${vo.idx}&sdate=${vo.sdate}";
    }
  </script>
  <style>
    table, h2 {
      margin : 0px auto;
      width : 90%;
      text-align: center;
      border-collapse: collapse;
    }
    th, td {
      border : 1px solid #ccc;
      padding : 10px;
    }
    th {
      width : 20%;
      background-color: orange;
    }
    td {
      width : 80%;
      text-align: left;
    }
  </style>
</head>
<body>
<c:if test="${empty smenu}">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
  <%@ include file="/WEB-INF/views/include/slide2.jsp" %>
</c:if>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/svUpdateOk.su">
    <h2>설문지 과정별 문항 등록</h2>
    <br/>
    <table class="table">
      <tr>
        <th>과정시작일</th>
        <td>${fn:substring(vo.sdate,0,10)}</td>
      </tr>
      <tr>
        <th>과 정 명</th>
        <td>${vo.kwajung}</td>
      </tr>
      <tr>
        <th>과 목 명</th>
        <td><input type="text" name="kwamok" value="${vo.kwamok}" size="70" autofocus/></td>
      </tr>
      <tr>
        <th>능력단위코드</th>
        <td><input type="text" name="kcode" value="${vo.kcode}" size="70"/></td>
      </tr>
      <tr>
        <th>능력단위명</th>
        <td><input type="text" name="danwi" value="${vo.danwi}" size="70"/></td>
      </tr>
      <tr>
        <th>평가일시</th>
        <td><input type="text" name="wdate" value="${vo.wdate}" size="70"/></td>
      </tr>
    </table>
    <br/>
    <table class="table">
      <tr>
        <th>문항1</th>
        <td><input type="text" name="question1" size="70" value="${vo.question1}"/></td>
      </tr>
      <tr>
        <th>문항2</th>
        <td><input type="text" name="question2" size="70" value="${vo.question2}"/></td>
      </tr>
      <tr>
        <th>문항3</th>
        <td><input type="text" name="question3" size="70" value="${vo.question3}"/></td>
      </tr>
      <tr>
        <th>문항4</th>
        <td><input type="text" name="question4" size="70" value="${vo.question4}"/></td>
      </tr>
      <tr>
        <th>문항5</th>
        <td><input type="text" name="question5" size="70" value="${vo.question5}"/></td>
      </tr>
      <tr>
        <th>문항6</th>
        <td><input type="text" name="question6" size="70" value="${vo.question6}"/></td>
      </tr>
      <tr>
        <th>문항7</th>
        <td><input type="text" name="question7" size="70" value="${vo.question7}"/></td>
      </tr>
      <tr>
        <th>문항8</th>
        <td><input type="text" name="question8" size="70" value="${vo.question8}"/></td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center;">
          <c:if test="${slevel == 0}">
	          <input type="submit" value="수정"/> &nbsp;
	          <input type="button" value="삭제" onclick="svDelCheck()"/> &nbsp;
	          <input type="reset" value="다시입력"/> &nbsp;
          </c:if>
          <input type="button" value="설문참여" onclick="location.href='svAnswerInput.su?idx=${vo.idx}&sdate=${vo.sdate}';"/>
          <input type="button" value="메뉴로 이동" onclick="location.href='svList.su?sdate=${vo.sdate}';"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="sdate" value="${vo.sdate}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>