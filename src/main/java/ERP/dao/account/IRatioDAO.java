package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.account.RatioVO;

@Repository
public interface IRatioDAO {
	public RatioVO selectRatio(int life_year);
	public List<RatioVO> selectRatioList();
}
