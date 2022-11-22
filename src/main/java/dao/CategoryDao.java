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
		
		return list;
	}
}
