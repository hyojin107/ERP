package ERP.service.account;

import java.util.List;

import enums.ServiceResult;
import vo.account.FixAssetsVO;
import vo.account.FixMinusVO;

public interface IFixMinusService {
	public ServiceResult  createFixMinus(FixMinusVO vo); 
	public List<FixAssetsVO> readFixMinusList(FixMinusVO vo); 
	public FixMinusVO readFixMinus(FixMinusVO vo); 
}
