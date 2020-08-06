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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.emp.IEmpListDAO;
import ERP.service.emp.IAnnouncementService;
import ERP.service.emp.IEmployeeService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import validate.groups.UpdateGroup;
import vo.PagingVO;
import vo.emp.AnnouncementVO;
import vo.emp.EmployeeVO;


@Controller
@RequestMapping("/emp/manage/ann")
public class AnnouncementController {// 발령
	
	@Inject
	IAnnouncementService service;
	@Inject
	IEmpListDAO dao;
	@Inject
	IEmployeeService empService;
	
//	@ModelAttribute("currentAction")
//	public String currentAction() {
//		return "/emp/manage/ann";
//	}
	
	
	
	private void attributeSetting(Model model) {
		model.addAttribute("annList",dao.selectAnnList()); // 발령 상태  jsp에서 리스트로 뿌려주는거 
		
	}
	
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AnnouncementVO> ajaxForlist(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			Model model,EmployeeVO emp
			){
		empList(currentPage, emp, model);
		return (PagingVO<AnnouncementVO>) model.asMap().get("pagingVO"); 
	}
	
	// 인사발령 사원등록 버튼을 누르면 등록되는거
	@PostMapping("newAnnouncement")
	public String insert(
			@Validated(InsertGroup.class) @ModelAttribute("ann") AnnouncementVO ann, 
			BindingResult errors, Model model
			) {
		
			String goPage = null;
			String message = null;
			if(!errors.hasErrors()) {
				ServiceResult result = service.createAnnouncement(ann); // 파라미터 값으로 받은 결과를 result에 담고
				switch(result) { //  결과 result 값이 fail이면  실패 --> 리스트페이지로 이동 
				case FAIL :
					message = "등록 실패, 다시 등록해주세요.";
					goPage = "emp/manage/ann/newAnnouncement";
					break;
				default : //ok
					goPage = "redirect:/emp/manage/ann/announcementList";
					break;
						
				}
			}else {
				goPage ="emp/manage/ann/newAnnouncement";
			}
		
			model.addAttribute("message",message);
			
			return goPage;
		
	}
	
	
	
	
	// 발령 리스트 가져오기
	@GetMapping("announcementList")
	public String empList( 
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			EmployeeVO emp, Model model
			){
			PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
			pagingVO.setDetailSearch(emp);
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = service.readAnnListCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
				
			List<EmployeeVO> annList = service.readAnnouncementList(pagingVO);
			pagingVO.setDataList(annList);
			
			model.addAttribute("pagingVO", pagingVO);
				
			return "emp/announcementList";
	}
	
	//  사원 클릭하면 사원의 정보 모달창으로 나오는거 
	@GetMapping("/{ann_no}")
	public String annModal(
			@PathVariable(required = true) Integer ann_no, // 맵핑되는 값 (ann_no)
			Model model
			) {
		EmployeeVO vo = new EmployeeVO();
		vo.setAnn_no(ann_no);
		EmployeeVO emp = service.readAnnouncement(vo);
		model.addAttribute("emp",emp);
		return "/emp/announcementDetail";
		
	}
	
	
	// 신규발령 등록 버튼 누르면  화면전화되어 폼 나오는거 
		@GetMapping("announcementNewUpdate")
		public String newAnnForm(Model model) throws Exception{
			attributeSetting(model);  // annList 가져오는거 
			model.addAttribute("currentAction","/emp/manage/ann/newAnnouncement");
	
			return "emp/announcementNewRegister";
		}
		
	
	// 검색 버튼-> 모달창-> 행 하나클릭-> 페이지에 사원정보 뿌려짐 
	// empcontroller에 연결
	
	
//	  @PutMapping("/{ann_no}")
//	  
//	  @ResponseBody // 화면 public String check(
//	  
//	  @Validated(UpdateGroup.class) AnnouncementVO vo, BindingResult errors ) {
//	  StringBuffer str = new StringBuffer("ann_no:"); if(!errors.hasErrors()) {
//	  ServiceResult result = service.updateAnnouncement(vo); } // return result;
//	  return null;
//	 
//	}
	
	@PostMapping(produces = "text/plain;charset=UTF-8" )
	@ResponseBody
	public String statusUpdate(
			@Validated(UpdateGroup.class) AnnouncementVO vo,
			BindingResult errors
			) {
		ServiceResult result = null;
				
//		StringBuffer str  = new StringBuffer("ann_no:"); // 
		if(!errors.hasErrors()) {
			 result = service.statusUpdate(vo);
		}
		
	 String str = result  == ServiceResult.OK ? "수정성공" : "수정 실패";
	 return str;
		
	}
	
	
		
	}

	
