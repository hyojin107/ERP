package ERP.dao.account;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.account.D3VO;
import vo.account.StatisticsVO;

@Repository
public interface IStatisticsDAO {
	public List<StatisticsVO> selectplusMinus(StatisticsVO vo);
	public List<StatisticsVO> selectbuySell(StatisticsVO vo);
	public Integer year();
	public List<StatisticsVO> selectProductCost(StatisticsVO vo);
	public List<StatisticsVO> selectSellCost(StatisticsVO vo);
	public List<StatisticsVO> selectMonth(StatisticsVO vo);
	public List<D3VO> selectProduct(StatisticsVO vo);
}
