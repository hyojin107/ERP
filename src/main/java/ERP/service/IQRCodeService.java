package ERP.service;

import enums.ServiceResult;
import vo.emp.EmployeeVO;

public interface IQRCodeService {
	
	/**
	 * @param empVO
	 * @return 근태등록
	 */
	public ServiceResult createWork(EmployeeVO empVO);
	
}
