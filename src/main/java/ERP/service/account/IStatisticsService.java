package ERP.service.account;

import java.util.List;

import vo.account.D3VO;
import vo.account.StatisticsVO;

public interface IStatisticsService {
	public List<StatisticsVO> readPlusMinus(StatisticsVO vo);
	public List<StatisticsVO> readbuySell(StatisticsVO vo);
	public List<StatisticsVO> readProductCost(StatisticsVO vo);
	public List<StatisticsVO> readSellCost(StatisticsVO vo);
	public List<StatisticsVO> readMonth(StatisticsVO vo);
	public String readProduct(StatisticsVO vo);
	public Integer year();
}
