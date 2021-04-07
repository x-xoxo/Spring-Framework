package spring;

public class Member {

	private String name;
	private String pNum;
	private String gender;
	private String birthDate;

	public Member(String name, String pNum, 
			String gender, String birthDate) {
		this.name = name;
		this.pNum = pNum;
		this.gender = gender;
		this.birthDate = birthDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getpNum() {
		return pNum;
	}

	public void setpNum(String pNum) {
		this.pNum = pNum;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	

	

}
