<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>svInput.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
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
  <form name="myform" method="post">
    <h2>설문지 과정별 문항 등록</h2>
    <br/>
    <table class="table">
      <tr>
        <th>과정시작일</th>
        <td><input type="date" name="sdate" value="2024-02-26" readonly /></td>
      </tr>
      <tr>
        <th>과 정 명</th>
        <td><input type="text" name="kwajung" size="70" value="(디지털컨버전스) 데이터 융합 자바(JAVA) & 스프링(spring) 개발자 양성과정 A" readonly /></td>
        <!-- <td><input type="text" name="kwajung" size="70"/></td> -->
      </tr>
      <tr>
        <th>과 목 명</th>
        <td><input type="text" name="kwamok" size="70" autofocus/></td>
      </tr>
      <tr>
        <th>능력단위코드</th>
        <td><input type="text" name="kcode" size="70"/></td>
      </tr>
      <tr>
        <th>능력단위명</th>
        <td><input type="text" name="danwi" size="70"/></td>
      </tr>
      <tr>
        <th>평가일시</th>
        <td><input type="text" name="wdate" size="70"/></td>
      </tr>
    </table>
    <br/>
    <table class="table">
      <tr>
        <th>문항1</th>
        <td><input type="text" name="question1" size="70" value="1. 능력단위 편성시간은 적절하십니까?"/></td>
      </tr>
      <tr>
        <th>문항2</th>
        <td><input type="text" name="question2" size="70" value="2. 능력단위 종료시 산출결과물에 만족하십니까?"/></td>
      </tr>
      <tr>
        <th>문항3</th>
        <td><input type="text" name="question3" size="70" value="3. 능력단위 평가시 평가시간은 적절하였습니까?"/></td>
      </tr>
      <tr>
        <th>문항4</th>
        <td><input type="text" name="question4" size="70" value="4. 능력단위 평가시 평가문항의 난이도는 적절하였습니까?"/></td>
      </tr>
      <tr>
        <th>문항5</th>
        <td><input type="text" name="question5" size="70" value="5. 능력단위 평가시 평가방법(서술형 평가 및 포트폴리오)은 적절하였습니까?"/></td>
      </tr>
      <tr>
        <th>문항6</th>
        <td><input type="text" name="question6" size="70" value="6. 능력단위 평가시 평가횟수는 적절하였습니까?"/></td>
      </tr>
      <tr>
        <th>문항7</th>
        <td><input type="text" name="question7" size="70" value="7. 능력단위 훈련교사에 대해 만족하십니까?"/></td>
      </tr>
      <tr>
        <th>문항8</th>
        <td><input type="text" name="question8" size="70" value="8. 기타 및 건의사항"/></td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center;">
          <input type="submit" value="등록"/> &nbsp;
          <input type="reset" value="다시입력"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='surveyList';"/>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>