package model;
import dto.*;
import java.sql.*;
import java.util.*;

public class BoardDao {
	
	// 전체 글 가져오는 메소드
	public ArrayList<Board> selectBoardList(Paging p) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select * from board order by ref desc, pos limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Board> list = new ArrayList<>();
		while(rs.next()) {
			Board b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setCount(rs.getInt("count"));
			b.setRegdate(rs.getString("regdate"));
			
			list.add(b);
		}
		conn.close();
		
		return list;
	}

	// 상세보기 메소드
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select * from board where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,num);
		ResultSet rs = stmt.executeQuery();
		Board b = new Board();
		if(rs.next()) {
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
		}
		
		conn.close();
		
		return b;
	}
	
	// 전체 글 개수 구하는 메소드
	public int totalBoard() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select count(*) from board";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		
		int totalCount = rs.getInt("count(*)");
		
		conn.close();
		
		return totalCount;
	}
	
	// 새글 입력
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		
		// 트랜잭션(2개이상의 (CUD)쿼리 한 묶음처럼 처리하고자 할때
		conn.setAutoCommit(false); // executeUpdate()시마다 자동 커밋기능을 false
		
		String sql = "insert into board(name, subject, content, ref, pass, ip) values(?,?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // ref == 0면 입력직후 pk를 반환받기 위해
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		
		stmt.executeUpdate(); 
		
		// ref == 0면 입력직후 pk값을 반환 받아서 ref값을 동일하게 
		ResultSet rs = stmt.getGeneratedKeys();
		int pk=0;
		if(rs.next()) {
			pk=rs.getInt(1);
		}
		
		System.out.println("insertBoard#pk: "+pk);
		
		PreparedStatement stmt2 = null;
		String sql2 = "update board set ref=? where num=?";
		stmt2=conn.prepareStatement(sql2);
		// updeat쿼리가 실패하면 이전의 insert도 롤백 : conn.rollback();
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		stmt2.executeUpdate();
		
		conn.commit(); // conn.setAutoCommit(false); 코드때문에 필요
		conn.close();
	}

	// 답글 입력
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		
		// 트랜잭션(2개이상의 (CUD)쿼리 한 묶음처럼 처리하고자 할때
		conn.setAutoCommit(false); // executeUpdate()시마다 자동 커밋기능을 false
		
		// ref같고 pos값이 현재글보다 크거나 같다면 +1 입력직후 pk값을 반환 받아서 ref값을 동일하게 
		String sql2="update board set pos = pos+1 where ref=? and pos >= ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, b.getRef());
		stmt2.setInt(2, b.getPos());
		
		int row2 = stmt2.executeUpdate();
		
		
		String sql = "insert into board(name, subject, content, ref, pass, ip, pos, depth) values(?,?,?,?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql); // ref == 0면 입력직후 pk를 반환받기 위해
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		stmt.setInt(7, b.getPos());
		stmt.setInt(8, b.getDepth());
		
		int row = stmt.executeUpdate(); 
		
		conn.commit(); // conn.setAutoCommit(false); 코드때문에 필요
		conn.close();
	}
	
	// boardOne에서 글 수정하는 메소드
	public void updateBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "update board set name=?,subject=?,content=? where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getNum());
		
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("수정 성공");
		}
		else {
			System.out.println("수정 실패");
		}
		
		conn.close();
	}
	
	// boardOne 접속 시 해당글 count+1 하는 메소드
	public void upCount(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "update board set count=count+1 where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// 삭제 메소드 (글이 삭제되면 댓글들 제목과 내용 변경)
	public void deleteBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		conn.setAutoCommit(false); 
		
		String sql = "delete from board where num = ? and pass = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, b.getNum());
		stmt.setString(2, b.getPass());
		
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("삭제 성공");
		}
		else {
			System.out.println("삭제 실패");
		}
		if(b.getPos()==0) {
			String sql2 = "update board set subject='해당글이 삭제되었습니다.',content='삭제된 글' where ref=?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, b.getRef());
			stmt2.executeUpdate();
		}
		
		conn.commit();
		conn.close();
	}	
}
