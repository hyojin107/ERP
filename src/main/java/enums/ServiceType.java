package enums;

public enum ServiceType {
	STANDARDJSP("/01/standard.jsp"),
	CALFORM("/01/calForm.jsp"),
	CALENDAR("/02/calendar.jsp"),
	SESSIONTIMER("/05/sessionTimer.jsp"),
	CONTEXT("/ddit/contextBrowse.do");

	private String page;
 	
	private ServiceType(String page) {
		this.page = page;
	}

	public String getPage() {
		return page;
	}

	public static String getPath(String userAgent) {
		ServiceType result = valueOf(userAgent);
		
		return result.page;
	}
}
