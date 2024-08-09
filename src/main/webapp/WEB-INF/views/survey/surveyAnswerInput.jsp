<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>svAnswerInput.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      width : 100%;
      margin : 0px auto;
    }
    table, h2 {
      width: 800px;
      margin : 0px auto;
      border-collapse: collapse;
      text-align: center;
    }
    th, td {
      border: 1px solid #ccc;
      padding: 15px;
    }
    .tblleft {text-align:left;}
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
    <h2>능력단위 종료 및 평가 만족도 설문</h2>
    <br/>
    <table class="table">
      <tr>
        <th>과정 시작일</th>
        <td class="tblleft">${fn:substring(vo.sdate,0,10)}</td>
      </tr>
      <tr>
        <th>과 정 명</th>
        <td style="text-align:left;">${vo.kwajung}</td>
      </tr>
      <tr>
        <th>과 목 명</th>
        <td style="text-align:left;">${vo.kwamok}</td>
      </tr>
      <tr>
        <th>능력단위명</th>
        <td style="text-align:left;">${vo.kcode} ${vo.danwi}</td>
      </tr>
      <tr>
        <th>평가일시</th>
        <%-- <td style="text-align:left;">${fn:substring(vo.wdate,0,10)}</td> --%>
        <td style="text-align:left;">${vo.wdate}</td>
      </tr>
    </table>
    <table class="table">
      <tr style="background-color:orange;">
        <td rowspan="2"></td>
        <td colspan="5">점수배점</td>
      </tr>
      <tr style="background-color:orange;">
        <td>매우만족(5)</td>
        <td>만족(4)</td>
        <td>보통(3)</td>
        <td>불만(2)</td>
        <td>매우불만(1)</td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question1}</td>
        <td><input type="radio" name="answer1" value="5"/></td>
        <td><input type="radio" name="answer1" value="4" checked/></td>
        <td><input type="radio" name="answer1" value="3"/></td>
        <td><input type="radio" name="answer1" value="2"/></td>
        <td><input type="radio" name="answer1" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question2}</td>
        <td><input type="radio" name="answer2" value="5"/></td>
        <td><input type="radio" name="answer2" value="4" checked/></td>
        <td><input type="radio" name="answer2" value="3"/></td>
        <td><input type="radio" name="answer2" value="2"/></td>
        <td><input type="radio" name="answer2" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question3}</td>
        <td><input type="radio" name="answer3" value="5"/></td>
        <td><input type="radio" name="answer3" value="4" checked/></td>
        <td><input type="radio" name="answer3" value="3"/></td>
        <td><input type="radio" name="answer3" value="2"/></td>
        <td><input type="radio" name="answer3" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question4}</td>
        <td><input type="radio" name="answer4" value="5"/></td>
        <td><input type="radio" name="answer4" value="4" checked/></td>
        <td><input type="radio" name="answer4" value="3"/></td>
        <td><input type="radio" name="answer4" value="2"/></td>
        <td><input type="radio" name="answer4" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question5}</td>
        <td><input type="radio" name="answer5" value="5"/></td>
        <td><input type="radio" name="answer5" value="4" checked/></td>
        <td><input type="radio" name="answer5" value="3"/></td>
        <td><input type="radio" name="answer5" value="2"/></td>
        <td><input type="radio" name="answer5" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question6}</td>
        <td><input type="radio" name="answer6" value="5"/></td>
        <td><input type="radio" name="answer6" value="4" checked/></td>
        <td><input type="radio" name="answer6" value="3"/></td>
        <td><input type="radio" name="answer6" value="2"/></td>
        <td><input type="radio" name="answer6" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question7}</td>
        <td><input type="radio" name="answer7" value="5"/></td>
        <td><input type="radio" name="answer7" value="4" checked/></td>
        <td><input type="radio" name="answer7" value="3"/></td>
        <td><input type="radio" name="answer7" value="2"/></td>
        <td><input type="radio" name="answer7" value="1"/></td>
      </tr>
      <tr>
        <td class="tblleft">${vo.question8}</td>
        <td colspan="5">
          <textarea rows="8" cols="60" name="answer8"></textarea>
        </td>
      </tr>
      <tr>
        <td colspan="6">
          <input type="submit" value="설문참여"/> &nbsp;
          <input type="reset" value="다시작성"/> &nbsp;
          <input type="button" value="메뉴로이동" onclick="location.href='${ctp}/survey/surveyList?sdate=${vo.sdate}';"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="survey_idx" value="${vo.idx}"/>
    <input type="hidden" name="sdate" value="${vo.sdate}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>