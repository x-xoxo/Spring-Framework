package spring;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;

public class MemberDao {

	private JdbcTemplate jdbcTemplate;

	public MemberDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void insert(Member member) {
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				// 파라미터로 전달받은 Connection을 이용해서 PreparedStatement 생성
				PreparedStatement pstmt = con.prepareStatement(
						"insert into info (NAME, PNUM, GENDER, BIRTHDATE) " +
						"values (?, ?, ?, ?)");
				// 인덱스 파라미터 값 설정
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getpNum());
				pstmt.setString(3, member.getGender());
				pstmt.setString(4, member.getBirthDate());
				// 생성한 PreparedStatement 객체 리턴
				return pstmt;
			}
		});
	}

	public List<Member> selectAll() {
		List<Member> results = jdbcTemplate.query("select * from info",
				(ResultSet rs, int rowNum) -> {
					Member member = new Member(
							rs.getString("NAME"),
							rs.getString("PNUM"),
							rs.getString("GENDER"),
							rs.getString("BIRTHDATE"));
					return member;
				});
		return results;
	}

	public int count() {
		Integer count = jdbcTemplate.queryForObject(
				"select count(*) from INFO", Integer.class);
		return count;
	}

}
