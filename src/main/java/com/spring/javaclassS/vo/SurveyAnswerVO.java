package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class SurveyAnswerVO {
  private int idx;
  private int survey_idx;
  private int answer1;
  private int answer2;
  private int answer3;
  private int answer4;
  private int answer5;
  private int answer6;
  private int answer7;
  private String answer8;
  
  private int answerCnt;     // 설문에 참여한 총 인원수 저장필드
  private String[] question; // 설문통계에서 질문항목(1~7)을 배열에 담기위한 저장필드
  private String question8;  // 8번의 질문항목을 담기위한 필드
  
  private int[][] surveyAnswer; // 설문지에대한 답변항목의 인원수를 누적시켜 저장시키기위한 2차원배열
  private String strAnswer8; // 8번 설문에 해당하는 답변을 담기위한 필드
  
  // 설문지 결과에 설문주제와 질문내용등을 담아놓기위한 필드
  private String sdate;
  private String kwajung;
  private String kwamok;
  private String kcode;
  private String danwi;
  private String wdate;
  
  // 관리자가 개별 설문결과를 보기위해 설문 문항지를 가져올때 사용함.
  private String question1;
  private String question2;
  private String question3;
  private String question4;
  private String question5;
  private String question6;
  private String question7;
  
  private int curNo; // 관리자가  개별 자료 검색시에 현재 위치를 저장시켜주는 필드
}