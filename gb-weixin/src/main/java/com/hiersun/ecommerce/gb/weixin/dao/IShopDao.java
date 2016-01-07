package com.hiersun.ecommerce.gb.weixin.dao;

import java.util.List;

import com.hiersun.ecommerce.gb.weixin.model.Shop;

/**
 * 店铺数据库操作对象类
 * 
 * @author zhengruifeng
 *
 */
public interface IShopDao {
	public List<Shop> getAllShops();
}
