package model;

import java.sql.*;
import java.util.*;
import dto.*;

public class ImageDao {
	
	public void deleteImage(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "delete from image where num=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// 전체 정보 출력
	public ArrayList<Image> selectImageList(Paging p) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select num, memo, filename, createdate from image order by num desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		ArrayList<Image> list = new ArrayList<>();
		while(rs.next()) {
			Image i = new Image();
			i.setNum(rs.getInt("num"));
			i.setMemo(rs.getString("memo"));
			i.setFilename(rs.getString("filename"));
			i.setCreatedate(rs.getString("createdate"));
			
			list.add(i);
		}
		
		conn.close();
		
		return list;
	}
	
	// 전체 개수
	public int totalCount() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "select count(*) from image";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		
		int totalCount = rs.getInt("count(*)");
		
		return totalCount;
	}
	
	// memo 와 이미지 등록
	public void insertImage(Image img) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/poll", "root", "java1234");
		String sql = "insert into image(memo,filename) values(?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, img.getMemo());
		stmt.setString(2, img.getFilename());
		
		stmt.executeUpdate();
		conn.close();
	}
}
