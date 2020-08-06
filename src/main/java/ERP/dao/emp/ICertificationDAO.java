package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.CertificationVO;
import vo.emp.EmployeeVO;

@Repository
public interface ICertificationDAO {  //자격증
	
	public int insertCertification(CertificationVO vo);
    public List<CertificationVO > selectCertificationList(PagingVO<CertificationVO> pagingVO);
    public int delteCertification(CertificationVO vo);
    public int updateCertification(CertificationVO vo);
    public CertificationVO selectCertification(String emp_id);
     
}
