package spring;

public class MemberRegisterService {
	private MemberDao memberDao;

	public MemberRegisterService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void regist(RegisterRequest req) {
		Member newMember = new Member(
				req.getName(), req.getpNum(), req.getGender(), 
				req.getBirthDate());
		memberDao.insert(newMember);
	}
}
