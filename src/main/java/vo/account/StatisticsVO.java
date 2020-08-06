package vo.account;

import lombok.Data;

@Data
public class StatisticsVO {
	private Integer sell; 
	private Integer cost;
	private String division;
	private String standard_name;
	private String account_name;
	private Integer price;
	private Integer standard;
	private Integer compare;
}
