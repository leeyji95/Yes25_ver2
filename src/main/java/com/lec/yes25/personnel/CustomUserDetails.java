package com.lec.yes25.personnel;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class CustomUserDetails implements UserDetails {
	
	// 사용자 정보들의 멤버변수를 선언한다. 정보에 관한 멤버변수가 더 필요하다면 추가해도 된다.


	private String username;
	private String password;
	private boolean enabled;
	private String authority; // emp_admin
	
	private String name; // emp_name
	private String email; // emp_email
	private int deptno; // dept_uid
	private int positionno; // position_uid
	private String phone; // emp_phone
	private Date hiredate; // emp_hiredate
	
	// 계정이 갖고 있는 권한을 목록으로 리턴하기 위한 설정
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		   ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
	        auth.add(new SimpleGrantedAuthority(authority));
	        return auth;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override // 계정의 활성/비활성 여부가 담긴 ENABLED 멤버변수를 리턴
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return enabled;
	}

	// 사용자의 추가 정보들의 getter, setter
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public int getPositionno() {
		return positionno;
	}

	public void setPositionno(int positionno) {
		this.positionno = positionno;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	
	
}
