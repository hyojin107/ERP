package ERP.service.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.account.IFixMinusDAO;
import enums.ServiceResult;
import vo.account.FixAssetsVO;
import vo.account.FixMinusVO;

@Service
public class FixMinusServiceImpl implements IFixMinusService{
	@Inject
	IFixMinusDAO dao;
	@Override
	public ServiceResult createFixMinus(FixMinusVO vo) {
		return dao.insertFixMinus(vo)>0?ServiceResult.OK:ServiceResult.FAIL;
	}

	@Override
	public FixMinusVO readFixMinus(FixMinusVO vo) {
		return dao.selectFixMinus(vo);
	}

	@Override
	public List<FixAssetsVO> readFixMinusList(FixMinusVO vo) {
		List<FixAssetsVO> list = dao.selectFixMinusList(vo);
		for(FixAssetsVO fvo : list) {
			int total = 0;
			if(fvo.getFixMinusList()!=null)
				for(FixMinusVO minus : fvo.getFixMinusList()) {
					total += minus.getAmor_cost();
				}
			fvo.setTotal(total);
		}
		return list;
	}

}
