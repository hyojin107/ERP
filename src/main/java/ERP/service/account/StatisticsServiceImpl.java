package ERP.service.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.account.IStatisticsDAO;
import vo.account.D3VO;
import vo.account.StatisticsVO;

@Service
public class StatisticsServiceImpl implements IStatisticsService{

	@Inject
	IStatisticsDAO dao;
	
	@Override
	public List<StatisticsVO> readPlusMinus(StatisticsVO vo) {
		return dao.selectplusMinus(vo);
	}

	@Override
	public List<StatisticsVO> readbuySell(StatisticsVO vo) {
		return dao.selectbuySell(vo);
	}

	@Override
	public List<StatisticsVO> readProductCost(StatisticsVO vo) {
		return dao.selectProductCost(vo);
	}

	@Override
	public List<StatisticsVO> readSellCost(StatisticsVO vo) {
		return dao.selectSellCost(vo);
	}

	@Override
	public List<StatisticsVO> readMonth(StatisticsVO vo) {
		return dao.selectMonth(vo);
	}

	@Override
	public String readProduct(StatisticsVO vo) {
		List<D3VO> list = dao.selectProduct(vo);
		StringBuffer result = new StringBuffer("date,name,category,value\n");
		
		for(D3VO v : list) {
			result.append(v.getDate()+",");
			result.append(v.getName()+",");
			result.append(v.getCategory()+",");
			result.append(v.getValue()+"\n");
		}
		return result.toString();
	}

	@Override
	public Integer year() {
		return dao.year();
	}
	
}