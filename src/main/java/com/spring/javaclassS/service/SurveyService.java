package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS.vo.SurveyAnswerVO;
import com.spring.javaclassS.vo.SurveyVO;

public interface SurveyService {

	public ArrayList<String> sdateSearch();

	public List<SurveyVO> getSurveyList(String sdate);

	public int setSurveyInputOk(SurveyVO vo);

	public SurveyVO getSurveyIdx(int idx);

	public List<SurveyVO> getSurveyListAll();

	public int setSurveyAnswerInput(SurveyAnswerVO vo);

	public List<SurveyVO> getSurveyAdminList(int idx);

	public int setSurveyAnswerDelete(int idx);

	public SurveyVO getSurveyResult(int idx);

	public int[][] getResultCalc(int idx);

	public String getResultAnswer8(int idx);

	public List<SurveyVO> surveyAnswerTotalPrint(int idx);

}
