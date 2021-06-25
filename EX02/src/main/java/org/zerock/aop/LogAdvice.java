package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	// org.zerock.service.SampleServiceImpl 의 모든 메서드가 실행되기 전에 호출 됨
	// doAdd()가 실행되기 전에 실행됨
	@Before("execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore(){
		log.info("==================");
	}
	
	// doAdd가 실행될 때만 다음의 method가 실행된다. 
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		// 로그인 작업시 id, pw를 수집해서 일치여부 확인
		// id와 pw를 로그에 기록
		log.info("str1 :" + str1);
		log.info("str2 :" + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SapmleService*.*(..))", throwing= "exception")
	public void logException(Exception exception) {
		// 로깅 작업
		log.info("Exception...!!!");
		log.info("exception: " + exception);
	}
	
	@Around("execution(* org.zerock.service.SapmleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis(); // 시작 시간
		 log.info("Taget: " + pjp.getTarget());
		 log.info("Param: " + Arrays.toString(pjp.getArgs()));
		 
		 Object result = null;
		 
		 try {
			result = pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		 long end = System.currentTimeMillis(); // 끝나는 시간
		 log.info("Time: " + (end - start));
		 
		 return result;
	}
}
