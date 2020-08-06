//package ERP.controller.account;
//
//import java.util.List;
//import java.util.Set;
//
//import javax.servlet.ServletContext;
//
//import org.springframework.web.context.WebApplicationContext;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import vo.account.AccountVO;
//
//public class �쎒�냼耳� {
//	
//	//�쎒�냼耳� �궗�슜踰�
//	private void sendUserListToWebSocket(ServletContext application, Set<AccountVO> userList) {
//		WebApplicationContext rootContext = 
//				(WebApplicationContext) application.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
//		List<WebSocketSession> wsSessionList = rootContext.getBean("wsSessionList", List.class);
//		try {
//			ObjectMapper mapper = new ObjectMapper();
//			String json = mapper.writeValueAsString(userList);
//			for(WebSocketSession wsSession : wsSessionList) {
//				wsSession.sendMessage(new TextMessage(json));
//			}
//		}catch (Exception e) {
//			throw new RuntimeException(e);
//		}
//	}
//}
