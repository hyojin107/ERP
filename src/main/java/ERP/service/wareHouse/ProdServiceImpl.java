package ERP.service.wareHouse;

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

import ERP.dao.wareHouse.IProdDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.wareHouse.BOMVO;
import vo.wareHouse.MaterialVO;
import vo.wareHouse.ProdVO;

@Service
public class ProdServiceImpl implements IProdService {

	@Inject
	IProdDAO prodDao;
	
	// 상품 이미지 저장 
	@Inject
	WebApplicationContext container;
	ServletContext application;

	@Value("#{appInfo.prodImgPath}")
	String prodImgPath;	// root-context 에서 불러오는 이미지 저장경로 
	File saveFolder;
	
	@PostConstruct // 객체 초기화 어노테이션 
	public void init() {
		application = container.getServletContext();
		String folderPath = application.getRealPath(prodImgPath);
		saveFolder = new File(folderPath);
		if(!saveFolder.exists()) {
			saveFolder.mkdirs();  
		}
	}
	
	private void processImg(ProdVO prodvo){
		try {
			MultipartFile prod_image = prodvo.getProd_image();
			if(prod_image != null) {
				prodvo.saveFile(saveFolder);
			}
		} catch (IOException e) {
			throw new RuntimeException();
		}
	}
	
//----------------------------------------------------------	

	@Transactional // 두개의 메소드를 실행시킬때 적용시키는 annotation
	@Override
	public ServiceResult insertProd(ProdVO prodVO) {
		int cnt = prodDao.insertProd(prodVO);
		processImg(prodVO);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ProdVO readProd(String prod_no) {
		ProdVO prodVO = prodDao.readProd(prod_no);
		if(prodVO==null) {
			throw new DataNotFoundException(prod_no+" 에 해당하는 상품이 존재하지 않습니다.");
		}
		return prodVO;
	}

	@Override
	public int readProdCount(PagingVO<ProdVO> pagingVO) {
		return prodDao.readProdCount(pagingVO);
	}

	@Override
	public List<ProdVO> readProdList(PagingVO<ProdVO> pagingVO) {
		return prodDao.readProdList(pagingVO);
	}

	@Transactional
	@Override
	public ServiceResult modifyProd(ProdVO prodVO) {
		readProd(prodVO.getProd_no());
		int cnt = prodDao.modifyProd(prodVO);
		processImg(prodVO);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
		
	@Override
	public ServiceResult modifyBOM(BOMVO bomVO) {
		int cntBOM = prodDao.modifyBOM(bomVO);
		ServiceResult result = ServiceResult.FAIL;
		if(cntBOM>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	//---------------------------------------------------원자재 검색
	@Override
	public int searchMatCnt(PagingVO<MaterialVO> pagingVO) {
		return prodDao.searchMatCnt(pagingVO);
	}
	@Override
	public List<MaterialVO> searchMatList(PagingVO<MaterialVO> pagingVO) {
		return prodDao.searchMatList(pagingVO);
	}
	
	//---------------------------------------------원자재 이름만 출력 
	@Override
	public List<String> serarchMatNameList() {
		return prodDao.serarchMatNameList();
	}
	
	//---------------------------------------------bom 정보 출력 
	@Override
	public List<BOMVO> readBomList(String prod_no) {
		return prodDao.readBomList(prod_no);
	}

	

}
