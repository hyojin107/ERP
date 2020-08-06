package ERP.service.emp;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.emp.IRetirementDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.RetirementVO;

@Service
public class RetirementImpl implements IRetirementService {

	@Inject
	private IRetirementDAO reDAO;
	
	
	// 퇴직 등록 
	@Override
	public ServiceResult createRetirement(RetirementVO vo) {
		
		return reDAO.insertRetirement(vo)>0? ServiceResult.OK : ServiceResult.FAIL;
		}
	
	//  퇴직 삭제 -- 정보를 삭제하는 겨우는 없으니깐 안쓰는거 
//	@Override
//	public ServiceResult removeRetirement(RetirementVO vo) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	// 수정  -- 모달창?
	@Override
	public ServiceResult modifyRetirement(RetirementVO vo) {
		ServiceResult result = null;
//		RetirementVO retireEMP = readRetirement(vo.getEmp_no());
		int cnt = reDAO.updateRetirement(vo);
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<EmployeeVO> readRetirementList(PagingVO<EmployeeVO> pagingVO) {
		return reDAO.selectRetirementList(pagingVO);
	}

	@Override
	public EmployeeVO readRetirement(EmployeeVO emp) {
		EmployeeVO retire = reDAO.selectRetirement(emp);
		if(retire == null) throw new DataNotFoundException(emp+"사원의 정보는 존재 하지 않습니다.");
		return retire;
	}

	@Override
	public int readEmpListCount(PagingVO<EmployeeVO> pagingVO) {
		return reDAO.selectEmpCount(pagingVO);
	}

}
