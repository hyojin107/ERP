package ERP.dao.emp;

import java.util.List;

import javax.naming.NoInitialContextException;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.NoticeVO;

@Repository
public interface INoticeDAO { // 공지사항
	
	
	public int insertNotice(NoticeVO noticeVo);
	public int selectNoticeCount(PagingVO<NoticeVO> pagingVO);
	public int deleteNotice(NoticeVO noticeVo);
	public int updateNotice(NoticeVO noticeVo);
	public List<NoticeVO> selectNoticeList(PagingVO<NoticeVO> paigingVO);
	public NoticeVO selectNotiece (int  notice_no);
	public void incrementHit(int notice_no);

}
