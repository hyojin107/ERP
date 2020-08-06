package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.SellChitVO;

public interface ISellChitService {
	public ServiceResult  createSellChit(SellChitVO vo); 
	public int readSellChitCount(PagingVO<SellChitVO> pagingVO); 
	public List<SellChitVO> readSellChitList(PagingVO<SellChitVO> pagingVO); 
	public SellChitVO readSellChit(int sell_chit_no); 
	public ServiceResult modifySellChit(SellChitVO vo); 
	public ServiceResult removeSellChit(SellChitVO vo); 
}
