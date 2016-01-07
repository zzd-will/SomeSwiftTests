package com.hiersun.ecommerce.gb.weixin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hiersun.ecommerce.gb.weixin.dao.IProductDao;
import com.hiersun.ecommerce.gb.weixin.model.Product;
import com.hiersun.ecommerce.gb.weixin.service.IProductService;

/**
 *  产品服务实现
 * @author zhengruifeng
 *
 */
@Service("productService")
public class ProductServiceImpl implements IProductService{
	@Resource IProductDao productDao;	
	
	@Override
	public Product getProductById(long id) {
		//TODO: 增加cache
		return productDao.getProductById(id);
	}

	@Override
	public List<Product> getAllProducts() {
		//TODO: 增加cache
		return productDao.getAllProducts();
	}

}
