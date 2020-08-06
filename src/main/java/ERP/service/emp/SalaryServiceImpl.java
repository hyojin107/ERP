package ERP.service.emp;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import ERP.dao.emp.IEmployeeDAO;
import ERP.dao.emp.ISalary_SpecificationDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.Salary_CalVO;
import vo.emp.Salary_TransVO;

@Service
public class SalaryServiceImpl implements ISalary_SpecificationService {

	@Inject
	ISalary_SpecificationDAO  salaryDAO;
	@Inject
	IEmployeeDAO empDAO;
	@Inject
	WebApplicationContext context;
	
	// 급여 등록
	@Override
	public ServiceResult createSalary(Salary_TransVO vo) {
		int rowcnt = salaryDAO.insertSalary(vo);
		ServiceResult result = null;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	// 급여 삭제 
	@Override
	public ServiceResult removeSalary(Salary_TransVO vo) {
		return null;
	}

	
	// 급여 리스트 
	@Override
	public List<EmployeeVO> readSalaryList(PagingVO<EmployeeVO> pagingVO) {
		return salaryDAO.selectSalaryList(pagingVO);
	}
	
	// 행 하나 클릭하여  급여내용의 사원정보를  읽어오는거 
	@Override
	public EmployeeVO raeadSalaryn(EmployeeVO vo) {
		EmployeeVO emp = salaryDAO.selectSalary(vo);
		if(emp == null) {
			throw new DataNotFoundException(vo+"에 해당하는 사원이 없습니다. ");
		}
		
		return emp;
	}
	
//	// 행 하나를 클릭했을 때 사원의 급여정보내용을 가져오는거 
//	@Override
//	public Salary_TransVO readMoney(EmployeeVO vo) {
//		Salary_TransVO salary =  salaryDAO.selectMoney(vo);
//		if(salary ==null) {
//			throw new DataNotFoundException(vo+"에 해당하는 사원이 없습니다.");
//		}
//		return salary;
//	}
	
	
	  @Override 
	  public int readSaralyCount(PagingVO<EmployeeVO> pagingVO) {
		  return salaryDAO.selectSalaryCount(pagingVO); 
		  }

	  
	  
	  
	// 급여 기본정보 -- 불러오는 거  
	@Override
	public List<Salary_CalVO> readSalaryCal() {
		List<Salary_CalVO> cal = salaryDAO.selectSalaryCal();
		if(cal == null) {
			throw new DataNotFoundException(cal+"에 해당하는 정보가 없습니다.");
		}
		
		return cal;
	}

	// 급여 기본정보 -- 수정하는 거  
	@Override
	public ServiceResult modifySalaryCal(Salary_CalVO vo) {
		return salaryDAO.updateSalaryCal(vo) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
				}

	@Override
	public List<EmployeeVO> readMailList(PagingVO<EmployeeVO> pagingVO) {
		return salaryDAO.selectEmailList(pagingVO);
	}

	@Override
	public EmployeeVO readEmp(EmployeeVO vo) {
		EmployeeVO empInfo =  salaryDAO.selectEmpInfo(vo);
		if(empInfo ==null) {
			throw new DataNotFoundException(vo+"에 해당하는 사원이 없습니다.");
		}
		return empInfo;
	}

	@Override
	public Salary_TransVO readEmail(EmployeeVO vo) {
		Salary_TransVO email = salaryDAO.selectEmail(vo);
		if(email == null) {
			throw new DataNotFoundException(vo+"에 해당하는 사원이 없습니다.");
		}
		return email;
	}

	 
	


}
