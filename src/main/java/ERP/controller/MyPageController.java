package ERP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vo.SearchVO;
import vo.emp.DepartmentVO;
import vo.emp.EMP_CertVO;
import vo.emp.Emp_CareerVO;
import vo.emp.EmployeeVO;
import vo.emp.PositionVO;
import vo.emp.Salary_TransVO;
import vo.emp.WorkVO;

@Controller
@RequestMapping("/mypage/myInfo")
public class MyPageController {
	
	
	// 주요 업무리스트 보여주는거??
	
	@GetMapping("myEmpInformation")
	public String myEmpInformaion( //  my page 에서 내정보 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, @ModelAttribute EmployeeVO emp,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/myEmpInformation"; //게시판 목록 리스트 
	}
	
	@PostMapping("myEmpInformationUpdate")
	public String myEmpInformaionUpdate( //  my page 에서 내정보 수정
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, EmployeeVO emp,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/myEmpInformation"; //게시판 목록 리스트 
	}
	
	
	@GetMapping("mySalaryList")
	public String mySalaryList( //  my page 에서 급여내역 조회 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO,
			@ModelAttribute("emp") EmployeeVO emp,
			@ModelAttribute("dep") DepartmentVO dep,
			@ModelAttribute("salary") Salary_TransVO salary,
			@ModelAttribute("position") PositionVO position,
			@ModelAttribute("work") WorkVO work,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/mySalaryList"; //게시판 목록 리스트 
	}

	@GetMapping("myWork")
	public String myWork( //  my page 에서 근태 조회 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/myWork"; //게시판 목록 리스트 
	}
	
	
	
	@GetMapping("myNotice")
	public String myNotice( //  my page 에서 공지사항 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/myNotice"; //게시판 목록 리스트 
	}
	
	
	@GetMapping("passWordChange")
	public String passWordChange( //  my page 에서 급여내역 조회 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/passWordChange"; //게시판 목록 리스트 
	}

	@PostMapping("passWordChange/update")
	public String passWordChangeUpdate( //  my page 에서 내정보 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, 
			@ModelAttribute(value = "emp") EmployeeVO emp,
			@ModelAttribute("emp_certvo") EMP_CertVO emp_certvo,
			@ModelAttribute("emp_career") Emp_CareerVO emp_career,
			Model model ){
		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		pagingVO.setCurrentPage(currentPage);
//		int totalRecord = service.readBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		
//		List<BoardVO> prodList = service.readBoardList(pagingVO);
//		pagingVO.setDataList(prodList);
//		
//		model.addAttribute("pagingVO", pagingVO);
//		
		return "mypage/contents"; //게시판 목록 리스트 
	}

	// 레프트바에서 사진을 클릭하면 메인 페이지로 이동하는거 
	@GetMapping
	private String mainPage() {
		return "mypage/main";
		
	}
	
	
}
