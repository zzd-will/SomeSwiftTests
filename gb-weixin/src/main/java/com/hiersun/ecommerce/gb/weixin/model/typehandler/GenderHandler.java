package com.hiersun.ecommerce.gb.weixin.model.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import com.hiersun.ecommerce.gb.weixin.model.enums.Gender;

/**
 * Gender枚举类型的转换
 * @author zhengruifeng
 *
 */
public class GenderHandler extends BaseTypeHandler<Gender>  {
	 private Class<Gender> type;  
     
	    private final Gender[] enums;  
	   
	    public GenderHandler(Class<Gender> type) {  
	        if (type == null)  
	            throw new IllegalArgumentException("Type argument cannot be null");  
	        this.type = type;  
	        this.enums = type.getEnumConstants();  
	        if (this.enums == null)  
	            throw new IllegalArgumentException(type.getSimpleName()  
	                    + " does not represent an enum type.");  
	    }  
	  
	    @Override  
	    public void setNonNullParameter(PreparedStatement ps, int i, Gender parameter, JdbcType jdbcType) throws SQLException {
	        ps.setInt(i, parameter.getGender());  
	          
	    }  
	  
	    @Override  
	    public Gender getNullableResult(ResultSet rs, String columnName) throws SQLException {  
	        int i = rs.getInt(columnName);  
	           
	        if (rs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	  
	    @Override  
	    public Gender getNullableResult(ResultSet rs, int columnIndex)  throws SQLException {  
	        int i = rs.getInt(columnIndex);  
	        if (rs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	  
	    @Override  
	    public Gender getNullableResult(CallableStatement cs, int columnIndex)  
	            throws SQLException {  
	        int i = cs.getInt(columnIndex);  
	        if (cs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	      
	    private Gender locateEnumStatus(int code) {  
	        for(Gender status : enums) {  
	            if(status.getGender() == (Integer.valueOf(code))) {  
	                return status;  
	            }  
	        }  
	        throw new IllegalArgumentException("未知的枚举类型：" + code + ",请核对" + type.getSimpleName());  
	    }  
}
