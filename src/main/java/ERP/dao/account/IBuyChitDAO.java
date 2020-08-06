package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.account.BuyChitVO;

@Repository
public interface IBuyChitDAO {
	public int selectBuyChitCount(PagingVO<BuyChitVO> pagingVO);
	public int insertBuyChit(BuyChitVO vo);
	public List<BuyChitVO> selectBuyChitList(PagingVO<BuyChitVO> pagingVO);
	public BuyChitVO selectBuyChit(int buy_chit_no);
	public int updateBuyChit(BuyChitVO vo);
	public int deleteBuyChit(BuyChitVO vo);
}
