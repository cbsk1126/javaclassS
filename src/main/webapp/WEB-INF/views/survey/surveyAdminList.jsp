<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>surveyAllList.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    function answerDelCheck() {
    	var ans = confirm("현재 답변지를 삭제하시겠습니까?");
    	if(ans)
    		location.href="${ctp}/survey/surveyAnswerDelete?idx=${vo.answer_idx}&sdate=${vo.sdate}";
    }
    
    // 전체 자료 출력
    function totalPrint() {
    	var ans = confirm("현재 능력단위의 전체 출력 페이지로 이동합니다. 계속하시겠습니까?");
    	if(ans)
    		location.href="${ctp}/survey/surveyAnswerTotalPrint?idx=${vo.survey_idx}&sdate=${vo.sdate}";
    }
    
    // 부분인쇄하기
    var initBodyHtml;

    function printPage() {
        window.print();
    }

    function beforePrint() {
        initBodyHtml = document.body.innerHTML;
        document.body.innerHTML = document.getElementById('print').innerHTML;
    }
    function afterPrint() {
        document.body.innerHTML = initBodyHtml;
    }

    window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
  </script>
  <style type="text/css" media="print">
    /* @page{size:auto; margin:15mm;} */
  </style>
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
<c:if test="${sLevel != 0}">
  <%@ include file="/WEB-INF/views/include/nav.jsp" %>
  <%@ include file="/WEB-INF/views/include/slide2.jsp" %>
</c:if>
<br/>
<div class="container">
  <form name="myform" method="post">
    <div id="print">
    	<br/><br/><br/><br/><br/>
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
	        <td><input type="radio" name="answer1" value="5" ${vo.answer1=='5' ? 'checked' : ''}/></td>
	        <td><input type="radio" name="answer1" value="4" ${vo.answer1=='4' ? 'checked' : ''}/></td>
	        <td><input type="radio" name="answer1" value="3" ${vo.answer1=='3' ? 'checked' : ''}/></td>
	        <td><input type="radio" name="answer1" value="2" ${vo.answer1=='2' ? 'checked' : ''}/></td>
	        <td><input type="radio" name="answer1" value="1" ${vo.answer1=='1' ? 'checked' : ''}/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question2}</td>
	        <td><input type="radio" name="answer2" value="5" <c:if test="${vo.answer2 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer2" value="4" <c:if test="${vo.answer2 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer2" value="3" <c:if test="${vo.answer2 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer2" value="2" <c:if test="${vo.answer2 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer2" value="1" <c:if test="${vo.answer2 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question3}</td>
	        <td><input type="radio" name="answer3" value="5" <c:if test="${vo.answer3 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer3" value="4" <c:if test="${vo.answer3 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer3" value="3" <c:if test="${vo.answer3 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer3" value="2" <c:if test="${vo.answer3 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer3" value="1" <c:if test="${vo.answer3 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question4}</td>
	        <td><input type="radio" name="answer4" value="5" <c:if test="${vo.answer4 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer4" value="4" <c:if test="${vo.answer4 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer4" value="3" <c:if test="${vo.answer4 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer4" value="2" <c:if test="${vo.answer4 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer4" value="1" <c:if test="${vo.answer4 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question5}</td>
	        <td><input type="radio" name="answer5" value="5" <c:if test="${vo.answer5 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer5" value="4" <c:if test="${vo.answer5 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer5" value="3" <c:if test="${vo.answer5 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer5" value="2" <c:if test="${vo.answer5 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer5" value="1" <c:if test="${vo.answer5 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question6}</td>
	        <td><input type="radio" name="answer6" value="5" <c:if test="${vo.answer6 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer6" value="4" <c:if test="${vo.answer6 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer6" value="3" <c:if test="${vo.answer6 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer6" value="2" <c:if test="${vo.answer6 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer6" value="1" <c:if test="${vo.answer6 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question7}</td>
	        <td><input type="radio" name="answer7" value="5" <c:if test="${vo.answer7 eq '5'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer7" value="4" <c:if test="${vo.answer7 eq '4'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer7" value="3" <c:if test="${vo.answer7 eq '3'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer7" value="2" <c:if test="${vo.answer7 eq '2'}">checked</c:if>/></td>
	        <td><input type="radio" name="answer7" value="1" <c:if test="${vo.answer7 eq '1'}">checked</c:if>/></td>
	      </tr>
	      <tr>
	        <td class="tblleft">${vo.question8}</td>
	        <td colspan="5">
	          <textarea rows="14" cols="60" name="answer8">${vo.answer8}</textarea>
	        </td>
	      </tr>
	    </table>
    </div>
    <table class="table table-borderless">
      <tr>
        <td>
          <c:set var="curNo" value="${vo.curNo}"/>
          <c:if test="${curNo gt 1}">
          	<input type="button" value="처음" onclick="location.href='${ctp}/survey/surveyAdminList.su?idx=${vo.survey_idx}&sdate=${vo.sdate}&answerCnt=${vo.answerCnt}&curNo=${1}';"/>
          	<input type="button" value="이전" onclick="location.href='${ctp}/survey/surveyAdminList.su?idx=${vo.survey_idx}&sdate=${vo.sdate}&answerCnt=${vo.answerCnt}&curNo=${curNo-1}';"/>
          </c:if>
          &nbsp;: 총 ${vo.answerCnt}건 중에서 ${vo.curNo}번째:&nbsp;
          <c:if test="${vo.curNo lt vo.answerCnt}">
          	<input type="button" value="다음" onclick="location.href='${ctp}/survey/surveyAdminList?idx=${vo.survey_idx}&sdate=${vo.sdate}&answerCnt=${vo.answerCnt}&curNo=${curNo+1}';"/>
          	<input type="button" value="마지막" onclick="location.href='${ctp}/survey/surveyAdminList?idx=${vo.survey_idx}&sdate=${vo.sdate}&answerCnt=${vo.answerCnt}&curNo=${vo.answerCnt}';"/>
          </c:if>
          &nbsp; &nbsp; &nbsp; 
          <input type="button" value="삭제" onclick="answerDelCheck()"/> &nbsp;
          <input type="button" value="결과보기" onclick="location.href='${ctp}/survey/surveyResult?idx=${vo.survey_idx}&sdate=${sdate}&answerCnt=${vo.answerCnt}';"/>
          &nbsp; : &nbsp;
          <!-- <input type="button" value="개별출력" onclick="window.print()"/> -->
          <input type="button" value="개별출력" onclick="printPage()"/>
          <input type="button" value="전체출력" onclick="totalPrint()"/>
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