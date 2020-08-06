package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.BuyChitVO;

public interface IBuyChitService {
	public ServiceResult  createBuyChit(BuyChitVO vo); 
	public int readBuyChitCount(PagingVO<BuyChitVO> pagingVO); 
	public List<BuyChitVO> readBuyChitList(PagingVO<BuyChitVO> pagingVO); 
	public BuyChitVO readBuyChit(int buy_chit_no); 
	public ServiceResult modifyBuyChit(BuyChitVO vo); 
	public ServiceResult removeBuyChit(BuyChitVO vo); 
}
