package org.zerock.persistance;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

// pom.xml에서 log4j에서의 <scope>runtime</scope>, junit의 <scope>test</scope> 부분을 삭제해주어야한다.
@Log4j
public class JDBCTest {
	
	// timeMapper라는 객체가 생성된다.(원래 java에서 interface는 객체를 생성할 수 없다. 그러나 spring에서는 의존성주입을 통해서 자동 생성된다. )
	@Setter(onMethod_ = @Autowired)
	private TimeMapper timeMapper; // 주입
	
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	@Test
//	public void testConnection() {
//		try (	// 자동으로 db.close를 실행 시켜 준다.
//			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "ora_user", "hong")
//			) { 
//			System.out.println("연동확인"); // 디버깅을 위해 작성
//			log.info(con);
//		} catch (Exception e) {
//			fail(e.getMessage());
//		}
//	}
	
	@Test
	public void testGetTime2() {
		log.info("getTime2");
		log.info(timeMapper.getTime2());
	}
	
}


