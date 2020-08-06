package ERP.service.emp;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import ERP.dao.emp.IAttatachDAO;
import ERP.dao.emp.INoticeDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.AttatchVO;
import vo.emp.NoticeVO;

@Service
public class NoticeServiceImpl implements INoticeService {

	@Inject
	INoticeDAO noticeDao;
	@Inject
	IAttatachDAO attatachDAO;
	
	@Inject
	WebApplicationContext context;
	@Value("#{appInfo.attatchPath}")
	String attatchPath;
	File saveFolder;
	
	@PostConstruct
	public void init() { // 파일존재 확인??
		String realPath = context.getServletContext().getRealPath(attatchPath);
		saveFolder = new File(realPath);
		if(!saveFolder.exists()) saveFolder.mkdirs();
	}
	
	private void deleteBinary(String[] delAttSaveNames) {// 파일삭제
		if(delAttSaveNames == null || delAttSaveNames.length==0) return;
		try {
			for(String delName  : delAttSaveNames) {
				FileUtils.forceDelete(new File(saveFolder, delName)); // 서버에 있는 실제 파일을 지우는거 
			}
			
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
		
	public int processAttatches(NoticeVO notice) { // 파일 저장 
		int[] delNos = notice.getDeleteAttatches();
		int rowcnt = 0;
		String[] delAttaSaveNames = null;
		if(delNos != null && delNos.length>0) {
			delAttaSaveNames = new String[delNos.length];
			for(int i =0; i<delNos.length; i++) {
				delAttaSaveNames[i] = attatachDAO.selectAttatch(delNos[i]).getAtt_savename();
			}
			rowcnt = attatachDAO.deleteAttatchs(notice);
		}

		List<AttatchVO> attatchList = notice.getAttatchList();
		if(attatchList != null && !attatchList.isEmpty()) {
			rowcnt += attatachDAO.insertAttatchs(notice);
			
			try {
				for(AttatchVO att : attatchList) {
					att.getRealFile().transferTo(new File(saveFolder, att.getAtt_savename()));
					
				}
			}catch (IllegalStateException | IOException e) {
				throw new RuntimeException(e);
			}
		}
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult createNotice(NoticeVO noticeVO) {
		int rowcnt = noticeDao.insertNotice(noticeVO);
		rowcnt += processAttatches(noticeVO);
		ServiceResult result = null;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
	
		return result;
	}

	@Override
	public int readNoticeCount(PagingVO<NoticeVO> pagingVO) {
		return noticeDao.selectNoticeCount(pagingVO);
	}

	@Override
	public ServiceResult removeNotice(NoticeVO noticeVO) {
		NoticeVO saveNotice =  readNotice(noticeVO.getNotice_no());
		ServiceResult result = null;
		
			List<AttatchVO> attatchList = saveNotice.getAttatchList();
			String[] delAttNames = null;
			if(attatchList != null && !attatchList.isEmpty()) {
				delAttNames = new String[attatchList.size()];
				for(int i=0; i<delAttNames.length; i++) {
					delAttNames[i] = attatchList.get(i).getAtt_savename();
				}
			}
			int rowcnt = noticeDao.deleteNotice(noticeVO);
			
			if(rowcnt > 0) {
				deleteBinary(delAttNames);
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
	
		return result;
	}

	@Override
	public ServiceResult modifyNotice(NoticeVO noticeVO) {
		readNotice(noticeVO.getNotice_no()); 
		int cnt  = noticeDao.updateNotice(noticeVO);
		/* deleteBinary(noticeVO); */
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) result = ServiceResult.OK;
		
		return result;
	}

	@Override
	public List<NoticeVO> readNoticeList(PagingVO<NoticeVO> pagingVO) {
		return noticeDao.selectNoticeList(pagingVO);
	}

	// 게시글 읽어오는거 
	@Override
	public NoticeVO readNotice(int notice_no) {
		NoticeVO notice = noticeDao.selectNotiece(notice_no);
		if(notice == null) {
			throw new DataNotFoundException(notice_no+"에 해당하는 글이 없습니다.");
		}
		 noticeDao.incrementHit(notice_no);
		return notice;
	}

	// 파일 다운 받는거 
	@Override
	public AttatchVO downloadAttatch(int att_no) {
		AttatchVO attatch = attatachDAO.selectAttatch(att_no);
		if(attatch == null) {
			throw new DataNotFoundException(att_no+"파일이 없습니다.");
		}
		attatachDAO.incrementDownCount(att_no);
		return attatch;
	}

}
