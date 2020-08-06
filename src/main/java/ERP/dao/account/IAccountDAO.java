package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.account.AccountVO;
import vo.account.StandardVO;

@Repository
public interface IAccountDAO {
	public int selectAccountCount(PagingVO<AccountVO> pagingVO);
	public AccountVO selectAccount(int acc_no);
	public int insertAccount(AccountVO vo);
	public List<AccountVO> selectAccountList(PagingVO<AccountVO> pagingVO);
	public int updateAccount(AccountVO vo);
	public List<StandardVO> selectStandardList();
	public int deleteAccount(int acc_no);
}
