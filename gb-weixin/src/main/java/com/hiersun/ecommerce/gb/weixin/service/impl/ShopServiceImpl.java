package com.hiersun.ecommerce.gb.weixin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hiersun.ecommerce.gb.weixin.dao.IShopDao;
import com.hiersun.ecommerce.gb.weixin.model.Shop;
import com.hiersun.ecommerce.gb.weixin.service.IShopService;

/**
 * 金店服务
 * @author zhengruifeng
 *
 */
@Service("shopService")
public class ShopServiceImpl implements IShopService {
	@Resource
	IShopDao shopDao;
	
	@Override
	public List<Shop> getAllShops() {
		//TODO: cache
		return shopDao.getAllShops();
	}

}
