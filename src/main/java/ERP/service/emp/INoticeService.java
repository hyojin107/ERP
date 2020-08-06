package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.AttatchVO;
import vo.emp.NoticeVO;

public interface INoticeService { // 공지사항 등록 수정 삭제
 
	public ServiceResult createNotice(NoticeVO noticeVO);
	public int readNoticeCount(PagingVO<NoticeVO> pagingVO);
	public ServiceResult removeNotice(NoticeVO noticeVO);
	public ServiceResult modifyNotice(NoticeVO noticeVO);
	public List<NoticeVO> readNoticeList(PagingVO<NoticeVO> pagingVO);
	public NoticeVO readNotice (int notice_no);
	public AttatchVO downloadAttatch(int att_no);
}
