package vo.account;

import java.io.Serializable;

import lombok.Data;

@Data
public class RatioVO implements Serializable{
	private Integer life_year; //내용연수
	private String fix; //정액법
	private String ratio; //정률법
}
