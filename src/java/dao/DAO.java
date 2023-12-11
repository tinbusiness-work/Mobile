/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Mobile;
import dto.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author tinhtse173630
 */
public class DAO {

    private static final String LOGIN = "SELECT userId, fullName, role FROM tbl_User WHERE userId = ? AND password= ?";
    private static final String INSERT = "INSERT INTO [dbo].[tbl_Mobile]([mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale]) VALUES(?,?,?,?,?,?,?)";
    private static final String INSERT_TO_DATABASE = "INSERT INTO [dbo].[tbl_Cart]([mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale]) VALUES(?,?,?,?,?,?,?)";
    private static final String SEARCH = "SELECT [mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale] FROM [dbo].[tbl_Mobile] WHERE [mobileId] LIKE ? OR [mobileName] LIKE ? ORDER BY  [quantity] ASC";
    private static final String SEARCH_USER = "SELECT [mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale] FROM [dbo].[tbl_Mobile] WHERE [price] BETWEEN ? AND ? ORDER BY [quantity] ASC";
    private static final String UPDATE = "UPDATE [dbo].[tbl_Mobile] SET [description] = ?, [price] = ?, [mobileName] = ?, [yearOfProduction] = ?, [quantity] = ?, [notSale] = ? WHERE [mobileId] LIKE ?";
    private static final String DELETE = "DELETE [dbo].[tbl_Mobile] WHERE [mobileId] = ?";

    public Users checkLogin(String userId, String password) throws SQLException {
        Users user = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(LOGIN);
                ps.setString(1, userId);
                ps.setString(2, password);
                rs = ps.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    int role = rs.getInt("role");
                    user = new Users(userId, fullName, "", role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                rs.close();
            }
            if (con != null) {
                rs.close();
            }
        }
        return user;
    }

    public List<Mobile> getMobileList(String search) throws SQLException, ClassNotFoundException {
        List<Mobile> mobList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(SEARCH);
                ps.setString(1, '%' + search + '%');
                ps.setString(2, '%' + search + '%');
                rs = ps.executeQuery();
                while (rs.next()) {
                    String mobileId = rs.getString("mobileId");
                    String description = rs.getString("description");
                    float price = rs.getFloat("price");
                    String mobileName = rs.getString("mobileName");
                    int yearOfProduction = rs.getInt("yearOfProduction");
                    int quantity = rs.getInt("quantity");
                    boolean notSale = rs.getBoolean("notSale");
                    mobList.add(new Mobile(mobileId, description, price, mobileName, yearOfProduction, quantity, notSale));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                rs.close();
            }
            if (con != null) {
                rs.close();
            }
        }
        return mobList;
    }

    public List<Mobile> getMobilePriceInRange(float minPrice, float maxPrice) throws SQLException, ClassNotFoundException {
        List<Mobile> mobList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(SEARCH_USER);
                ps.setFloat(1, minPrice);
                ps.setFloat(2, maxPrice);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String mobileId = rs.getString("mobileId");
                    String description = rs.getString("description");
                    float price = rs.getFloat("price");
                    String mobileName = rs.getString("mobileName");
                    int yearOfProduction = rs.getInt("yearOfProduction");
                    int quantity = rs.getInt("quantity");
                    boolean notSale = rs.getBoolean("notSale");
                    mobList.add(new Mobile(mobileId, description, price, mobileName, yearOfProduction, quantity, notSale));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return mobList;
    }

    public boolean update(Mobile mob) throws SQLException {
        boolean checkUpdate = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(UPDATE);
                ps.setString(1, mob.getDescription());
                ps.setFloat(2, mob.getPrice());
                ps.setString(3, mob.getMobileName());
                ps.setInt(4, mob.getYearOfProduction());
                ps.setInt(5, mob.getQuantity());
                ps.setBoolean(6, mob.isNotSale());
                ps.setString(7, mob.getMobileId());
                checkUpdate = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkUpdate;
    }

    public boolean insert(Mobile mob) throws SQLException {
        boolean checkInsert = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(INSERT);
                ps.setString(1, mob.getMobileId());
                ps.setString(2, mob.getDescription());
                ps.setFloat(3, mob.getPrice());
                ps.setString(4, mob.getMobileName());
                ps.setInt(5, mob.getYearOfProduction());
                ps.setInt(6, mob.getQuantity());
                ps.setBoolean(7, mob.isNotSale());
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkInsert;
    }

    public boolean delete(String mobileId) throws ClassNotFoundException, SQLException {
        boolean checkDelete = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(DELETE);
                ps.setString(1, mobileId);
                checkDelete = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkDelete;
    }

    public boolean insertToDataBase(Mobile mob, int quantity) throws SQLException {
        boolean checkInsert = false;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ps = con.prepareStatement(INSERT_TO_DATABASE);
                ps.setString(1, mob.getMobileId());
                ps.setString(2, mob.getDescription());
                ps.setFloat(3, mob.getPrice());
                ps.setString(4, mob.getMobileName());
                ps.setInt(5, mob.getYearOfProduction());
                ps.setInt(6, quantity);
                ps.setBoolean(7, mob.isNotSale());
                checkInsert = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return checkInsert;
    }
}
