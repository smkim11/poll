package model;

import java.sql.*;
import java.util.*;

import dto.*;

// Table : question crud
public class QuestionDao {
	
	// 종료날짜 수정하는 메소드
	public int updateEnddate(Question q) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "update question set enddate=? where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, q.getEnddate());
		stmt.setInt(2, q.getNum());
		
		int row = stmt.executeUpdate();
		
		conn.close();
		
		return row;
	}
	
	// 전체 수정하는 메소드
	public int updateQuestion(Question q) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "update question set title=?, startdate=?, enddate=?, type=? where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, q.getTitle());
		stmt.setString(2, q.getStartdate());
		stmt.setString(3, q.getEnddate());
		stmt.setInt(4, q.getType());
		stmt.setInt(5, q.getNum());
		
		int row = stmt.executeUpdate();
		
		conn.close();
		
		return row;
	}
	
	// num에 해당하는 전체 정보 가져오는 메소드
	public Question selectQuestionOne(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select num, title, startdate, enddate, type from question where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		ResultSet rs = stmt.executeQuery();
		Question q = new Question();
		if(rs.next()) {
			q.setNum(rs.getInt("num"));
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startdate"));
			q.setEnddate(rs.getString("enddate"));
			q.setType(rs.getInt("type"));
		}
		
		conn.close();
		
		return q;
	}
	
	// 설문 삭제 메소드
	public int deleteQuestion(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="delete from question where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 설문 총 개수 구하는 메소드
	public int questionTotalRow() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql="select count(*) from question";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs= stmt.executeQuery();
		rs.next();
		int total = rs.getInt(1);
		
		conn.close();
		return total;
	}

	// 테이블을 조인하여 전체 question 정보와 투표인원 총합을 가져오는 메소드
	public ArrayList<HashMap<String,Object>> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		PreparedStatement stmt = null;
		
		String sql = "SELECT q.num, q.title, q.startdate, q.enddate, q.type, t.cnt "
					+ "FROM question q "
					+ "INNER JOIN (SELECT qnum, SUM(COUNT) cnt "
					+ "FROM item GROUP BY qnum)t "
					+ "ON q.num = t.qnum "
					+ "order by num desc "
					+ "LIMIT ?,?";

		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		
		ResultSet rs= stmt.executeQuery();
	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("num", rs.getInt("num"));
			map.put("title", rs.getString("title"));
			map.put("startdate", rs.getString("startdate"));
			map.put("enddate", rs.getString("enddate"));
			map.put("type", rs.getInt("type"));
			map.put("cnt", rs.getInt("cnt"));
			
			list.add(map);
		}
		conn.close();
		return list;
	}

	// 입력 후 자동으로 생성된 키값을 반환
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		PreparedStatement stmt = null;
		String sql = "insert into question(title,startdate,enddate,type) values(?,?,?,?)";
		// Statement.RETURN_GENERATED_KEYS : insert 실행 후 자동으로 select max(pk) from... 실행
		stmt=conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); 
		stmt.setString(1,question.getTitle());
		stmt.setString(2,question.getStartdate());
		stmt.setString(3,question.getEnddate());
		stmt.setInt(4,question.getType());
		
		int row = stmt.executeUpdate(); // insert
		
		// 입력이지만 키값을 받아올때 사용
		ResultSet rs = stmt.getGeneratedKeys(); // 방금 삽입한 행의 AUTO_INCREMENT 값을 받아오는 함수
		if(rs.next()) {
			pk=rs.getInt(1);
		}
		System.out.println("pk: "+pk);
		conn.close();
		return pk;
	}
}
