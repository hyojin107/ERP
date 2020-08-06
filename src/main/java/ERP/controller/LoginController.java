package ERP.controller;

import java.io.IOException;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import ERP.dao.emp.IEmployeeDAO;
import ERP.service.IAuthenticatieService;
import ERP.service.emp.IEmployeeService;
import enums.ServiceResult;
import utils.CookieUtils;
import utils.CookieUtils.TextType;
import vo.emp.EmployeeVO;

@Controller
@RequestMapping("/")
public class LoginController {
	/*
	 * @Inject WebApplicationContext container; ServletContext application;
	 */
	
	@GetMapping  // 메인화면 로그인 화면
	public String index() {
		return "log";
	}
	
	
	@Inject   // 컨테이너를 받아올수있다. 
	WebApplicationContext container; 
	ServletContext application;

	
	@PostConstruct 
	public void init() {
		application = container.getServletContext();
	}
	
	private static final long serialVersionUID = 1L;
	
	@Inject
	private IAuthenticatieService service;
	@Inject
	private IEmployeeService empService;
	@Inject
	IEmployeeDAO empDao;
	

//	@URIMapping(value="/login/login.do", method=HttpMethod.POST)
	@PostMapping("main")
	public String doPost(HttpSession session,
						@RequestParam(required = true) String emp_no, 
						@RequestParam(required = true) String emp_pass, 
						@RequestParam(required = false) String idSave,
						HttpServletResponse response,
						Model model) throws ServletException, IOException {		
	// 3. 검증    
		String goPage = null;
		String message = null;
	
			EmployeeVO emp = new EmployeeVO(emp_no, emp_pass);
			 ServiceResult result = service.authenticated(emp);
//		 	1) 통과
//		 		a) 인증 (id==password)
			if(ServiceResult.OK.equals(result)){
//		 			성공 : 웰컴페이지로 이동, redirect (command 처리 완료)
				goPage = "mypage/main";
				session.setAttribute("authUser", emp);
				Cookie idCookie = CookieUtils.createCookie("idCookie", emp_no, 
						application.getContextPath(), TextType.PATH);
				int maxAge = 0;
				if("saveId".equals(idSave)) {
					maxAge = 60*60*24*7;
				}
				idCookie.setMaxAge(maxAge);
				response.addCookie(idCookie);
				
			}else{
//		 			실패 : loginForm.jsp 로 이동, forward
				goPage = "redirect:/";
				message = "존재하지 않거나, 비번 오류, 인증 실패";
			}
		
		
//		model.addAttribute("message", message); // session scope 에 attribute 저장.
		
		return goPage;

	}
	
	
	// 비밀번호 찾기 
	
	@PostMapping(value="mailSender", produces = "text/plain;charset=UTF-8") // 확인버튼 눌렀을떄
	public String mailSender(HttpServletRequest request,
			@RequestParam(required =false) String emp_no, 
			@RequestParam(required = false) String emp_name,
			@RequestParam(required = false) String  emp_email
			) throws AddressException, MessagingException{
		
		String goPage = null;
		String message = null;
		
		
			// 입력한 값과 db의 값이 같은지 확인 
			// jsp에서 입력 받은 값을 서비스에 넣어주고 emp에 담는다. 
			EmployeeVO emp = empService.readEmployee(emp_no); // 사원의 정보를 불러오는거 
			if(emp != null && emp.getEmp_email().equals(emp_email) && emp.getEmp_no().equals(emp_no) && emp.getEmp_name().equals(emp_name)) {
			// emp가 vo에 있고  기존의 db의 이메일,이름,사원id가  같으면  
			//임시비밀번호를 랜덤으로 생성 
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
			int idx = 0;
			StringBuffer sb = new StringBuffer();  // 임시번호를 넣어줄 sb를 만듬 
			for (int i = 0; i < 10; i++) {   // 비밀번호 10자리를 생성 
				idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를 Int로 추출 (소숫점제거)
				sb.append(charSet[idx]); // sb에 숫자를 넣기
			}
			emp.setEmp_pass(sb.toString());  // 사원의 emp_pass에 새로운 임시번호를 담아주는거 
			// db에 업뎃 해주는거 
			empDao.update_pw(emp);//  비밀번호를  업데이트 하느느거 
		
		// 메일 전송하는거 
		// 네이버일 경우 smtp.naver.com 을 입력합니다. 
		// Google일 경우 smtp.gmail.com 을 입력합니다. 
		String host = "smtp.naver.com";
		// 회사에서 보내는거 
		final String username = "jungjuhwan10"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 
		final String password = "090722vvss"; //네이버 이메일 비밀번호를 입력해주세요. 
		int port=465; //포트번호
		
		// 메일 내용 
		String recipient = emp_email; //받는 사람의 메일주소를 입력해주세요. @naver.com을 포함해서 작성해야 함
		String subject = "HnJERP"; //메일 제목 입력해주세요. 
		String body = username+"님으로 부터 메일을 받았습니다."+sb+"새로운 임시 비밀번호입니다."; //메일 내용 입력해주세요.
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
	
		message = "다시 입력해주세요";
		return message;

	}
	
	@GetMapping("loginForm/passWordSearch") //jsp 에서 비밀번호 찾기를 누르면 화면으로 이동하는거 
	public String passSearch() {
		return "loginForm/passWordSearch";
		
	}
	
	
	
}

