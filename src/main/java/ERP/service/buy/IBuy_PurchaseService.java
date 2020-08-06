package ERP.service.buy;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.buy.Buy_PurchaseVO;

public interface IBuy_PurchaseService {
	
	public ServiceResult createPurchase(Buy_PurchaseVO vo);
	
	public int readPurchaseCount(PagingVO<Buy_PurchaseVO> pagingVO);
	
	public List<Buy_PurchaseVO> readPurchaseList(PagingVO<Buy_PurchaseVO> pagingVO);
	
	/**
	 * @param purVO
	 * @return 매입서 삭제
	 */
	public ServiceResult deletePurchase(Buy_PurchaseVO purVO);
}
