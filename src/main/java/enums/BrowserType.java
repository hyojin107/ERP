package enums;

public enum BrowserType {
	TRIDENT("익플"),
	CHROME("크롬"),
	FIREFOX("파이어폭스"),
	OTHER("기타등등");
	
	private String desc;
	
	private BrowserType(String desc) {
		this.desc = desc;
	}

	public String getDesc() {
		return desc;
	}
	public static String browserIdentify(String userAgent) {
		userAgent = userAgent.toUpperCase();
		BrowserType result = OTHER;
		for(BrowserType tmp : values()) {
			if(userAgent.contains(tmp.name())) {
				result = tmp;
				break;
			}
		}
		return result.desc;
	}
	
}
