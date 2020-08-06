package ERP.service.emp;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import ERP.dao.emp.IAnnouncementDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.AnnouncementVO;
import vo.emp.EmployeeVO;

@Service
public class AnnounceServieceImpl implements IAnnouncementService {
	@Inject
	private IAnnouncementDAO annDAO;
	
	@Inject
	WebApplicationContext container;
	ServletContext application;
	
	
	@Value("#{appInfo.empImgePath}")
	String empImgePath;
	File saveFolder;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
		String folderPath = application.getRealPath(empImgePath);
		saveFolder = new File(folderPath);
		if(!saveFolder.exists()) {saveFolder.mkdirs();}
			
	}
	
	private void processImage(EmployeeVO emp) {
		try {
			MultipartFile emp_img = emp.getEmp_img();
			if(emp_img!=null) {
				emp.saveFile(saveFolder);
			}
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	
	
	
	@Override
	@Transactional
	public ServiceResult createAnnouncement(AnnouncementVO vo) {
		ServiceResult result  = annDAO.insertAnnouncement(vo)> 0? annDAO.updateAnnouncement(vo) > 0? ServiceResult.OK : ServiceResult.FAIL : ServiceResult.FAIL;
			// insert가 0보다크고  update가 >0 크면  result = ok  아니면 fail
			// insert가 0보다 작으면 fail
		return result;
	}

	
	  @Override 
	  public ServiceResult updateAnnouncement(AnnouncementVO vo) {
		  return annDAO.updateAnnouncement(vo)>0? ServiceResult.OK : ServiceResult.FAIL;
		  }
	 
	
	
	// 리스트 불러오는거 
	@Override
	public List<EmployeeVO> readAnnouncementList(PagingVO<EmployeeVO> pagingVO) {
		return annDAO.selectAnnouncementList(pagingVO);
	}

	// 리스트 카운트 
	@Override
	public int readAnnListCount(PagingVO<EmployeeVO> pagingVO) {
		return annDAO.selectAnnCount(pagingVO);
	}

	// 하나 선택 시 
	@Override
	public EmployeeVO readAnnouncement(EmployeeVO emp) {
		
		EmployeeVO ann = annDAO.selectAnnouncement(emp);
		if(ann == null) {
			throw new DataNotFoundException(emp+"에 해당하는 정보가 없습니다.");
		}
		return ann;
	}


	// 체크박스선택시 수정하는거
	@Override
	public ServiceResult statusUpdate(AnnouncementVO vo) {
		return annDAO.updateCheck(vo)>0 ? ServiceResult.OK : ServiceResult.FAIL;
	}


}
