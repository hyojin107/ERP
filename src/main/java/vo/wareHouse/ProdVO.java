package vo.wareHouse;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import validate.stereotype.MimeChecker;

@Data
public class ProdVO {
// 상품
	
	// 검색용 변수
	private String startDay;
	private String endDay;
	private String startPrice;
	private String endPrice;
	
	//----------------------------------------
	
	private List<BOMVO> bomlist; // xml 에서 resultMapping용 
	private String mat_name;
	
	private Integer rnum;
	
	//----------------------------------------
	
	private String prod_no; //상품코드 char 5
	
	@NotBlank
	private String prod_name; //상품명 varchar2 100
	private String prod_standard; //규격 varchar2 10
	private String prod_stand_size; //규격단위 varchar2 10
	private String prod_validity; //유통기한 date

	@NotBlank
	private String prod_use; //생산여부 YES, NO

	@NotBlank
	private String lprod_no; //분류코드 char 5

	private Integer prod_stock; //현 재고량 number
	private String prod_stock_size; //수량단위 varchar2 10

	@Min(0)
	private Integer prod_out_price; //출고단가 number
	
	@Min(0)
	private Integer prod_safe_stock; //안전재고량 number
	
	private String store_name; //창고VO
	
	private String store_no; // 창고no
	
	

//------------------------------------------------------------
	@MimeChecker(contentType = "image/*") // 파일 형태가 image형태인 것 만 저장시킨다. 
	private MultipartFile prod_image; // 이미지 자체를 저장 
	
	public void setProd_image(MultipartFile prod_image) {
		if(prod_image == null) {
			return;
		}
		String filename = prod_image.getOriginalFilename();
		if(filename==null||filename.isEmpty()) {
			return; // 파일이름이 null이거나 비어있을 경우 업로드가 안되도록 한다. 
		}
		this.prod_image = prod_image;
	}
	
	// saveFolder는 serviceimple에서 생성해준다. 
	public void saveFile(File saveFolder) throws IllegalStateException, IOException {
		if(prod_image == null) {return;}
		File savefile = new File(saveFolder, prod_no); 
		// 파일이 선택되었을때 파일을 저장시킨다.
		// prod_no를 이미지 이름으로 저장 . 
		prod_image.transferTo(savefile);
		// transferTo()라는 메소드를 사용해서 원하는 위치에 파일을 저장시킨다. 
	}
	
	//-------------------- 상품 출고 insert
	private String prod_sector; // 상품 창고 코드 
	private Integer prod_out_qty; // 상품 출고 수량 
	
	private String sector_no; //창고구역
	
}
