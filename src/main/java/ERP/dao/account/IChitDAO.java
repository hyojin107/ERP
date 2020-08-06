package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.account.ChitVO;

@Repository
public interface IChitDAO {
	public int insertChit(ChitVO vo);
	public int selectAllChitCount(PagingVO<ChitVO> pagingVO); 
	public List<ChitVO> selectAllChitList(ChitVO vo);
	public int selectBuyChitCount(PagingVO<ChitVO> pagingVO); 
	public List<ChitVO> selectBuyChitList(PagingVO<ChitVO> pagingVO);
	public int selectSellChitCount(PagingVO<ChitVO> pagingVO); 
	public List<ChitVO> selectSellChitList(PagingVO<ChitVO> pagingVO);
	public ChitVO selectChit(ChitVO	vo);
	public int updateChit(ChitVO vo);
	public int deleteChit(ChitVO vo);
	public int buySell(int year);
}
