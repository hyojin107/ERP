package ERP.service.buy;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.buy.IModalViewDAO;
import vo.BuyerVO;
import vo.emp.EmployeeVO;
import vo.wareHouse.MaterialVO;

@Service
public class ModalViewServiceImpl implements IModalViewService{
	
	@Inject
	IModalViewDAO dao;
	
	@Override
	public List<EmployeeVO> readEmpModal() {
		return dao.selectEmpModal();
	}

	@Override
	public List<MaterialVO> readMatModal() {
		return dao.selectMatModal();
	}

	@Override
	public List<BuyerVO> readBuyerModal() {
		return dao.selectBuyerModal();
	}
}
