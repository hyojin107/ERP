package ERP.controller.emp;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.List;
import java.util.Map;
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
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.emp.IEmpListDAO;
import ERP.service.emp.IEmployeeService;
import enums.ServiceResult;
import validate.groups.UpdateGroup;
import vo.BoardVO;
import vo.PagingVO;
import vo.SearchVO;
import vo.emp.AttatchVO;
import vo.emp.DepartmentVO;
import vo.emp.EMP_CertVO;
import vo.emp.EducationVO;
import vo.emp.Emp_CareerVO;
import vo.emp.EmployeeVO;
import vo.emp.Salary_TransVO;

@Controller
@RequestMapping("/emp/manage")
public class EmployeeController { // 

	@Inject 
	IEmployeeService service;
	@Inject
	IEmpListDAO dao;
	

			
	private void attributeSetting(Model model) {
		
//		  model.addAttribute("certList", dao.selectLicensList()); //
		model.addAttribute("posList", dao.selectPosList()); //
		model.addAttribute("solList", dao.selectSolidList()); //
		model.addAttribute("fullList", dao.selectFulltime()); // 
	}
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody  // 급여 리스트 보여주는거???
	public PagingVO<Salary_TransVO> ajaxForlist(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model,EmployeeVO emp
			){
		empList(currentPage, emp, model);
		return (PagingVO<Salary_TransVO>) model.asMap().get("pagingVO"); 
	}
	
	
	// 사원 리스트
	@GetMapping("empList")
	public String empList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp, Model model
			){
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(emp);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readEmpListCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
	
		List<EmployeeVO> empList = service.readEmployeeList(pagingVO);
		pagingVO.setDataList(empList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("currentAction","/emp/manage/");
		return "emp/empList"; 
		
	}
	
	// 목록하나 클릭했을때  상세보기 모달 창으로  상세정보 가져오기  
	@GetMapping("{emp_no}")
	public String view(
			@PathVariable(required = true) String emp_no,
			Model model) {
		attributeSetting(model);
		model.addAttribute("currentAction","/emp/manage/empInput"); // 모달창이 뿌려질때 주소도 같이 들어가야 한다. 
		EmployeeVO vo = new EmployeeVO();
		vo.setEmp_no(emp_no);
		EmployeeVO emp = service.readEmployee(emp_no); // 파라미더로 string 으로 받아야 하는데 서비스가 employeevo 일때 vo를 새로 만들어서 넣어준다.  
		model.addAttribute("emp", emp);  // 사원정보가져오는거 
		return "/emp/empinfoModal";
	}

	
	@GetMapping("empinformation") // 인사등록 폼 가져오는거 
	public String doGet(Model model) throws ServerException, IOException{ // 
		attributeSetting(model);
		model.addAttribute("currentAction", "/emp/manage/empInput");
		return "emp/empinformation";
			}
	
	
	// 인사등록 후  전송
	@PostMapping("empInput")  
	public String doPost(@Valid @ModelAttribute("emp") EmployeeVO emp, 
						@ModelAttribute("dep") DepartmentVO dep,
						@RequestBody @ModelAttribute("emp_career") Emp_CareerVO emp_career,
						@RequestBody @ModelAttribute("emp_certvo") EMP_CertVO emp_certvo,
						@RequestBody @ModelAttribute("edu") EducationVO edu,
						@ModelAttribute("attr") AttatchVO attr,
						BindingResult errors,						
						Model model,
						RedirectAttributes redirectAttributes, // session 으로 전달하는거 
						@RequestParam(required = false) String currentPage
//						@RequestParam("file") MultipartFile file
						) throws IllegalStateException, IOException, AddressException, MessagingException  { // �궗�썝�쓣 泥섏쓬 �벑濡앺븯怨� 踰꾪듉�쓣 �닃���쓣 �븣
		attributeSetting(model);

//		model.addAttribute("currentAction", "/emp/manage/empInput"); // currentActtion에 기본 페이지 경로 설정 

		String goPage = null;
		String message = null;
		
		if(!errors.hasErrors()) {
//			MultipartFile emp_img = emp.getEmp_img();
			
			ServiceResult result = service.createEmployee(emp);
			switch (result) {
			case FAIL:
				message = "다시 등록해주세요";
				goPage = "emp/empinformation";
				break;

			default:
				message = "새로운 사원을 등록했습니다.";
				goPage = "redirect:/emp/manage/empList";
				sendMail(emp);
//				redirectAttributes.addFlashAttribute("lastUpdateEmp", emp);  // lastUpdateEmp--> update컨트롤러에 있음 
				break; //addFlashAttribute : 전달한 값은  url뒤에 붙지 않는  일회성, 리프레시할 경우 데이터 소멸 
			}
		}else {
			goPage = "emp/empinformation";
		}
		
		model.addAttribute("message", message);
		return goPage;
	}
	
	// 사원 등록 후 메일로 보내질 내용 
	private String sendMail(EmployeeVO vo) throws AddressException, MessagingException {
		String host = "smtp.naver.com";
		// 회사에서 보내는거 
		final String username = "jungjuhwan10"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 
		final String password = "090722vvss"; //네이버 이메일 비밀번호를 입력해주세요. 
		int port=465; //포트번호
		
		// 메일 내용 
		String recipient = vo.getEmp_email(); //받는 사람의 메일주소를 입력해주세요. @naver.com을 포함해서 작성해야 함
		String subject = "HnJERP"; //메일 제목 입력해주세요. 
		String body = username+"님으로 부터 메일을 받았습니다."+
							vo.getEmp_name()+" 님의  사원 id와 비밀번호입니다."+
							"사원 id :"+vo.getEmp_no()+"임시 비밀번호는 "+vo.getEmp_pass(); //메일 내용 입력해주세요.
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 // SMTP 서버 정보 설정 
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
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
		mimeMessage.setSubject(subject); //제목셋팅 
		mimeMessage.setText(body); //내용셋팅 
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용 
			
			ServiceResult result = null;
			String str = result == ServiceResult.OK ? "전송완료" : "전송실패";
					
			return  str;
	}
	
	
	// update시 db에서 트리거 발생해서  추가항목을 삭제해준다ㅣ. db 트리거 확인
	//  모달창에서 수정 하는거
	@ResponseBody()  // 수정성공이라는 글자가 그대로 jsp로 날아가는거 
	@PostMapping(value="empInput/{emp_no}", produces = "text/plain;charset=UTF-8")
	public String update(
			@PathVariable String emp_no,
			@Validated(UpdateGroup.class) @ModelAttribute("emp") EmployeeVO emp,
			BindingResult errors,
			Model model
			
			){
//		model.addAttribute("currentAction", "/emp/manage/empInput");
		ServiceResult result = null;
		if(!errors.hasErrors()) {
			result = service.modifyEmployee(emp);
			
		}
		String str = result == ServiceResult.OK ? "수정성공" : "수정실패";
		return str;
		
	}
	
	
	@GetMapping("departmentList")
	public String list( // 부서별 인사현황 가져오는거 
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
		
		return "emp/departmentList"; // 遺��꽌蹂� �씤�궗�쁽�솴  
	}
	

	
	
}
