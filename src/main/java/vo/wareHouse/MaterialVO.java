package vo.wareHouse;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.ToString;
import vo.product.MaterialSectorVO;

@Data
@ToString
public class MaterialVO implements Serializable{
//�썝�옄�옱 
	
	private Integer rnum; // row number
	
	private String mat_no; //�썝�옄�옱肄붾뱶

	@NotBlank
	private String mat_name; //�썝�옄�옱紐�

	@NotBlank
	private String lprod_no; //遺꾨쪟肄붾뱶

	@NotBlank
	private String mat_use; //�궗�슜�뿬遺� G001, G002
	
	private Integer mat_standard; //洹쒓꺽
	private String mat_stand_size; //洹쒓꺽�떒�쐞
	
	private Integer mat_in_cost; //�엯怨좊떒媛�
	private String mat_stock_size; //�닔�웾�떒�쐞
	private String buyer_no; //嫄곕옒泥섏퐫�뱶
	
	private Integer mat_stock; //�쁽�옱怨좊웾
	
	@Min(0)
	private Integer mat_safe_stock; //�븞�쟾�옱怨좊웾
	
	private String mat_validity; //�쑀�슚湲곌컙
	
	private String store_name; 
	
	private String store_no;//李쎄퀬VO
	
	private String sector_no; //李쎄퀬援ъ뿭

	private LprodVO lprodVO;	//遺꾨쪟肄붾뱶VO
	
	// 寃��깋�슜 蹂��닔 
	private String startDay;
	private String endDay;
    private String mat_cnt;
	
    //sql 문 용 변수 
    private int porder_no;
    private MaterialSectorVO materSectorVO;
	
}
