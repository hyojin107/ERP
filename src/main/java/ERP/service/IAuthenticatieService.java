package ERP.service;

import enums.ServiceResult;
import vo.emp.EmployeeVO;

public interface IAuthenticatieService {
	/**
	 * 인증로직
	 * @param emp
	 * @return 존재여부확인, 비번을 통한 인증
	 */
	public ServiceResult authenticated(EmployeeVO emp);

}
