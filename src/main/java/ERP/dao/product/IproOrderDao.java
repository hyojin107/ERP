package ERP.dao.product;

import java.util.List;

import org.springframework.stereotype.Repository;

import enums.ServiceResult;
import vo.PagingVO;
import vo.product.PdReportVO;
import vo.product.PductListVO;
import vo.product.PductorderVO;

/**
 * @author PC-12
 * �깮�궛���씠 蹂대뒗 �깮�궛�쓽猶곗꽌由ъ뒪�듃�� �깮�궛���씠 �빐�떦 �깮�궛�쓽猶곗꽌 �닔�씫�쓣 �늻由�
 */
@Repository
public interface IproOrderDao {

	
	/**
	 * @return
	 * �깮�궛���뿉�꽌 蹂� �닔 �엳�뒗 �깮�궛�쓽猶곗꽌 由ъ뒪�듃瑜� 由ы꽩�빐以�
	 */
	public List<PductorderVO> SelectListprodOrder(PagingVO<PductorderVO> vo);
	
	
	/**
	 * @return
	 * �꽑�깮�븳 �깮�궛�쓽猶곗꽌瑜� �븯�굹 怨⑤씪�꽌 蹂댁뿬以�.
	 */
	public PductListVO SelectprodOrder(String porder_no);
	
	
	/**
	 * @param orderVO
	 * @return
	 * �깮�궛�쓽猶곗꽌 �젣�옉
	 */
	public int InsertprodOrder(PdReportVO orderVO);
	
	public int UpdateConfirmOrder(int porder_no);
	
	public int CountSelectprodOrder(PagingVO<PductorderVO> vo);
	
	public List<PductorderVO> SelectConfirmOrder();
	
	
	
}
