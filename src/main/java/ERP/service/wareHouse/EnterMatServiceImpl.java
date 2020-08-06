package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IEnterDAO;
import vo.PagingVO;
import vo.wareHouse.MaterialVO;

@Service
public class EnterMatServiceImpl implements IEnterMatService {

	@Inject
	IEnterDAO enterDao;
	
	@Override
	public int MatLackCnt(PagingVO<MaterialVO> pagingVO) {
		return enterDao.MatLackCnt(pagingVO);
	}
	
	@Override
	public List<MaterialVO> MatLackList(PagingVO<MaterialVO> pagingVO) {
		return enterDao.MatLackList(pagingVO);
	}

	
}
