package ERP.service.wareHouse;

import java.util.List;

import org.springframework.stereotype.Service;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.BuyerReturnVO;
import vo.product.DisStuffVO;
import vo.product.PdReportVO;
import vo.product.StuffVO;
import vo.wareHouse.Mat_DisUseVO;
import vo.wareHouse.Prod_DisUseVO;

public interface IDisuseService {

	


	
	/**
	 * �긽�뭹 �룓湲곕벑濡�
	 * @param proddisVO
	 * @return
	 */
	public ServiceResult insertStuffDisUse(DisStuffVO disstuffvo);
	
//	2. �룓湲곕벑濡앹꽌 紐⑸줉 蹂댁뿬二쇨린(�썝�옄�옱, �긽�뭹)
	/**
	 * 議곌굔�뿉 留욌뒗 �썝�옄�옱 �룓湲� �닔
	 * @param pagingVO
	 * @return
	 */
	public int readMatDisUseCnt(PagingVO<Mat_DisUseVO> pagingVO);
	
	/**
	 * 議곌굔�뿉 留욌뒗 �긽�뭹 �룓湲� �닔
	 * @param pagingVO
	 * @return
	 */
	public int readProdDisUseCnt(PagingVO<Prod_DisUseVO> pagingVO);
	
	/**
	 * 寃��깋 議곌굔�뿉 留욌뒗 �썝�옄�옱 紐⑸줉 
	 * @param pagingVO
	 * @return
	 */
	public List<StuffVO> readMatDisUseList(StuffVO detailSearch);
	/**
	 * 寃��깋 議곌굔�뿉 留욌뒗 �긽�뭹 紐⑸줉
	 * @param pagingVO
	 * @return
	 */
	public List<StuffVO> readProdDisUseList(StuffVO detailSearch);
	
//	3. �룓湲곕벑濡앹꽌 �긽�꽭蹂닿린 (�썝�옄�옱 , �룓湲�)
	/**
	 * �썝�옄�옱 �룓湲� �벑濡앹꽌 �긽�꽭 蹂닿린 
	 * @param board_no
	 * @return
	 */
	public Mat_DisUseVO readMatDisUse(int board_no);
	/**
	 * �긽�뭹 �룓湲� �벑濡앹꽌 �긽�꽭 蹂닿린
	 * @param board_no
	 * @return
	 */
	public Prod_DisUseVO readProdDisUse(int board_no);
	
	
	
//	4. 諛섑뭹�쓽猶곗꽌 遺덈윭�삤湲� -- �젣寃�
	/**
	 * 議곌굔�뿉 留욌뒗 諛섑뭹�쓽猶곗꽌 媛��닔諛섑솚
	 * @param pagingVO
	 * @return
	 */
	public int readBuyerReturnCnt(PagingVO<BuyerReturnVO> pagingVO);
	
	/**
	 * 諛섑뭹�쓽猶곗꽌 紐⑸줉 �쟾泥� 議고쉶
	 * @param pagingVO
	 * @return
	 */
	public List<BuyerReturnVO> readBuyerReturnList(PagingVO<BuyerReturnVO> pagingVO);

//	6. 諛섑뭹�쓽猶곗꽌 �긽�꽭蹂닿린 -- �젣寃�
	/**
	 * 諛섑뭹�쓽猶곗꽌 �긽�꽭蹂닿린 
	 * @param board_no
	 * @return
	 */
	public BuyerReturnVO readBuyerReturn(int board_no);

//	8. 諛섑뭹�쓽猶곗꽌濡� �긽�뭹 �룓湲� 泥섎━
	/**
	 * 諛섑뭹�쓽猶곗꽌瑜� �넗��濡� �긽�뭹�룓湲고븯湲� 
	 * @param buyReturnVO
	 * @return
	 */
	public ServiceResult prodReDisUse(BuyerReturnVO buyReturnVO);
	
	
	
	
//	5. �깮�궛蹂닿퀬�꽌 遺덈윭�삤湲� -- �젙誘�
	/**
	 * 議곌굔�뿉 留욌뒗 �깮�궛蹂닿퀬�꽌 �닔 (?)
	 * @param pagingVO
	 * @return
	 */
	public int pdReportCnt(PagingVO<PdReportVO> pagingVO);
	
	/**
	 * 議곌굔�뿉 留욌뒗 �깮�궛 蹂닿퀬�꽌 紐⑸줉
	 * @param pagingVO
	 * @return
	 */
	public List<PdReportVO> readPdReportList(PagingVO<PdReportVO> pagingVO);
	
//	7. �깮�궛蹂닿퀬�꽌 �긽�꽭蹂닿린 -- �젙誘�
	/**
	 * �깮�궛蹂닿퀬�꽌 �긽�꽭蹂닿린 
	 * @param board_no
	 * @return
	 */
	public PdReportVO readPdReport(int board_no);
	
//	9. �깮�궛蹂닿퀬�꽌濡� �긽�뭹 �룓湲� 泥섎━
	/**
	 * �깮�궛蹂닿퀬�꽌瑜� �넗��濡� �긽�뭹 �룓湲곗쿂由� ,�깮�궛蹂닿퀬�꽌 vo瑜� �뙆�씪誘명꽣 媛믪쑝濡� 諛쏅뒗�떎
	 * @param pdReportVO
	 * @return
	 */
	public ServiceResult prodMFDisUse(PdReportVO pdReportVO);
	
}
