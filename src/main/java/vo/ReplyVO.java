package vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "rep_no")
public class ReplyVO implements Serializable{
	private Integer rep_no;
	private Integer bo_no;
	private String rep_content;
	private String rep_writer;
	private String rep_date;
	private String rep_ip;
	private String rep_pass;
}
