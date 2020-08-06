package vo;

public class MailVO {

	private String sender;		// 보내는 사람
	private String receiver;	// 받는 사람
	private String title;  		// 제목
	private String content; 	// 내용
	private String file; 	 	//첨부파일
	
	
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "MailVO [sender=" + sender + ", receiver=" + receiver + ", title=" + title + ", content=" + content
				+ ", file=" + file + "]";
	}
	
	
}
