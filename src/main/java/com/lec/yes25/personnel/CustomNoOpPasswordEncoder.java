package com.lec.yes25.personnel;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	// 주어진 rawPassword 를 인코딩하여 리턴한다, 일반적으로 SHA-1 혹은 그 이상의 암호화 알고리즘을 사용한다.
	@Override
	public String encode(CharSequence rawPassword) {
		System.out.println("encode 전 : " + rawPassword);
		return rawPassword.toString(); // 언제 encode() 호출되는 거 일단 확인해보자.
	}

	// 매개변수 첫번째랑 두번째 비교해서 같으면 true 리턴, 아니면 false 리턴
	// 주어진 rqwPassword 가 인코딩 된 비번과 동일한지 판정.
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		System.out.println("matches 수행 : " + rawPassword + " :: " + encodedPassword);
		return rawPassword.equals(encodedPassword);
	}

}
