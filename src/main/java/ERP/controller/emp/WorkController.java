package ERP.controller.emp;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.emp.IEmployeeService;
import ERP.service.emp.IWorkService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import validate.groups.UpdateGroup;
import vo.PagingVO;
import vo.SearchVO;
import vo.emp.EmployeeVO;
import vo.emp.WorkVO;

@Controller
@RequestMapping(value = "/emp/work")
public class WorkController { // 근태관리
	
//	@Inject
//	private  IEmployeeService empService;
	@Inject
	private IWorkService workService;
//	@Inject
//	private IWorkDAO dao;

	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<WorkVO> ajaxForlist(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			WorkVO emp,
			Model model
			){
		dailylist(currentPage, emp, model);
		return (PagingVO<WorkVO>) model.asMap().get("pagingVO"); 
	}
	
	// 일일근태 리스트 나오는거 
	@GetMapping("dailyList") 
	public String dailylist( 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,   
			WorkVO emp,
			Model model){
		
		PagingVO<WorkVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = workService.readWorkCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<WorkVO> workList = workService.readWorkList(pagingVO);
		pagingVO.setDataList(workList);
		
		
//		이부분 다시보기   사원의 근태 이면 employee에 대한 정보도 가져 와야 하는가??
//		List<EmployeeVO> empList = empService.readEmployeeList(pagingVO);
//		pagingVO.setDataList(empList);
		model.addAttribute("currentAction", "/emp/work/");
		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/dayilyWorkList";
	}
	
	// 일일근태  행 하나 클릭시 상세 모달창 연결
	@GetMapping("{emp_no}")
	public String dailyForm(  // 출,퇴근 시간 입력 후 저장하는거 등록버튼 활성화, 비활성화 
			@PathVariable(required = true) String emp_no, 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,   
			WorkVO emp,	Model model
	) {

		model.addAttribute("currentAction", "/emp/work/dailyList");
		WorkVO vo = new WorkVO();
		vo.setEmp_no(emp_no);
		WorkVO work = workService.readWork(emp_no);
		model.addAttribute("work",work);
		
		return "/emp/dailyForm";
	}
	
	// 시간 수정 후 등록 하는거??
	@ResponseBody
	@PostMapping(value = "upTime/{emp_no}", produces ="text/plain;charset=UTF-8" )
	public String upTime(
			@PathVariable String emp_no,
			Model model,
//			BindingResult errors,
			@Validated(UpdateGroup.class) @ModelAttribute("work") WorkVO work
			) {
		ServiceResult result = null;
//		if(!errors.hasErrors()) {
			result = workService.modifyWork(work);
//		}
		String  str = result == ServiceResult.OK ? "수정성공": "수정실패";
		
		return str;
		
	}
	
	
	// 내  출퇴근 시간 가져오기 
	@GetMapping("/mypage/myInfo/myDailyList") 
	public String myDailyList( 			
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,   
			@ModelAttribute("searchVO") SearchVO searchVO, 
			HttpServletRequest request,
			HttpServletResponse response, Model model){
		
// 		PagingVO<EmployeeVO> pagingVO = new PagingVO<>(5, 3);
// 		pagingVO.setSearchVO(searchVO);
// 		pagingVO.setCurrentPage(currentPage);
//	
//		
//		List<EmployeeVO> empList = empservice.readEmployeeList(pagingVO);
//		pagingVO.setDataList(empList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		// logical view name
		String goPage = "emp/myWork";
		return goPage;
	}
	
	
	@GetMapping(value = "monthList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<WorkVO> mothWorkList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			WorkVO work,
			Model model
			){
		monthList(currentPage, work, model);
		return (PagingVO<WorkVO>) model.asMap().get("pagingVO"); 
	}
	
	// 월간근태 리스트 나오는거 
	
	@GetMapping("monthList") 
	public String monthList( 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,   
			WorkVO work, Model model){
		
		PagingVO<WorkVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(work);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = workService.readWorkCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
//	여기여기
		List<WorkVO> workList = workService.readMonthList(pagingVO);
		pagingVO.setDataList(workList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("currentAction", "/emp/work/monthList");
	
		
		return "emp/monthWorkInput";
	}
	
	
	
	
	
	
	
	
	
	
}
