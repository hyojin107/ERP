package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.account.FixAssetsVO;

public interface IFixAssetsService {
	public ServiceResult  createFixAssets(FixAssetsVO vo); 
	public int readFixAssetsCount(PagingVO<FixAssetsVO> pagingVO); 
	public List<FixAssetsVO> readFixAssetsList(PagingVO<FixAssetsVO> pagingVO); 
	public FixAssetsVO readFixAssets(int fixassets_no); 
	public ServiceResult modifyFixAssets(FixAssetsVO vo); 
	public ServiceResult removeFixAssets(FixAssetsVO vo); 
}
