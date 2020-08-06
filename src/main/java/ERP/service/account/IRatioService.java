package ERP.service.account;

import java.util.List;

import vo.PagingVO;
import vo.account.RatioVO;

public interface IRatioService {
	public int readRatioCount(PagingVO<RatioVO> pagingVO); 
	public List<RatioVO> readRatioList(PagingVO<RatioVO> pagingVO); 
	public RatioVO readRatio(int Ratio_no); 
}
