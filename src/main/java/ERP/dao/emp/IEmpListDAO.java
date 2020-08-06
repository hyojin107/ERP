package ERP.dao.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import vo.emp.AnnouncementVO;
import vo.emp.DepartmentVO;
import vo.emp.PositionVO;
import vo.emp.RetirementVO;

@Repository
public interface IEmpListDAO {


	public List<Map<String, Object>> selectPosList(); // 최종직급
	public List<Map<String, Object>> selectSolidList(); // 병역 리스트
	public List<Map<String, Object>> selectFulltime(); // 정규직,비정규직
	
	public List<Map<String, Object>> selectDepartmentList(); //  부서 리스트  
	public List<DepartmentVO> selectTeamList(@Param ("dep_no2")String dep_no2);  // 부서코드를 받아서 소속 팀을 가져온다. 

	public List<RetirementVO> selectRetireList(); // 퇴직정산 여부
	
	public List<AnnouncementVO> selectAnnList();// 발령상태
	
}
