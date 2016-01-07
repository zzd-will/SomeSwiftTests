package com.hiersun.ecommerce.gb.weixin.model.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import com.hiersun.ecommerce.gb.weixin.model.enums.ProductType;

public class ProductTypeHandler extends BaseTypeHandler<ProductType>  {
	 private Class<ProductType> type;  
     
	    private final ProductType[] enums;  
	   
	    public ProductTypeHandler(Class<ProductType> type) {  
	        if (type == null)  
	            throw new IllegalArgumentException("Type argument cannot be null");  
	        this.type = type;  
	        this.enums = type.getEnumConstants();  
	        if (this.enums == null)  
	            throw new IllegalArgumentException(type.getSimpleName()  
	                    + " does not represent an enum type.");  
	    }  
	  
	    @Override  
	    public void setNonNullParameter(PreparedStatement ps, int i, ProductType parameter, JdbcType jdbcType) throws SQLException {
	        ps.setInt(i, parameter.getProductType());  
	          
	    }  
	  
	    @Override  
	    public ProductType getNullableResult(ResultSet rs, String columnName) throws SQLException {  
	        int i = rs.getInt(columnName);  
	           
	        if (rs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	  
	    @Override  
	    public ProductType getNullableResult(ResultSet rs, int columnIndex)  throws SQLException {  
	        int i = rs.getInt(columnIndex);  
	        if (rs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	  
	    @Override  
	    public ProductType getNullableResult(CallableStatement cs, int columnIndex)  
	            throws SQLException {  
	        int i = cs.getInt(columnIndex);  
	        if (cs.wasNull()) {  
	            return null;  
	        } else {  
	            return locateEnumStatus(i);  
	        }  
	    }  
	      
	    private ProductType locateEnumStatus(int code) {  
	        for(ProductType status : enums) {  
	            if(status.getProductType() == (Integer.valueOf(code))) {  
	                return status;  
	            }  
	        }  
	        throw new IllegalArgumentException("未知的枚举类型：" + code + ",请核对" + type.getSimpleName());  
	    }  
}
