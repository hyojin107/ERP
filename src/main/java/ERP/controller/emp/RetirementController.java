package ERP.controller.emp;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.emp.IEmpListDAO;
import ERP.service.emp.IEmployeeService;
import ERP.service.emp.IRetirementService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.PagingVO;
import vo.SearchVO;
import vo.emp.EmployeeVO;
import vo.emp.RetirementVO;

@Controller
@RequestMapping("/emp/retire")
public class RetirementController { // 퇴직금 정산
	
	@Inject
	IRetirementService service;
	@Inject
	IEmpListDAO dao;  //  정산 여부 리스트 불러오는거 
	@Inject
	IEmployeeService empService;

	
	private void attributeSetting(Model model) {
		model.addAttribute("retireList", dao.selectRetireList()); //퇴직정산여부
	}
	
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmployeeVO> ajaxForlist(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model,EmployeeVO emp
			){
		transList(currentPage, emp, model);
		return (PagingVO<EmployeeVO>) model.asMap().get("pagingVO"); 
	}
	
	
	
	@GetMapping("retireTrans")
	public String transList( //  퇴직금 정산 게시판 목록 띄우는거 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp,
			Model model ){
		
		attributeSetting(model);// retireList 리스트를 불러오는거 
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readEmpListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<EmployeeVO> retireList = service.readRetirementList(pagingVO);
		pagingVO.setDataList(retireList);
		
		model.addAttribute("pagingVO", pagingVO);
		 		
		return "emp/retirementList"; //게시판 목록 리스트 
	}

	
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/emp";
	}
	
	// 모달창으로 정보 띄워주는거 
	@GetMapping("{emp_no}") // 퇴직금 정산 입력창 불러오기  
	public String form(
			@PathVariable(required = true) String emp_no,
			Model model
			) {
		EmployeeVO vo = new EmployeeVO();
		vo.setEmp_no(emp_no);
		EmployeeVO emp = service.readRetirement(vo);
		model.addAttribute("emp",emp);
		return "/emp/retirementTransDetail";
	}
		
	// 퇴직금  등록 폼 가져오는거 
	// jsp 에서 경로 주소  화면전환시 나오는거 
	@GetMapping("retirementForm") 
	public String retirementForm(Model model)throws SerialException,IOException//  퇴직금 등록 화면 
		{
		attributeSetting(model);
		model.addAttribute("currentAction", "/emp/retire/retirementRegister");	
		return "emp/retirementForm";  
	}
	
	// 퇴직금 정산 폼에서 사원정보 검색을 클릭하면 사원을 검색할수 있는 모달창 나오는거 
	@GetMapping("retireEmpModal")
	public String retireEmpModal( 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp,
			Model model 
			){
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = empService.readEmpListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<EmployeeVO> retireList = empService.readEmployeeList(pagingVO);
		pagingVO.setDataList(retireList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "/emp/retireEmpModal";
	}
	
	// 퇴직금 정산 등록에서 사원 한명을 클릭했을떄
	// retireEmpModal에서 사원한명을 클릭했을때  vo를 보내는거 
	@GetMapping(value = "retirementForm/{emp_no}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody  // json으로 보내기 위해서
	public EmployeeVO retireSelect(@PathVariable String emp_no) {
		EmployeeVO vo = empService.readEmployee(emp_no);
		
		return vo;
	}
	
	@PostMapping("retirementRegister")
	public String insert(  // 퇴직금 등록 
		@Validated(InsertGroup.class) @ModelAttribute("emp_no") RetirementVO emp_no, BindingResult errors,
		@ModelAttribute("emp") EmployeeVO emp,
		Model model
	) {
//		String goPage = null;
//		String message = null;
//		if (!errors.hasErrors()) {
//			ServiceResult result = service.createBoard(board);
//			switch (result) {
//			case FAIL:
//				message = "쫌따 다시 해보셈.";
//				goPage = "board/boardForm"; // 입력폼 
//				break;
//			default: // OK
//				goPage = "redirect:/board/"+board.getBo_no();  // 게시글 작성하는곳 으로 ??
//				break;
//			}
//		} else {
//			goPage = "board/boardForm";
//		}
//
//		model.addAttribute("message", message);

		return "emp/retirementForm";
	}
	
	@GetMapping("Receiptform") // 퇴직금 영수증 세부사항 불러오기  
	public String receiptForm(@ModelAttribute("emp_no") RetirementVO emp_no) {
		return "emp/retirementTransDetail";
	}
	
	
	//퇴사사원 리스트 불러오는거 
	@GetMapping("empRetirmentList")
	public String empRetirmentList( 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp,
			Model model ){
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.getDetailSearch();
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = service.readEmpListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<EmployeeVO> reList = service.readRetirementList(pagingVO);
		pagingVO.setDataList(reList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/empRetireList"; 
	}
	
	
	// 퇴직사원 리스트에서 사원 행을 클릭하면 사원의 퇴사 정보가 나온다. 
		@GetMapping(value = "retireEmp/{emp_no}" )
		public String retireEmpl( 
				@PathVariable(required = true) String emp_no, //모달연결해주는거  @PathVariable
				Model model
				){
			EmployeeVO vo = new EmployeeVO();
			vo.setEmp_no(emp_no);
			EmployeeVO emp = service.readRetirement(vo);
			model.addAttribute("emp", emp);
			return "/emp/empRetireDetail";
		}
	
	
	
	
	
	
	// 퇴사사원 등록
	@GetMapping("empRetirmentRegist")
	public String empRetirmentRegist( 
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
		
		return "emp/empRetireDetail"; 
	}
	
	
	@PostMapping("empRetireRegistalModal")
	public String empRetireRegistalModal(@Valid @ModelAttribute("emp") EmployeeVO emp, 
						Errors erros,
						Model model,
						HttpServletRequest req)  { 
		model.addAttribute("currentAction", "/emp/manage/empInput");

		return "emp/empRetireList";
	}
	
	
	
	@Autowired
	private JavaMailSender mailSender;
	
	// 퇴직금 영수증 보내기 
	@PostMapping(value = "retireMail", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String mail(HttpServletRequest request,
				@RequestBody(required = false) Map<String, Object> empMail
			)throws AddressException, MessagingException,Exception{
		// 메일 전송하는거 
				// 네이버일 경우 smtp.naver.com 을 입력합니다. 
				// Google일 경우 smtp.gmail.com 을 입력합니다. 
				String host = "smtp.naver.com";
				// 회사에서 보내는거 
//				final String username = "jungjuhwan10"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 
//				final String password = "090722vvss"; //네이버 이메일 비밀번호를 입력해주세요. 
//				int port=465; //포트번호
				
				// 메일 내용 
				String content = (String) empMail.get("content");
				String recipient = (String) empMail.get("mailadd"); //받는 사람의 메일주소를 입력해주세요. @naver.com을 포함해서 작성해야 함
				String subject = "HnJERP"; //메일 제목 입력해주세요. 
				String body = "HnJ EMP 회사로 부터 메일을 받았습니다."+"퇴직금 영수증입니다."+content; //메일 내용 입력해주세요.
				Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 // SMTP 서버 정보 설정 
				props.put("mail.smtp.host", host); 
//				props.put("mail.smtp.port", port); 
				props.put("mail.smtp.auth", "true"); 
				props.put("mail.smtp.ssl.enable", "true"); 
				props.put("mail.smtp.ssl.trust", host);
				 //Session 생성 
//				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//				 String un = username;
//				 String pw = password;
//				 protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
//					return new javax.mail.PasswordAuthentication(un, pw);
//					 }
//				 });
//				 session.setDebug(true); //for debug 
				 
				
				//MimeMessage mimeMessage = new MimeMessage(session); //MimeMessage 생성
				MimeMessage mimeMessage = mailSender.createMimeMessage();
				
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"utf-8");
				
				
				
				helper.setFrom("xovud925@naver.com","운영자"); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 
				helper.setTo(new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
				helper.setSubject(subject); //제목셋팅 
				helper.setText(body,true); //내용셋팅 
				
			//	Transport.send(helper); //javax.mail.Transport.send() 이용
				
				mailSender.send(mimeMessage);
					
					ServiceResult result = null;
					String str = result == ServiceResult.OK ? "전송" : "실패";
							
					return  str;
		
				}
	
	
}
