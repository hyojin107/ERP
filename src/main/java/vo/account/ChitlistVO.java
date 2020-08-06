package vo.account;

import java.io.Serializable;

import lombok.Data;

@Data
public class ChitlistVO implements Serializable{
	private Integer deal_no;
	private String chit_no;
	private String product;
	private Integer price;
	private String summary;
	private Integer qty;
}
