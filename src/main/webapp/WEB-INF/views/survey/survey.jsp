<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>survey.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>설 문 지 메 뉴</h2>
  <hr/>
  <p><a href="surveyList">설문지 리스트</a></p>
  <p><a href="surveyInput">설문지 등록</a></p>
</div>
</body>
</html>