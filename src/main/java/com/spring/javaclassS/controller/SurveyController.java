package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.SurveyService;
import com.spring.javaclassS.vo.SurveyAnswerVO;
import com.spring.javaclassS.vo.SurveyVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	String msgFlag = "";
	
	@Autowired
	SurveyService surveyService;
	
	@Autowired
	PageProcess pageProcess;
	
//	@GetMapping("/surveyList")
//	public String surveyListGet(Model model) {
//    List<SurveyVO> vos = surveyService.getSurveyListAll();
//    model.addAttribute("vos", vos);
//		return "survey/surveyList";
//	}
	
	@GetMapping("/surveyList")
	public String surveyListGet(Model model, 
			@RequestParam(name="sdate", defaultValue = "", required = false) String sdate) {
		ArrayList<String> sdateArr = surveyService.sdateSearch();
		List<SurveyVO> vos = surveyService.getSurveyList(sdate);
		model.addAttribute("sdateArr", sdateArr);
		model.addAttribute("sdate", sdate);
		model.addAttribute("vos", vos);
		return "survey/surveyList";
	}
	
	@GetMapping("/surveyInput")
	public String surveyInputGet() {
		return "survey/surveyInput";
	}
	
	@PostMapping("/surveyInput")
	public String surveyInputPost(SurveyVO vo) {
		int res = surveyService.setSurveyInputOk(vo);
		if(res != 0) return "redirect:/message/serveyInputOk";
		else return "redirect:/message/serveyInputNo";
	}
	
	@GetMapping("/surveyAnswerInput")
	public String surveyAnswerInputGet(int idx, Model model) {
		SurveyVO vo = surveyService.getSurveyIdx(idx);
		model.addAttribute("vo", vo);
		return "survey/surveyAnswerInput";
	}
	
	@PostMapping("/surveyAnswerInput")
	public String surveyAnswerInputPost(SurveyAnswerVO vo) {
		int res = surveyService.setSurveyAnswerInput(vo);
		if(res != 0) return "redirect:/message/serveyAnswerInputOk";
		else return "redirect:/message/serveyInputAnswerNo";
	}
	
	@GetMapping("/surveyAdminList")
	public String surveyAdminListGet(Model model, int answerCnt,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="sdate", defaultValue = "", required = false) String sdate,
			@RequestParam(name="curNo", defaultValue = "1", required = false) int curNo) {
		List<SurveyVO> vos = surveyService.getSurveyAdminList(idx);
		SurveyVO vo = new SurveyVO();
		for(int i=0; i<curNo; i++) {
			vo = vos.get(i);
		}
		vo.setSurvey_idx(idx);
		vo.setCurNo(curNo);
		vo.setAnswerCnt(answerCnt);
		
		model.addAttribute("idx", idx);
		model.addAttribute("sdate", sdate);
		model.addAttribute("vo", vo);
		return "survey/surveyAdminList";
	}
	
	@GetMapping("/surveyAnswerDelete")
	public String surveyAnswerDeleteGet(int idx, String sdate) {
		surveyService.setSurveyAnswerDelete(idx);
		return "redirect:/message/surveyAnswerDeleteOk?tempFlag="+sdate;
	}
	
	@GetMapping("/surveyResult")
	public String surveyResultGet(int idx, String sdate, int answerCnt, Model model) {
		SurveyVO vo = surveyService.getSurveyResult(idx);
		vo.setAnswerCnt(answerCnt);
		
		// 설문지의 질문제목을 저장하는 공간
		String[] question = new String[7];  // 설문 제목 1~7까지를 저장하는 배열
    question[0] = vo.getQuestion1();
    question[1] = vo.getQuestion2();
    question[2] = vo.getQuestion3();
    question[3] = vo.getQuestion4();
    question[4] = vo.getQuestion5();
    question[5] = vo.getQuestion6();
    question[6] = vo.getQuestion7();
    vo.setQuestion(question);
		
	  // 설문에 참여한 사람들의 결과를 계산처리하는 메소드 호출
		vo.setSurveyAnswer(surveyService.getResultCalc(idx));  // 현재 설문지의 통계 계산 메소드 호출
    vo.setStrAnswer8(surveyService.getResultAnswer8(idx));  // Question8항목에 대한 내역만 누적시켜서 가져오기
		
		model.addAttribute("vo", vo);
		model.addAttribute("sdate", sdate);
		return "survey/surveyResult";
	}
	
	@GetMapping("/surveyAnswerTotalPrint")
	public String surveyAnswerTotalPrintGet(int idx, String sdate, Model model) {
		List<SurveyVO> vos = surveyService.surveyAnswerTotalPrint(idx);
		model.addAttribute("vos", vos);
		model.addAttribute("sdate", sdate);
		return "/survey/surveyAnswerTotalPrint";
	}
	
	@GetMapping("/chartAnalysis")
	public String chartAnalysisGet(int idx, String sdate, Model model) {
		SurveyVO vo = surveyService.getSurveyResult(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("sdate", sdate);
		return "/survey/surveyAnswerTotalPrint";
	}
	
}
