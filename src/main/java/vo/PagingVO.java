package vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class PagingVO<T>  implements Serializable{
	public PagingVO() {
		super();
	}
	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}


	private int screenSize = 10;
	private int blockSize = 5;
	private int currentPage;
	private int totalRecord;
	
	private int totalPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	
	private List<T> dataList;
	
	private SearchVO searchVO; 
	private T detailSearch;  //  t  안에는 어떠한 타입이 들어갈 수 있다.
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage = (int) Math.ceil(totalRecord/(double)screenSize);
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		this.endRow = currentPage*screenSize;
		this.startRow = endRow - screenSize + 1;
		this.startPage = blockSize * ((currentPage - 1)/blockSize) + 1;
		this.endPage = startPage + blockSize - 1;
	}
	
	String pattern = " <li class=\"page-item\">"
			+ " <a data-page='%1$d' class=\"page-link\" href=\"?page=%1$d\">%2$s</a>\r\n" + 
			"    </li>";
	
	public String getPagingHTML() {
		if(endPage>totalPage) {
			endPage = totalPage;
		}
		StringBuffer html = new StringBuffer();
		html.append("<nav aria-label=\"...\">\r\n" + 
				"  <ul class=\"pagination\">");
		if(startPage > blockSize) {
			html.append(String.format(pattern, startPage - blockSize, "previous"));
			}else {
				html.append(String.format(pattern.replace("page-item", "page-item disabled"), 1, "previous"));
			}
		for(int page = startPage; page <= endPage; page++) {
			html.append(
					String.format(
							currentPage!=page ? pattern : pattern.replace("page-item", "page-item active"), page, page
							)
					);
		}
		if(endPage < totalPage) {
			html.append(
					String.format(pattern, endPage+1, "next")
					);
		}else {
			html.append(String.format(pattern.replace("page-item", "page-item disabled"), 1, "next"));
		}
		html.append("  </ul>\r\n" + "</nav>");
		return html.toString();
	}

}
