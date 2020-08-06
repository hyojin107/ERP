package ERP.service.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.account.IAccountDAO;
import enums.ServiceResult;
import vo.PagingVO;
import vo.account.AccountVO;
import vo.account.StandardVO;

@Service
public class AccountServiceImpl implements IAccountService{
	@Inject
	IAccountDAO dao;
	
	@Override
	public ServiceResult createAccount(AccountVO vo) {
		return dao.insertAccount(vo)>0?ServiceResult.OK:ServiceResult.FAIL;
	}

	@Override
	public int readAccountCount(PagingVO<AccountVO> pagingVO) {
		return dao.selectAccountCount(pagingVO);
	}

	@Override
	public List<AccountVO> readAccountList(PagingVO<AccountVO> pagingVO) {
		return dao.selectAccountList(pagingVO);
	}

	@Override
	public AccountVO readAccount(int account_no) {
		return dao.selectAccount(account_no);
	}

	@Override
	public int modifyAccount(AccountVO vo) {
		return dao.updateAccount(vo);
	}

	@Override
	public ServiceResult removeAccount(AccountVO vo) {
		return dao.deleteAccount(vo.getAccount_no())>0?ServiceResult.OK:ServiceResult.FAIL;
	}

	@Override
	public List<StandardVO> readStandardList() {
		return dao.selectStandardList();
	}

}
