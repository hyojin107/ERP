package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.Salary_CalVO;
import vo.emp.Salary_TransVO;

@Repository
public interface ISalary_SpecificationDAO { // 급여명세서
	
	public int insertSalary(Salary_TransVO vo);
	public int selectSalaryCount(PagingVO<EmployeeVO> pagingVO);
	public int deleteSalary(Salary_TransVO vo);
	public int updateSalary(Salary_TransVO vo);
	public List<EmployeeVO> selectSalaryList(PagingVO<EmployeeVO> pagingVO);
	public EmployeeVO selectSalary(EmployeeVO vo); // 급여내역에서 사원의 정보를 가져오는거 
	public Salary_TransVO selectMoney(EmployeeVO vo); // 급여내역에서 사원의 급여정보를 가져오는거
	// 급여 기본정보 셋팅하는거 
	public List<Salary_CalVO> selectSalaryCal(); // 기본 급여 가져오는거 
	public int updateSalaryCal(Salary_CalVO vo); // 기본 급여 수정 하는거 
	
	//급여 메일 전송 
	public List<EmployeeVO> selectEmailList(PagingVO<EmployeeVO> paging);
	public EmployeeVO selectEmpInfo(EmployeeVO vo);
	public Salary_TransVO selectEmail(EmployeeVO vo);
	
}
