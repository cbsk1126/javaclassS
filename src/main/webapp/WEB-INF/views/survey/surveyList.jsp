<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>svList.jsp</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    function sdateCheck() {
    	var sdate = myform.sdate.value;
    	if(sdate == "") {
    		alert("과정 시작일을 선택하세요.");
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
  <style>
    table, h2 {
      margin : 0px auto;
      width : 100%;
      text-align: center;
    }
    /* th, td {
      border : 1px solid #ccc;
      padding : 10px;
    } */
  </style>
</head>
<body>
<c:if test="${empty smenu}">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
  <%@ include file="/WEB-INF/views/include/slide2.jsp" %>
</c:if>
<br/>
<div class="container">
  <form name="myform" method="get">
    <h2>설문지 주제별 리스트</h2>
    <br/>
    <table class="table">
      <tr>
        <td style="text-align:left;border:none;">과정시작일
          <select name="sdate" onchange="sdateCheck()">
            <option value="">선택</option>
            <c:forEach var="sdateVar" items="${sdateArr}">
              <option value="${fn:substring(sdateVar,0,10)}" <c:if test="${fn:substring(sdate,0,10)==fn:substring(sdateVar,0,10)}"> selected </c:if>>
                ${fn:substring(sdateVar,0,10)}
              </option>
            </c:forEach>
          </select>
        </td>
        <td style="text-align:right;border:none;">
          <c:if test="${sLevel == 0}">
          	<%-- <input type="button" value="설문지 결과" onclick="location.href='${ctp}/survey/surveyAdminList';"/> --%>
          	<input type="button" value="설문지 등록" onclick="location.href='${ctp}/survey/surveyInput';"/>
          </c:if>
        </td>
      </tr>
    </table>
    <table class="table table-bordered">
      <tr class="table-dark text-dark">
        <th>번호</th>
        <th>과 정 명</th>
        <th>과 목 명</th>
        <th>능력단위명</th>
        <th>평가일시</th>
        <th>설문참여</th>
        <th>참여자수</th>
      </tr>
      <c:set var="totalCount" value="${fn:length(vos)}"/>
      <c:forEach var="vo" items="${vos}">
        <tr>
          <td>${totalCount}</td>
          <td>${vo.kwajung}</td>
          <td>
            <a href="surveyContent.su?idx=${vo.idx}">${vo.kwamok}</a>
          </td>
          <td>${vo.danwi}(${vo.kcode})</td>
          <td>${vo.wdate}</td>
          <td><input type="button" value="참여" onclick="location.href='${ctp}/survey/surveyAnswerInput?idx=${vo.idx}&sdate=${sdate}';"/></td>
          <td>
            <c:if test="${vo.answerCnt != 0}">
              <c:if test="${sLevel == 0}">
	          		<a href="${ctp}/survey/surveyAdminList?idx=${vo.idx}&sdate=${sdate}&answerCnt=${vo.answerCnt}">${vo.answerCnt}</a>
              </c:if>
              <c:if test="${sLevel != 0}">
	          		<a href="${ctp}/survey/surveyResult?idx=${vo.idx}&sdate=${sdate}&answerCnt=${vo.answerCnt}">${vo.answerCnt}</a>
              </c:if>
            </c:if>
            <c:if test="${vo.answerCnt == 0}">
          		${vo.answerCnt}
            </c:if>
          </td>
        </tr>
        <c:set var="totalCount" value="${totalCount - 1}"/>
      </c:forEach>
    </table>
    <p><br/></p>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </form>
</div>
</body>
</html>