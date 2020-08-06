package ERP.service.wareHouse;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.wareHouse.IEnterDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_DocumentVO;
import vo.product.StuffVO;
import vo.wareHouse.EnterStuffVO;

@Service
public class EnterBuyDocServiceImpl implements IEnterBuyDocService {

	@Inject
	IEnterDAO dao;
	
	
	@Override
	public ServiceResult createBuyDoc(Buy_DocumentVO BuyDocVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int readBuyDocCnt(PagingVO<Buy_DocumentVO> pagingVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<EnterStuffVO> readBuyDocList(String pagingVO) {
	   
		return dao.readBuyDocList(pagingVO);
	}

	@Override
	public Buy_DocumentVO readBuyDoc(int board_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult EnterMat() {
		// TODO Auto-generated method stub
		return null;
	}

}
