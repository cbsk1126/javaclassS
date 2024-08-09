package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.SurveyDAO;
import com.spring.javaclassS.vo.SurveyAnswerVO;
import com.spring.javaclassS.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	SurveyDAO	surveyDAO;

	@Override
	public ArrayList<String> sdateSearch() {
		return surveyDAO.sdateSearch();
	}

	@Override
	public List<SurveyVO> getSurveyList(String sdate) {
		return surveyDAO.getSurveyList(sdate);
	}

	@Override
	public int setSurveyInputOk(SurveyVO vo) {
		return surveyDAO.setSurveyInputOk(vo);
	}

	@Override
	public SurveyVO getSurveyIdx(int idx) {
		return surveyDAO.getSurveyIdx(idx);
	}

	@Override
	public List<SurveyVO> getSurveyListAll() {
		return surveyDAO.getSurveyListAll();
	}

	@Override
	public int setSurveyAnswerInput(SurveyAnswerVO vo) {
		return surveyDAO.setSurveyAnswerInput(vo);
	}

	@Override
	public List<SurveyVO> getSurveyAdminList(int idx) {
		return surveyDAO.getSurveyAdminList(idx);
	}

	@Override
	public int setSurveyAnswerDelete(int idx) {
		return surveyDAO.setSurveyAnswerDelete(idx);
	}

	@Override
	public SurveyVO getSurveyResult(int idx) {
		return surveyDAO.getSurveyResult(idx);
	}

	@Override
	public int[][] getResultCalc(int idx) {
		int[][] surveyAnswer = new int[7][5];
    String strAnswer = "";
    for(int i=0; i<surveyAnswer.length ; i++) {
      for(int j=0; j<surveyAnswer[i].length ; j++) {
        strAnswer = "answer" + (i+1);
        surveyAnswer[i][j] = surveyDAO.getResultCalc(idx, strAnswer, 5-j);
      }
    }
    return surveyAnswer;
	}

	@Override
	public String getResultAnswer8(int idx) {
		String answer8 = "";
		List<String> vos = surveyDAO.getResultAnswer8(idx);
		for(String v : vos) {
			answer8 += "-" + v + "<br>";
		}
		return answer8;
	}

	@Override
	public List<SurveyVO> surveyAnswerTotalPrint(int idx) {
		return surveyDAO.surveyAnswerTotalPrint(idx);
	}
	
}
