package ERP.controller.emp;

import java.util.List;
import java.util.Properties;

import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.emp.ISalary_SpecificationService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.BoardVO;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.Salary_CalVO;
import vo.emp.Salary_TransVO;

@Controller
@RequestMapping("/emp/salary")
public class SalaryController { // 급여

	@Inject
	private ISalary_SpecificationService service;
//	@Inject
//	private  ISalary_SpecificationDAO dao;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<Salary_TransVO> ajaxForlist(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model,EmployeeVO emp
			){
		list(currentPage, emp, model);
		return (PagingVO<Salary_TransVO>) model.asMap().get("pagingVO"); 
	}
	
	
	@GetMapping("salaryInfoList")
	public String list( // 사원 급여 내역 리스트  
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp,
			Model model ){
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readSaralyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<EmployeeVO> salaryList = service.readSalaryList(pagingVO);
		pagingVO.setDataList(salaryList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/salaryList"; // 급여 기본정보 리스트
	}
	

	
	@GetMapping("salaryEmailSend") // 급여 메일발송 리스트 
	public String salaryEmailSend(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp,
			Model model) {
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readSaralyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<EmployeeVO> salaryList = service.readMailList(pagingVO);  // xml 결과값
		pagingVO.setDataList(salaryList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/salaryEmail";
	}
	
	@GetMapping("emailModal") //  메일발송 모달 
	public String emailModal(@ModelAttribute("salaryVO") Salary_TransVO salaryVO) {
		return "emp/emailModal";
	}
	
	
	// 리스트에서 행 하나 클릭했을 때 이어지는 부분
	@ModelAttribute("currentAction")
	public String currentAction() {
		return "/emp";
	}
	
	
	//목록하나를 클릭했을때  모달창  띄우는거 
	@GetMapping("{emp_no}")
	public String view( // 모달에는 path가 들어가야 한다 
			@PathVariable(required = true) String emp_no, //  주소를 변수로  사용할떄 path를 사용
			Model model) {
		EmployeeVO vo = new EmployeeVO();
		vo.setEmp_no(emp_no);
		EmployeeVO emp = service.raeadSalaryn(vo);
		model.addAttribute("emp", emp);
		return "/emp/salaryForm";
	}
	
	// 급여 정책 카테고리 연결 
	@GetMapping("salaryCal")
	public String salaryCal(Model model) { // Salary_CalVO cal이거를 
		List<Salary_CalVO > cal =  service.readSalaryCal(); // service의 결과값을 cal에 담아서 
		model.addAttribute("cal",cal); // cal은 list 형태   "cal" 로 명칭하여 jsp에 보내서 jsp에서 사용하는거 
		return "emp/salary_Cal";
		
	}
	
	// 여기부분 다시하기 07/11  급여 수정 --ok
	// 급여 정책  수정 
	@PostMapping(produces = "text/plain;cahrset=UTF-8")  // ajax 값을  text로 보내야 한는거 
	@ResponseBody  // 리턴 값이 없어도 되고  성공인지 실패인지 리턴
	public String updateSalary(
		@Validated(UpdateGroup.class) Salary_CalVO scVO,  // jsp에서  ajax값을 받아서 vo에 자동으로  담긴다.
		BindingResult errors
			) {
		ServiceResult result = null;
		
		if(!errors.hasErrors()) {
			result = service.modifySalaryCal(scVO);
		}
		String str = result == ServiceResult.OK ? "수정완료" : "수정실패";
				
		return str;
		 
		
	}
	
	// 급여 메일로 전송(체크박스로 선택해서 메일로 발송하기 )
	@PostMapping(value = "salaryMail",produces = "text/plain;charset=UTF-8")
	private String salaryMail(HttpServletRequest req)throws AddressException, MessagingException{
		
		// 메일 전송하는거 
				// 네이버일 경우 smtp.naver.com 을 입력합니다. 
				// Google일 경우 smtp.gmail.com 을 입력합니다. 
				String host = "smtp.naver.com";
				// 회사에서 보내는거 
				final String username = "jungjuhwan10"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 
				final String password = "090722vvss"; //네이버 이메일 비밀번호를 입력해주세요. 
				int port=465; //포트번호
				
				// 메일 내용 
				String subject = "HnJERP"; //메일 제목 입력해주세요. 
				String body  = username+"으로부터 메일을 받았습니다.";
				Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
				
				// SMTP 서버 정보 설정 
				props.put("mail.smtp.host", host); 
				props.put("mail.smtp.port", port); 
				props.put("mail.smtp.auth", "true"); 
				props.put("mail.smtp.ssl.enable", "true"); 
				props.put("mail.smtp.ssl.trust", host);
				
				//Session 생성 
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				 String un = username;
				 String pw = password;
				 protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
					return new javax.mail.PasswordAuthentication(un, pw);
					 }
				 });
				 session.setDebug(true); //for debug 
				
				 Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
				mimeMessage.setFrom(new InternetAddress("jungjuhwan10@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요. 

				InternetAddress[] toAddr = new InternetAddress[10];
				//************** 선택한 값의 리스트배열의 메일로 이메일 보내기
				// 예시
				// toAddr[0] = new internetAddress("보낼메일주소 ");
				
				mimeMessage.setRecipients(Message.RecipientType.TO, toAddr);
				
				mimeMessage.setSubject(subject); //제목셋팅 
				mimeMessage.setText(body); //내용셋팅 
				Transport.send(mimeMessage); //javax.mail.Transport.send() 이용 
					
					ServiceResult result = null;
					String str = result == ServiceResult.OK ? "전송완료" : "전송실패";
							
					return  str; // 컨트롤러로 넘어가는 부분 
	}
	
	
}

