package com.hiersun.ecommerce.gb.weixin.utils;

import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.hiersun.ecommerce.gb.weixin.message.resp.*;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.Dom4JDriver;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;
import com.thoughtworks.xstream.mapper.MapperWrapper;

public class XMLTools {
	
	private static XStream xstream = new XStream(new XppDriver() {
		public HierarchicalStreamWriter createWriter(Writer out) {
			return new PrettyPrintWriter(out) {
				// 是否增加CDATA标记
				boolean cdata = true;

				public void startNode(String name, Class clazz) {
					super.startNode(name, clazz);
					// CreateTime不需要增加CDATA 如果还有其他字段就增加在这里
					// CreateTime字段是固定忽略字符串，否则需要通过反射注解来确定是否特殊处理

					if (name.equals("CreateTime")) {
						cdata = false;

					} else {
						cdata = true;
					}
				}

				protected void writeText(QuickWriter writer, String text) {
					if (cdata) {
						writer.write("<![CDATA[");
						writer.write(text);
						writer.write("]]>");
					} else {
						writer.write(text);
					}
				}
			};
		}
	});

	// 把类名替换为消息需要的xml开头
	public static String toXML(BaseMessage base) {
		xstream.alias("xml", base.getClass());
		String xml = xstream.toXML(base);
		return xml;
	}

	// 图文格式需要把Articles字段的名字抓换为xml里面的item
	public static String toXML(BaseMessage base, Object Articlesitemclass) {
		xstream.alias("xml", base.getClass());
		xstream.alias("item", Articlesitemclass.getClass());
		String xml = xstream.toXML(base);
		return xml;
	}
private static XStream xStreamXmlTobean = null;
	public static <T> T xmlToBean(String xml, Class<T>... clazz) {

		T t = null;

		xStreamXmlTobean = new XStream(new Dom4JDriver()) { // xml转对象需要用到dom4j.jar包
			
			@Override
			protected MapperWrapper wrapMapper(MapperWrapper next) {
				return new MapperWrapper(next) {
					@Override
					public boolean shouldSerializeMember(Class definedIn,
							String fieldName) {

						if (definedIn == Object.class) {
							try {
								return this.realClass(fieldName) != null;

							} catch (Exception e) {
								return false;
							}
						}

						return super
								.shouldSerializeMember(definedIn, fieldName);
					}

				};
			}

		};

		xStreamXmlTobean.setMode(XStream.NO_REFERENCES);
		xStreamXmlTobean.processAnnotations(clazz);
		t = (T) xStreamXmlTobean.fromXML(xml);

		return t;
	}
	public static <T> T fromXML(String xml,Class  c)
	{
		String adapterXml=xml.replace("xml",c.getName());
//		System.out.println("把xml标记转化成类名后的xml"+adapterXml);
		T t = (T) xmlToBean(adapterXml,c.getClass());
		return t;
	}
	//用来转化图文结构
	public static <T> T fromXML(String xml,Class  c,Class b)
	{
		String adapterXml=xml.replace("xml",c.getName());
		String adapterXml2=adapterXml.replace("item",b.getName());
//		System.out.println("把xml标记转化成类名后的xml"+adapterXml);
		T t = (T) xmlToBean(adapterXml2,c.getClass());
		return t;
	}
	
	public static Map<String, String> parseXmltoMap(HttpServletRequest request)
			throws Exception {
		// 将解析结果存储在HashMap中
		Map<String, String> map = new HashMap<String, String>();
		// 从request中取得输入流
		InputStream inputStream = request.getInputStream();
		// 读取输入流
		SAXReader saxReader = new SAXReader();
		Document document = saxReader.read(inputStream);
		// 得到xml根元素
		Element root = document.getRootElement();
		// 得到根元素的所有子节点
		List<Element> elementList = root.elements();

		// 遍历所有子节点
		for (Element e : elementList)
			map.put(e.getName(), e.getText());

		// 释放资源
		inputStream.close();
		inputStream = null;

		return map;
	}

}
