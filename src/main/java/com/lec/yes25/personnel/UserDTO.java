package com.lec.yes25.personnel;

public class UserDTO {
	private String username;
	private String password;
	private String name;
	private String email;
	private int deptno;
	private int positionno;
	private String phone;
	private String hiredate;
	private String admin;
	public UserDTO() {
		super();
	}
	public UserDTO(String username, String password, String name, String email, int deptno, int positionno,
			String phone, String hiredate, String admin) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.email = email;
		this.deptno = deptno;
		this.positionno = positionno;
		this.phone = phone;
		this.hiredate = hiredate;
		this.admin = admin;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
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
	public String getHiredate() {
		return hiredate;
	}
	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	
	

}
