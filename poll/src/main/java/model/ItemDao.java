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
	
	// item 테이블에서 content값을 가져오는 메소드
	public ArrayList<Item> itemList(int num) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql ="select content from item where qnum=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Item> list = new ArrayList<>();
		while(rs.next()) {
			Item i = new Item();
			i.setContent(rs.getString("content"));
			
			list.add(i);
		}
		
		conn.close();
		return list;
	}
}
