package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IMaterialDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Service
public class MaterialServiceImpl implements IMaterialService {

	@Inject
	IMaterialDAO matDao;
	
	@Override
	public ServiceResult insertMat(MaterialVO matVO) {
		int cnt = matDao.insertMat(matVO);
		
		ServiceResult result = null;
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public MaterialVO readMat(String mat_no) {
		MaterialVO matVO = matDao.readMat(mat_no);
		if(matVO==null) {
			throw new DataNotFoundException(mat_no+" 에 해당하는 원자재가 존재하지 않습니다.");
		}
		return matVO;
	}

	@Override
	public int readMatCount(PagingVO<MaterialVO> pagingVO) {
		return matDao.readMatCount(pagingVO);
	}

	@Override
	public List<MaterialVO> readMatList(PagingVO<MaterialVO> pagingVO) {
		return matDao.readMatList(pagingVO);
	}

	@Override
	public ServiceResult modifyMat(MaterialVO matVO) {

		readMat(matVO.getMat_no());
		int cnt =  matDao.modifyMat(matVO);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

//	@Override
	public ServiceResult deleteMat(MaterialVO matVO) {
		// 사용여부가 사용중 -> 사용중지 로 바뀌게 한다 
		return null;
	}

}
