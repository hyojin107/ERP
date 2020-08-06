package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IOuterDao;
import vo.PagingVO;
import vo.wareHouse.ProdVO;

@Service
public class OuterProdServiceImpl implements IOuterProdService {

	@Inject
	IOuterDao outerDAO; 
	
	@Override
	public int ProdLackCnt(PagingVO<ProdVO> pagingVO) {
		return outerDAO.ProdLackCnt(pagingVO);
	}

	@Override
	public List<ProdVO> ProdLackList(PagingVO<ProdVO> pagingVO) {
		return outerDAO.ProdLackList(pagingVO);
	}

}
