package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.ChitVO;

public interface IChitService {
	public ServiceResult  createChit(ChitVO vo); 
	public int readChitCount(PagingVO<ChitVO> pagingVO); 
	public List<ChitVO> readChitList(ChitVO vo); 
	public ChitVO readChit(String chit_no); 
	public ServiceResult modifyChit(ChitVO vo); 
	public ServiceResult removeChit(ChitVO vo); 
}
