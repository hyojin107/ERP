package ERP.service.account;

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

import ERP.dao.account.IFixAssetsDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.account.FixAssetsVO;

@Service
public class FixAssetsServiceImpl implements IFixAssetsService{
	@Inject
	IFixAssetsDAO dao;
	
	@Inject
	WebApplicationContext container;
	ServletContext application;
	@Value("#{appInfo.fixPath}")
	String fixImagePath;
	File saveFolder;
	@PostConstruct
	public void init(){
		application = container.getServletContext();
		String folderPath = application.getRealPath(fixImagePath);
		saveFolder = new File(folderPath);
		if(!saveFolder.exists()) saveFolder.mkdirs();
	}

	@Override
	@Transactional
	public ServiceResult createFixAssets(FixAssetsVO vo) {
		ServiceResult result =dao.insertFixAsset(vo)>0?ServiceResult.OK:ServiceResult.FAIL; 
		processImage(vo);
		return result;
	}

	private void processImage(FixAssetsVO vo) {
		try {
			MultipartFile image = vo.getImg();
			if(image!=null) {
					vo.saveFile(saveFolder);
				}
			} catch (IllegalStateException | IOException e) {
				throw new RuntimeException(e);
			}		
	}

	@Override
	public int readFixAssetsCount(PagingVO<FixAssetsVO> pagingVO) {
		return dao.selectFixAssetsCount(pagingVO);
	}

	@Override
	public List<FixAssetsVO> readFixAssetsList(PagingVO<FixAssetsVO> pagingVO) {
		return dao.selectFixAssetsList(pagingVO);
	}

	@Override
	public FixAssetsVO readFixAssets(int fixassets_no) {
		return dao.selectFixAsset(fixassets_no);
	}

	@Override
	public ServiceResult modifyFixAssets(FixAssetsVO vo) {
		ServiceResult result = dao.updateFixAssets(vo)>0?ServiceResult.OK:ServiceResult.FAIL;
		if(vo.getImg() != null && StringUtils.isNotBlank(vo.getImg().getOriginalFilename()))	processImage(vo);
		return result;
	}

	@Override
	public ServiceResult removeFixAssets(FixAssetsVO vo) {
		return null;
	}

}
