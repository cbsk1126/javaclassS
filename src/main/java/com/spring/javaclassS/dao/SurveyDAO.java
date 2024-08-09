package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.SurveyAnswerVO;
import com.spring.javaclassS.vo.SurveyVO;

public interface SurveyDAO {

	public ArrayList<String> sdateSearch();

	public List<SurveyVO> getSurveyList(@Param("sdate") String sdate);

	public int setSurveyInputOk(@Param("vo") SurveyVO vo);

	public SurveyVO getSurveyIdx(@Param("idx") int idx);

	public List<SurveyVO> getSurveyListAll();

	public int setSurveyAnswerInput(@Param("vo") SurveyAnswerVO vo);

	public List<SurveyVO> getSurveyAdminList(@Param("idx") int idx);

	public int setSurveyAnswerDelete(@Param("idx") int idx);

	public SurveyVO getSurveyResult(@Param("idx") int idx);

	public int getResultCalc(@Param("idx") int idx, @Param("strAnswer") String strAnswer, @Param("i") int i);

	public List<String> getResultAnswer8(@Param("idx") int idx);

	public List<SurveyVO> surveyAnswerTotalPrint(@Param("idx") int idx);

}
