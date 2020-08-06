package ERP.service.product;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.product.PdReportVO;
import vo.product.PductListVO;
import vo.product.PductorderVO;

/**
 * @author PC-12
 * �깮�궛�쓽猶곗꽌 由ъ뒪�듃�뱾�쓣 �씫�뒗�떎.
 * 
 *
 */
public interface IprodOrderService {

	/**
	 * @return
	 * �깮�궛 �쓽猶곗꽌 由ъ뒪�듃 �씫�뼱�샂
	 */
	public List<PductorderVO> ReadProdorderList(PagingVO<PductorderVO> pductorde
			);
	/**
	 * @param order_code
	 * @return
	 * �깮�궛 �쓽猶곗꽌 �씫�뼱�샂 �깮�궛�쓽猶곗꽌�뿉 List ProDuctListVO瑜� �떞�븘�꽌 �삩�떎. 
	 * 
	 */
	public PductListVO ReadProdorder(String order_code);
	
	/**
	 * @param orderVO
	 * @return
	 * �깮�궛 �쓽猶곗꽌 �깮�꽦
	 */
	public ServiceResult CreateProdorder(PdReportVO orderVO);
	
	public ServiceResult ConfirmProdorder(int porder_no);
	
	public int ReadProdorderCount(PagingVO<PductorderVO> pductorde);
	
	public List<PductorderVO> ReadConfirmorderList();
}
