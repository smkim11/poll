package model;
import java.sql.*;
import java.util.*;
import dto.*;
// Table : item crud
public class ItemDao {
	
	// 생성 메소드
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		PreparedStatement stmt = null;
		String sql = "insert into item(qnum,inum,content) values(?,?,?)";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3,item.getContent());
		
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("ItemDao.insertItem 입력성공");
		}else {
			System.out.println("ItemDao.insertItem 입력실패");
		}
		conn.close();
	}
	
	// 삭제하는 메소드
	public int deleteItem(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="delete from item where qnum=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// item 테이블에서 qnum에 해당하는 전체 값을 가져오는 메소드
	public ArrayList<Item> itemList(int num) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="select qnum,count, content, inum from item where qnum=? order by inum asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Item> list = new ArrayList<>();
		while(rs.next()) {
			Item i = new Item();
			i.setQnum(num);
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			
			list.add(i);
		}
		
		conn.close();
		return list;
	}
	
	// 투표한 개수만큼 count증가하는 메소드
	public void updateItemCountPlus(int inum, int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="update item set count= count+1 where inum =? and qnum=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, inum);
		stmt.setInt(2, num);
		
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("ItemDao.updateItemCountPlus 입력성공");
		}else {
			System.out.println("ItemDao.updateItemCountPlus 입력실패");
		}
	}
	
	// qnum에 해당하는 총 투표수 구하는 메소드
	public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
		int count=0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="select qnum, SUM(COUNT) cnt from item GROUP BY qnum HAVING qnum=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt("cnt");
		}
		return count;
	}
	
}
