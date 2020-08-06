package ERP.dao.buy;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.BuyerVO;
import vo.emp.EmployeeVO;
import vo.wareHouse.MaterialVO;

@Repository
public interface IModalViewDAO {
	/**
	 * @return 사원 목록 조회
	 */
	public List<EmployeeVO> selectEmpModal();
	
	/**
	 * @return 원자재 목록 조회
	 */
	public List<MaterialVO> selectMatModal();
	
	/**
	 * @return 거래처 목록 조회
	 */
	public List<BuyerVO> selectBuyerModal();
}
