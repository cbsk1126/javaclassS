<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>chartAnalysis.jsp</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	<script type="text/javascript">
		// Load google charts
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		// Draw the chart and set the chart values
		function drawChart() {
			var k1 = "매우만족";
			var k2 = "만족";
			var k3 = "보통";
			var k4 = "불만";
			var k5 = "매우불만";
			var v1 = ${vo.surveyAnswer[flag][0]};
			var v2 = ${vo.surveyAnswer[flag][1]};
			var v3 = ${vo.surveyAnswer[flag][2]};
			var v4 = ${vo.surveyAnswer[flag][3]};
			var v5 = ${vo.surveyAnswer[flag][4]};
			
		  var data = google.visualization.arrayToDataTable([
		  ['Task', 'Hours per Day'],
		  [k1, v1],
		  [k2, v2],
		  [k3, v3],
		  [k4, v4],
		  [k5, v5]
		]);
		
		  // Optional; add a title and set the width and height of the chart
		  var options = {'title':'${vo.question[flag]}', 'width':550, 'height':400};
		
		  // Display the chart inside the <div> element with id="piechart"
		  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		  chart.draw(data, options);
		}
		
		function changeChart() {
			var flag = myform.choiceChart.value;
			location.href="${ctp}/survey/chartAnalysis?idx=${vo.survey_idx}&flag="+flag;
		}
	</script>
</head>
<body>
<div class="container">
  - 과목명 : ${vo.kwamok} / 설문 참여인원 : 총 ${vo.answerCnt}명
  <form name="myform">
    <p>선택 :
    <select name="choiceChart" onchange="changeChart()">
      <c:forEach var="i" items="${vo.question}" varStatus="st">
        <option value="${st.index}" <c:if test="${flag==st.index}">selected</c:if>>${vo.question[st.index]}</option>
      </c:forEach>
    </select>
  </form>
  <div id="piechart"></div>
</div>
</body>
</html>