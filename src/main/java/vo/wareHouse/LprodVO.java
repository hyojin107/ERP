package vo.wareHouse;

import java.io.Serializable;

import lombok.Data;

@Data
public class LprodVO implements Serializable{
	
	private String lprod_no; //분류코드
	private String lprod_name; //분류명
}
