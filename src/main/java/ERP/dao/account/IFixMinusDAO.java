package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.account.FixAssetsVO;
import vo.account.FixMinusVO;

@Repository
public interface IFixMinusDAO {
	public FixMinusVO selectFixMinus(FixMinusVO vo);
	public int insertFixMinus(FixMinusVO vo);
	public List<FixAssetsVO> selectFixMinusList(FixMinusVO vo);
	public int updateFixMinus(FixMinusVO vo);
	public String startDate(String account_no);
}
