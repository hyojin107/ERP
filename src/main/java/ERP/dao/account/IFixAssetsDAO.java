package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.account.AccountVO;
import vo.account.FixAssetsVO;
import vo.account.FixMinusVO;

@Repository
public interface IFixAssetsDAO {
	public int selectFixAssetsCount(PagingVO<FixAssetsVO> pagingVO); 
	public FixAssetsVO selectFixAsset(int fixAssets_no);
	public int insertFixAsset(FixAssetsVO vo);
	public List<FixAssetsVO> selectFixAssetsList(PagingVO<FixAssetsVO> pagingVO);
	public int updateFixAssets(FixAssetsVO vo);
	public List<AccountVO> selectAccountList();
	public FixMinusVO selectfixdate();
}
