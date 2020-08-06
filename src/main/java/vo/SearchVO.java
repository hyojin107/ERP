package vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class SearchVO  implements Serializable{
	private String searchType;
	private String searchWord;

	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}
