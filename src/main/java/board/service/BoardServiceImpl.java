package board.service;

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

import board.dao.IAttatchDAO;
import board.dao.IBoardDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.BoardVO;
import vo.PagingVO;
import vo.emp.AttatchVO;

@Service
public class BoardServiceImpl implements IBoardService {
	
	@Inject
	IBoardDAO boardDAO;
	@Inject
	IAttatchDAO attatchDAO;
	
	@Inject
	WebApplicationContext context;
	@Value("#{appInfo.attatchPath}")
	String attatchPath;
	File saveFolder;
	
	@PostConstruct
	public void init() {
		String realPath = context.getServletContext().getRealPath(attatchPath);
		saveFolder = new File(realPath);
		if(!saveFolder.exists()) saveFolder.mkdirs();
	}
	private void deleteBinary(String[] delAttSaveNames) {
		if(delAttSaveNames==null || delAttSaveNames.length==0) return;
		try {
			for(String delName : delAttSaveNames) {
				FileUtils.forceDelete(new File(saveFolder, delName));				
			}
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	public int processAttatches(BoardVO board){
		int[] delNos =  board.getDeleteAttatches();
		int rowcnt = 0;
		String[] delAttSaveNames = null;
		if(delNos!=null && delNos.length>0) {
			 delAttSaveNames = new String[delNos.length];
			for(int i=0; i<delNos.length; i++) {
				delAttSaveNames[i] = attatchDAO.selectAttatch(delNos[i]).getAtt_savename(); 
			}
			rowcnt = attatchDAO.deleteAttatchs(board); // meta data
		}
		
		List<AttatchVO> attatchList = board.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {
			rowcnt += attatchDAO.insertAttatchs(board);
			
			try {
				for(AttatchVO attatch : attatchList) {
						attatch.getRealFile().transferTo(new File(saveFolder, attatch.getAtt_savename()));
				}
			} catch (IllegalStateException | IOException e) {
				throw new RuntimeException(e);
			}// try end
		}
		
		deleteBinary(delAttSaveNames);
		return rowcnt;
	}
	
	@Transactional
	@Override
	public ServiceResult createBoard(BoardVO board) {
		int rowcnt = boardDAO.insertBoard(board);
		rowcnt += processAttatches(board);
		ServiceResult result = null;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public int readBoardCount(PagingVO<BoardVO> pagingVO) {
		return boardDAO.selectBoardCount(pagingVO);
	}

	@Override
	public List<BoardVO> readBoardList(PagingVO<BoardVO> pagingVO) {
		return boardDAO.selectBoardList(pagingVO);
	}

	@Override
	public BoardVO readBoard(int bo_no) {
		BoardVO board = boardDAO.selectBoard(bo_no);
		if(board==null) {
			throw new DataNotFoundException(bo_no+"에 해당하는 글이 없음.");
		}
		boardDAO.incrementHit(bo_no);
		return board;
	}

	@Override
	public ServiceResult modifyBoard(BoardVO board) {
		BoardVO savedBoard = readBoard(board.getBo_no());
		ServiceResult result = null;
		if(savedBoard.getBo_pass().equals(board.getBo_pass())) {
			int rowcnt = boardDAO.updateBoard(board);
			if(rowcnt>0) {
				processAttatches(board);
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO board) {
		BoardVO savedBoard = readBoard(board.getBo_no());
		ServiceResult result = null;
		if(savedBoard.getBo_pass().equals(board.getBo_pass())) {
			List<AttatchVO> attatchList = savedBoard.getAttatchList();
			String[] delAttNames = null;
			if(attatchList!= null && !attatchList.isEmpty()) {
				delAttNames = new String[attatchList.size()];
				for(int i=0; i<delAttNames.length; i++) {
					delAttNames[i] = attatchList.get(i).getAtt_savename();
				}
			}
			
//			processAttatches(board);
			int rowcnt = boardDAO.deleteBoard(board);
			if(rowcnt>0) {
				deleteBinary(delAttNames);
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Override
	public AttatchVO downloadAttatch(int att_no) {
		AttatchVO attatch = attatchDAO.selectAttatch(att_no);
		if(attatch==null) {
			throw new DataNotFoundException(att_no+"파일이 없음.");
		}
		attatchDAO.incrementDownCount(att_no);
		return attatch;
	}

}
