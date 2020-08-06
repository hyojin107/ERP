package ERP.controller.emp;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.service.emp.INoticeService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import validate.groups.UpdateGroup;
import vo.BoardVO;
import vo.PagingVO;
import vo.SearchVO;
import vo.emp.AttatchVO;
import vo.emp.NoticeVO;

@Controller
@RequestMapping("/emp/register")
public class NoticeController { // 공지사항
	@Inject
	WebApplicationContext context;
	ServletContext application;
	@Value("#{appInfo.imagePath}") // 이미지 경로 
	String imagePath;
	
	@Value("#{appInfo.imagePath}")
	File saveFolder;
	
	@Inject
	INoticeService service;
	
	
	@PostConstruct  // 초기화를 수행하는 어노테이션 
	public void init() {
		if(!saveFolder.exists()) { // 폴더가 존재 하지 않으면 
			saveFolder.mkdirs();  // temp 라는 폴더가 없어도 폴더를 생성하고 파일을 저장하는거 
		}
		application = context.getServletContext();
		System.out.println(saveFolder.getAbsolutePath());
	}
	
	// 이미지 업로드 
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE) //  미디어타입을 보낼경우 
	@ResponseBody
	public Map<String, Object> imageUpload(
			@RequestPart(required = true) MultipartFile upload) throws IllegalAccessException,IOException{
				
		Map<String, Object> result = new HashMap<>(); // map에 담아둘거를 만들고 
		
		if(!upload.isEmpty()) { // upload가 비어있지 않으면 
			String savename = UUID.randomUUID().toString(); // uuid 고유의  식별값을 만들어주는거 
			upload.transferTo(new File(saveFolder, savename));  // upload에 저장폴더랑 이름을 넣어준다. 
			String fileName = upload.getOriginalFilename();
			int uploaded = 1;
			String url = application.getContextPath()+imagePath+"/"+savename;
			result.put("fileName", fileName);
			result.put("uploaded", uploaded);
			result.put("url", url);
		}else { //upload가 비어 있으면 
			String message = "이미지가 없음";
			int number = 400;
			Map<String, Object> error = new HashMap<>();
			error.put("message", message);
			error.put("number", number);
			error.put("error", error);
			
		}
		
		return result;
		
	}
	
	
	

	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody							// text 타입으로 값만 넘기고 싶을 때 
	public PagingVO<NoticeVO> ajaxForlist( //listBody  ajax 타는곳 
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		SearchVO searchVO, Model model
		){
		list(currentPage, searchVO, model);
		return (PagingVO<NoticeVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("notice") // 공지사항 목록 나오는거 
	public String list( // 공지사항 카테고리 누르면 나오는거
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, Model model) { // 공지사항 목록 가져오는거 
		
		  PagingVO<NoticeVO> pagingVO = new PagingVO<>(); // paging 하는거 
		  pagingVO.setSearchVO(searchVO); // pagingVO의 SETTER  setSearchVO 검색어 
		  pagingVO.setCurrentPage(currentPage); // 현재창 
		  
		  int totalRecord = service.readNoticeCount(pagingVO); // 공지사항의 글의 갯수를 가져오는거 
		  pagingVO.setTotalRecord(totalRecord); // // List<BoardVO> prodList =
		  
		  List<NoticeVO> noticeList = service.readNoticeList(pagingVO); // 공지사항의 목록
		  pagingVO.setDataList(noticeList);
		  
		  model.addAttribute("pagingVO", pagingVO);
		 		
		return "emp/notice";
		
	   
   }
	
	
	
	@GetMapping("{notice_no}") // 목록에서 하나를 클릭했을떄 상세 페이지로 넘어가는거 
	public String view(@PathVariable(required = true) int notice_no, Model model) {
		NoticeVO notice = service.readNotice(notice_no); // 서비스에서 공지사항번호로 하나의 공지사항을 읽어오는거 
		model.addAttribute("notice", notice); // 컨트롤러에 넘기는거 
		return "emp/noticeView";
	}
	
	
	// 새글 쓰기 
	@GetMapping("new/noticeDeatil")
	public String newForm(@ModelAttribute("notice") NoticeVO notice) {  // 새글쓰기 폼
		return "emp/newNoticeDetail";
		
	}
	
	
	@PostMapping("notice/register") // 새글쓰기에서  등록버튼 누름
	public String post(
			@Validated(InsertGroup.class) @ModelAttribute("notice") NoticeVO notice, BindingResult errors,
			Model model) { 
		
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) {
			ServiceResult result = service.createNotice(notice);
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				goPage = "emp/newNoticeDetail";
				break;
			default: // OK
				goPage = "redirect:/emp/"+notice.getNotice_no();
				break;
			}
		} else {
			goPage = "emp/newNoticeDetail";
		}

		model.addAttribute("message", message);
	
		return "emp/notice";
		
	}

	

	
	// 파일 다운로드 
	@GetMapping("/notice/file/{att_no}")
//	@ResponseBody // 응답데이터가 직접 만들어진다??
	public String download(@PathVariable(required = true) int att_no,Model model){
		AttatchVO attatch =  service.downloadAttatch(att_no);		
//		String savename = attatch.getAtt_savename();
//		context.getResource(attatchPath+"/"+savename);
		
		
		model.addAttribute("attatch", attatch);
		
		return "downloadView";
		
		
	
	}
	
	
	// 수정버튼 클릭후 수정 페이지화면 나오는거 
	@GetMapping("/notice/{notice_no}/form") 
	public String form(@PathVariable(required = true) int notice_no, Model model) {
		if(!model.containsAttribute("notice")) {
			NoticeVO notice = service.readNotice(notice_no);
			model.addAttribute("notice", notice);
		}
		return "emp/noticeUpdate";
	}
	
	

	// 수정하고 나서 보내지는거 
	@PostMapping("update/notice")
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("notice") NoticeVO notice, 
		BindingResult errors, Model model,
		RedirectAttributes redirectAttributes
	){
		String goPage = null;
		String message = null;
		if (!errors.hasErrors()) { // 에러가 나지 않았으면 
			ServiceResult result = service.modifyNotice(notice);  // service의 값을 가져와서 
			switch (result) {
			case FAIL:
				message = "쫌따 다시 해보셈.";
				redirectAttributes.addFlashAttribute("notice", notice);
				goPage = "redirect:/emp/register/notice/{notice_no}";
				break;
			case INVALIDPASSWORD:
				message = "비번 오류.";
				redirectAttributes.addFlashAttribute("notice", notice);
				goPage = "redirect:/emp/register/notice/{notice_no}";
				break;
			default: // OK
				goPage = "emp/notice";  // 타일 주소 
				break;
			}
		} else {
			goPage = "redirect:/notice";
			redirectAttributes.addFlashAttribute("notice", notice);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.notice", errors);
		}

		model.addAttribute("message", message);

		return goPage;
		
	}

	
	// 공지사항 삭제 
	@DeleteMapping
	public String delete(
			@ModelAttribute("notice") NoticeVO notice,
			BindingResult errors,
			RedirectAttributes redirectAttributes
			) {
		String goPage = null;
		String message  = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeNotice(notice);
			switch (result) {
			case FAIL:
				message = "다시 시도해주세요.";
				goPage = "redirect:/notice/{notice_no}";  // 삭제 실패시 돌아가는 컨트롤러?
				break;

			default: //ok
				goPage = "redirect:/notice";
				break;
			}
		}else {
			goPage = "redirect:/notice/{notice_no}";
		}
		
		redirectAttributes.addFlashAttribute("message", message);  //addFlashAttribute : 요청을 처리하면 삭제됨 
		
		return goPage;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
