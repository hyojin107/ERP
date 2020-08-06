package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.AccountVO;
import vo.account.StandardVO;

public interface IAccountService {
	public ServiceResult  createAccount(AccountVO vo); 
	public int readAccountCount(PagingVO<AccountVO> pagingVO); 
	public List<AccountVO> readAccountList(PagingVO<AccountVO> pagingVO); 
	public AccountVO readAccount(int account_no); 
	public int modifyAccount(AccountVO vo); 
	public ServiceResult removeAccount(AccountVO vo);
	public List<StandardVO> readStandardList();
}
