package ERP.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vo.MailRequestVO;
import vo.MailVO;

@Controller
@RequestMapping("/mail")
public class MainController {
	
	@Autowired
	private MimeAttachNotifier notifier;
	
	
	@RequestMapping(value="/mailForm",method=RequestMethod.GET)
	public String mailGet() throws Exception{
		String url="mail/mailForm";
		return url;
	}
	
	@RequestMapping(value="/send",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String mailPost(MailRequestVO mail,
				   		   HttpServletRequest request,	
				   		   HttpServletResponse response,
				   		   RedirectAttributes rttr ) throws Exception{
		
		String url="redirect:/mail/success";
		
		
		try {
			// 1. 파일저장..
			Map<String,Object> resultMap =  saveFile(mail,request,response);
			
			// 2. 메일 메세지 생성 후 메일 보내기		
			notifier.sendMail(mail, (String)resultMap.get("uploadPath"));
		
			// 3. 메일 성공 후 Service 호출 DB에 내역 저장.
			//mailService.sendMessage(mailVO)		
				
			// 4. 해당 내역을 attribute 저장.
			rttr.addFlashAttribute("result",resultMap.get("mailVO"));
		
		}catch(Exception e) {
			url="redirect:/mail/fail";
		}		
		
		return url;
	}
	
	@RequestMapping("/success")
	public void mailSuccess()throws Exception{}
	
	@RequestMapping("/fail")
	public void mailFail()throws Exception{}
	
	
	private Map<String,Object> saveFile(MailRequestVO mail,  
										HttpServletRequest request,
										HttpServletResponse response) throws Exception{
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		
		MultipartFile attach=mail.getFile();
		String savePath="";
		String uploadPath="";
		//파일유무
		if(attach!=null && !attach.isEmpty()){
			//파일의크기
			if(attach.getSize()<1024*1024*5){
				//파일저장
				uploadPath=request.getSession().getServletContext()
						          .getRealPath("resources/mail_attach");
				File file = new File(uploadPath,attach.getOriginalFilename());
				
				if(!file.exists()) {
					file.mkdirs();
				}
				
				attach.transferTo(file);
				
				savePath=file.getAbsolutePath();
				
				MailVO mailVO = mail.toMailVO();
				mailVO.setFile(savePath);
				
				resultMap.put("mailVO",mailVO);
				resultMap.put("uploadPath",uploadPath);
						
			}else{
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out=response.getWriter();			
				out.println("<script>alert('용량초과 입니다!');</script>");
				out.println("<script>history.go(-1);</script>");
				throw new Exception("용량 초과");
			}
			
		}
		
		return resultMap;
		
	}
	
	
	
}