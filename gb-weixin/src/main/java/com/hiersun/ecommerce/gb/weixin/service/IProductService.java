package com.hiersun.ecommerce.gb.weixin.service;

import java.util.List;

import com.hiersun.ecommerce.gb.weixin.model.Product;

/**
 * 产品服务
 * 
 * @author zhengruifeng
 *
 */
public interface IProductService {
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
