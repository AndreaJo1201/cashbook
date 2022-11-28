package dao;
import vo.*;
import java.util.*;
import java.sql.*;

import util.DBUtil;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		//ORDER BY category_kind ASC;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category ORDER BY category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
			category.setCategoryKind(rs.getString("categoryKind"));
			
			list.add(category);
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		//ORDER BY category_kind ASC;
		
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind, updatedate, createdate FROM category ORDER BY category_kind ASC";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setUpdatedate(rs.getString("updatedate"));
			category.setCreatedate(rs.getString("createdate"));
			
			list.add(category);
		}
		
		//DB자원(jdbc api) 반납
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	public int selectCoategoryCount() throws Exception {
		int row = 0;
		
		String sql = "SELECT COUNT(*) cnt FROM category";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		return row;
	}
	
	// admin - > insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO category (category_name, category_kind, updatedate, createdate) VALUES (?, ?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryKind());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("실패");
		} else {
			System.out.println("성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no=?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("실패");
		} else {
			System.out.println("성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	//update
	//admin - > updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		rs = stmt.executeQuery();
		
		
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return category;
	}
	
	
	//admin - > updateCategoryAction.jsp
	public int updateCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "UPDATE category SET category_name = ?, updatedate = NOW() WHERE category_no=?";
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		
		row = stmt.executeUpdate();
		
		if(row == 0) {
			System.out.println("실패");
		} else {
			System.out.println("성공");
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
}
