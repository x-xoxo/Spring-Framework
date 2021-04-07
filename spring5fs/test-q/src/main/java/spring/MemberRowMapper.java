package spring;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class MemberRowMapper implements RowMapper<Member> {

	@Override
	public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
		Member member = new Member(
				rs.getString("NAME"),
				rs.getString("PNUM"),
				rs.getString("GENDER"),
				rs.getString("BIRTHDATE"));
		return member;
	}

}
