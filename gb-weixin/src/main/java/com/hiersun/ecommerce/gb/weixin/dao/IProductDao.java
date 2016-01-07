package com.hiersun.ecommerce.gb.weixin.dao;

import java.util.List;

import com.hiersun.ecommerce.gb.weixin.model.Product;

/**
 * 产品数据库访问对象
 * 
 * @author zhengruifeng
 *
 */
public interface IProductDao {
	/**
	 * 获取产品详情
	 * @param id
	 * @return
	 */
	public Product getProductById(long id);
	/*
	 * 获取所有产品
	 */
	public List<Product> getAllProducts();
}
