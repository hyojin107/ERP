package ERP.service.buy;

import java.util.List;

import vo.BuyerVO;
import vo.emp.EmployeeVO;
import vo.wareHouse.MaterialVO;

public interface IModalViewService {
	/**
	 * @return 사원 목록 조회
	 */
	public List<EmployeeVO> readEmpModal();
	
	/**
	 * @return 원자재 목록 조회
	 */
	public List<MaterialVO> readMatModal();
	
	/**
	 * @return 거래처 목록 조회
	 */
	public List<BuyerVO> readBuyerModal();
}
