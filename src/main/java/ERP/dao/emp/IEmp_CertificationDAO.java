package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.EMP_CertVO;

@Repository
public interface IEmp_CertificationDAO { // 사원자격증명서 
	
	public int  insertEmpCertification(EMP_CertVO vo);
	public int  updateEmpCertification(EMP_CertVO vo);
	public List<EMP_CertVO> selectEmpCertification(PagingVO<EMP_CertVO> pagingVO);
	public int deleteEmpCertification(EMP_CertVO vo);
	public EMP_CertVO  selectEmpCertification(String emp_id);
	
	

}
