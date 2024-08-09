<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>svResult.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    // 분석결과 보이기, 가리기
    $(document).ready(function() {
    	$("#chartContent").hide();
    	$("#hiddenChart").hide();
    	
    	$("#showChart").click(function() {
    		$("#chartContent").slideDown();
    		$("#hiddenChart").show();
    		$("#showChart").hide();
    		document.body.scrollIntoView(false);
    	});
    	$("#hiddenChart").click(function() {
    		$("#chartContent").slideUp();
    		$("#showChart").show();
    		$("#hiddenChart").hide();
    	});
    });
    
    // 분석용 차트 새창으로 띄우기
    function chartAnalysis(flag) {
    	var url = "${ctp}/chartAnalysis.su?idx=${vo.survey_idx}&flag="+flag;
    	var winX = 600;
    	var winY = 460;
    	var x = (window.screen.width)/2 - winX/2;
    	var y = (window.screen.height)/2 - winY/2;
    	window.open(url, "chartWindow","width="+winX+",height="+winY+",left="+x+",top="+y);
    }
  </script>
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
      padding: 20px;
    }
    .tblleft {text-align:left;}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/svAnswerInputOk.su">
    <h2>능력단위 종료 및 평가 만족도 설문 결과</h2>
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
        <td rowspan="2" style="width:50%;"></td>
        <td colspan="6">점수배점 (최대만족도: 총${vo.answerCnt * 10}점)</td> <!-- 최대만족도는 '총 인원수 * 10' -->
      </tr>
      <tr style="background-color:orange;">
        <td>매우만족(5)</td>
        <td>만족(4)</td>
        <td>보통(3)</td>
        <td>불만(2)</td>
        <td>매우불만(1)</td>
        <td>만족도(150만점)</td>
      </tr>
      <c:set var="cnt" value="0"/>
      <c:forEach var="svAnswerArr" items="${vo.surveyAnswer}">
        <tr>
          <c:forEach var="question" items="${vo.question}" begin="${cnt}" end="${cnt}">
            <td style="text-align:left">${question}</td>
          </c:forEach>
          <c:set var="cnt" value="${cnt+1}"/>
          
          <c:set var="totBiyul" value="0"/>
          <c:forEach var="svAnswer" items="${svAnswerArr}" varStatus="st">
            <td style="width:90px">
              ${svAnswer}명<br/>
              <c:set var="biyul" value="${svAnswer/vo.answerCnt}"/> <!-- 비율(구성비)은 자신을 전체로 나눈값 :  biyul=현재인원수/전체인원수 -->
              (<fmt:formatNumber value="${biyul}" type="percent" pattern="0.0%"/>)
              <c:set var="totBiyul" value="${totBiyul + ((5-st.index)*2)*svAnswer}"/>
            </td>
          </c:forEach>
          <td>
            ${totBiyul}점
          </td>
        </tr>
      </c:forEach>
      <tr>
        <td class="tblleft">${vo.question8}</td>
        <td colspan="6" style="text-align:left;height:300px">
          <%-- 
          <c:if test="${sLevel != 0}">
          	<textarea rows="8" cols="60" name="answer8">${vo.strAnswer8}</textarea>
          </c:if>
           --%>
          ${vo.strAnswer8}
        </td>
      </tr>
      <tr>
        <td colspan="7">
          <input type="button" value="메뉴로이동" onclick="location.href='${ctp}/survey/surveyList.su?sdate=${vo.sdate}';"/>
          <c:if test="${sLevel == 0}">
	          <input type="button" value="분석결과 보이기" id="showChart"/>
	          <input type="button" value="분석결과 가리기" id="hiddenChart"/>
	          <input type="button" value="출력" onclick="window.print()"/>
          </c:if>
        </td>
      </tr>
    </table>
    <input type="hidden" name="survey_idx" value="${vo.idx}"/>
    <input type="hidden" name="sdate" value="${vo.sdate}"/>
  </form>
</div>
<p><br/></p>
<div class="container" id="chartContent">
  <hr/>
  <h3 style="float:left">결과 분석표</h3>
  <input type="button" class="btn btn-secondary" value="차트분석보기" onclick="chartAnalysis(0)" style="float:right"/>
  <br/><br/>
  <c:set var="cnt" value="0"/>
  <c:set var="totalResult" value="0"/>
  <c:forEach var="svAnswerArr" items="${vo.surveyAnswer}">
    <c:forEach var="question" items="${vo.question}" begin="${cnt}" end="${cnt}">
      <h5 style="clear:both; text-align:left">${question}</h5>
    </c:forEach>
    <c:set var="cnt" value="${cnt+1}"/>
    
    <c:set var="totBiyul" value="0"/>
    <c:forEach var="svAnswer" items="${svAnswerArr}" varStatus="st">
      <c:set var="totBiyul" value="${totBiyul + ((5-st.index)*2)*svAnswer}"/>
    </c:forEach>
    
    <div class="progress">
      <div class="progress-bar bg-info" style="width:${totBiyul}%">${totBiyul}%</div>
    </div>
    <br/>
    <c:set var="totalResult" value="${totalResult + totBiyul}"/>
  </c:forEach>
  
  <c:set var="avgResult" value="${totalResult / cnt}"/>
  <h5 style="text-align:left">- 평균 만족도 -</h5>
  <div class="progress">
    <div class="progress-bar bg-danger" style="width:${avgResult}%">
      <fmt:formatNumber value="${avgResult / 100}" type="percent" pattern="0.0%"/>
    </div>
  </div>
</div>
<p><br/><br/></p>
</body>
</html>