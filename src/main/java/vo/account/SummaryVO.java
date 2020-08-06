package vo.account;

import java.io.Serializable;

import lombok.Data;

@Data
public class SummaryVO implements Serializable{
	private Integer summary_no; //적요코드
	private String summary; //적요
	private String use; //사용여부
}
