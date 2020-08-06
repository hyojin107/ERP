package ERP.service;

import javax.inject.Inject;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import ERP.dao.emp.IEmployeeDAO;
import enums.ServiceResult;
import vo.emp.EmployeeVO;

@Service
public class AutheticateServiceImpl implements IAuthenticatieService {

	@Inject
	IEmployeeDAO dao;
	
	@Override
	public ServiceResult authenticated(EmployeeVO emp) {
		
		EmployeeVO savedEmployee = dao.selectEmployee(emp.getEmp_no());
		System.out.println(emp.getEmp_no()+emp.getEmp_pass());
		ServiceResult result = null;
		
		if(savedEmployee != null) {
			if(emp.getEmp_pass().equals(savedEmployee.getEmp_pass())) {
				BeanUtils.copyProperties(savedEmployee, emp);
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.INVALIDPASSWORD;
			}
			
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

}
