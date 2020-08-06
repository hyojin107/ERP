package ERP.dao;

import org.springframework.stereotype.Repository;

import vo.emp.EmployeeVO;
import vo.emp.WorkVO;

@Repository
public interface IQRCodeDAO {
	
	/**
	 * @param empVO
	 * @return 출근등록
	 */
	public int insertWork(EmployeeVO empVO);
	
	/**
	 * @param empVO
	 * @return 퇴근등록
	 */
	public int updateWork(EmployeeVO empVO);
	
	/**
	 * @return 출근했는지 알아보기 위함
	 * 결과값이 없으면 -> 출근등록
	 * 결과값이 존재하면 -> 퇴근등록
	 */
	public int selectWork(EmployeeVO empVO);
	
}
