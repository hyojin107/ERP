package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.account.SellChitVO;

@Repository
public interface ISellChitDAO {
	public int readSellChitCount(PagingVO<SellChitVO> pagingVO); 
	public int insertSellChit(SellChitVO vo);
	public List<SellChitVO> selectSellChitList(PagingVO<SellChitVO> pagingVO);
	public SellChitVO selectSellChit(int sell_chit_no);
	public int updateSellChit(SellChitVO vo);
	public int deleteSellChit(SellChitVO vo);
}
