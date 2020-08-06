package ERP.dao.emp;

import org.springframework.stereotype.Repository;

import vo.BoardVO;
import vo.emp.AttatchVO;
import vo.emp.NoticeVO;

@Repository
public interface IAttatachDAO {

	public int insertAttatchs(NoticeVO notice);
	public AttatchVO selectAttatch(int att_no); //첨부파일 번호
	public int incrementDownCount(int att_no);
	public int deleteAttatchs(NoticeVO notice); // attatch의 정보를 가지고있는 vo의 컬럼을 삭제
	
}
