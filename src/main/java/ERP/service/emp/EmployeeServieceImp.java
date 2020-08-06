package ERP.service.emp;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import ERP.dao.emp.IEmployeeDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.DepartmentVO;
import vo.emp.EMP_CertVO;
import vo.emp.EmployeeVO;
@Service
public class EmployeeServieceImp implements IEmployeeService {
	@Inject
	WebApplicationContext container;
	ServletContext application;
	
	@Value("#{appInfo.empImgePath}") // src/main/resources appInfo.proterties에 등록된 파일을 저장할 경로를 
	String empImgePath;
	File saveFolder;
	
	@Inject
	private IEmployeeDAO dao;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
		String folderPath = application.getRealPath(empImgePath); // 이미지의 경로를 받아서 저장 폴더 변수 명에 넣어주는거 
		saveFolder = new File(folderPath);
		if(!saveFolder.exists()) {saveFolder.mkdirs(); }
		// 폴더가 존재 하지 않으면  saveFoler파일를 폴더를 생성하는거ㅓ   
		//mkdirs --> c드라이브에 temp라는 폴더가 없는 경우temp폴더를 생성하고 그안에 log폴더를 생성 
	}
	
	
	private void processImage(EmployeeVO emp) { // 파일 저장하는거 
		try {
			MultipartFile emp_img = emp.getEmp_img();
			if(emp_img != null) { // 이미지가 있으면 
				emp.saveFile(saveFolder);
			}
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	// 사원 등록 
	@Transactional
	@Override
	public ServiceResult createEmployee(EmployeeVO vo) {
		ServiceResult result = null;
		int cerNoPK = dao.selectCerNO();	//마지막 pk+1값
		int cerSize = vo.getEmpCertVOList().size();
		if(cerSize!=0) {
			for(EMP_CertVO cer : vo.getEmpCertVOList()) {
				cer.setCert_no(cerNoPK++);	//empCertVOList의 PK를 넣어줌
			}
		}
		
		
		// 사원등록 
		int id = dao.insertEmployee(vo); 
		
		processImage(vo);
		// 메소드 processImage에 값 넘겨주는거 , 사진을 폴더에 저장하는거  vo에는 emp_no가 없어서 사원번호가 먼저 만들어지고 이미지를 저장해야 하는거 
		
		if(id > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		String depNa = dao.departName(vo);
		String depNo = dao.deparNo(vo);
		
		DepartmentVO dvo = new DepartmentVO();
		dvo.setDep_name(depNa);
		dvo.setDep_no(depNo);
		vo.setDepVO(dvo);
		
		 
		return result;
	}

	// 모달에서 employee 수정 - update랑 insert 하는거 
	@Override
	public ServiceResult modifyEmployee(EmployeeVO vo) {
		System.out.println(vo);
		ServiceResult result = null;
//		EmployeeVO saveEmp = readEmployee(vo.getEmp_no());
		 	processImage(vo); // 이미지 저장
		 
			int cnt  = dao.updateEmployee(vo); 
		
			if(cnt>0) {
				result = ServiceResult.OK; 
			}else {
				result = ServiceResult.FAIL; 
			}
			
			// 추가한 사항이 있으면 행을 인서트하는거 
			if((vo.getEmpCertVOList() != null)||(vo.getCareerVOList() !=null)||(vo.getEduVOList() !=null)) { 
			
			
			// 자격증 번호 cert_no pk를 불러오는거	
			 int cert_no = 	dao.selectCerNO(); 
			 // 자격증이 있는 만큼 돌리는거 
			 if(vo.getEmpCertVOList()!=null) {
				 // 자격증이 있으면
			 for(int i =0;  i < vo.getEmpCertVOList().size(); i++) { // 자격증의 갯수만큼 for문
				 vo.getEmpCertVOList().get(i).setCert_no(cert_no++);  // 자격증의 번호를 1씩중가 
			 	}
			 	dao.insertCer(vo); // 자격증을 dao에 넣어줌
			 	
			 }
			 
		
			 
			}
			
			
		if(vo.getEmp_img() !=null && StringUtils.isNotBlank(vo.getEmp_img().getOriginalFilename())) processImage(vo);	
		return result;
		
	}


	
	// 사원한명으 정보를 불러오는거 
	@Override
	public EmployeeVO readEmployee(String emp_no) {
		EmployeeVO emp = dao.selectEmployee(emp_no);
		
		if(emp == null ) throw new DataNotFoundException(emp_no +"해당하는 사원이 없습니다.");
		return emp;
	}

	
	

	//사원리스트 나오
	@Override
	public List<EmployeeVO> readEmployeeList(PagingVO<EmployeeVO> pagingVO) {
		return dao.selectEmployeeList(pagingVO);
	}

	
	@Override
	public int readEmpListCount(PagingVO<EmployeeVO> paingVO) {
		return dao.selectEmpCount(paingVO);
	}



	
	// 모달 자격증은 트리거에서 삭제 하는거 
	// 모달에서 자격증 추가 
	// 사원을 등록할때 하는거 
	public ServiceResult creatModalCert(EmployeeVO vo) {
		ServiceResult result = dao.insertEmployee(vo)>0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}


	// 비밀번호 업뎃 
	@Override
	public ServiceResult modifyPW(EmployeeVO vo) {
		// 입력받은 아이디와 이메일이 같으면 이메일을 전송
		// 입력받은 아이디와 이메일이 같지 않으면 제자리로 
		
		
		ServiceResult result = dao.update_pw(vo)>0 ?ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
