package board.preparer;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import vo.MenuVO;

public class BoardViewPreparer implements ViewPreparer{

	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext) {
		MenuVO menu1 = new MenuVO();
		menu1.setUrl("/board");
		menu1.setText("전체 게시판");
		MenuVO menu2 = new MenuVO();
		menu2.setUrl("/board/form");
		menu2.setText("새글쓰기");
		List<MenuVO> menuList = new ArrayList<>();
		menuList.add(menu1);
		menuList.add(menu2);
		Map<String, Object> scope = tilesContext.getContext(Request.REQUEST_SCOPE);
		scope.put("menuList", menuList);

	}

}
