•  Error : Lexical or Preprocessor Issue 'openssl/asn1.h' file not found Targets-->工程-->Build Settings-->Search Paths-->Header Search Paths(可以直接搜索)-->添加$(PROJECT_DIR)/AlipayDemo/AliSDK2_2_3或者$(SRCROOT)/AliSDKDemo/AliSDK2_3_3注：最安全的写法是，查看Framework Search Paths里面对应的路径


Prefix.pch 文件，然后再setting里面找到并设置这个pch文件，然后编译PCH选项为YES
#import <Availability.h>

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

就不需要上面的util修改了

如果还有错误，可以将demo里面需要依赖的framwork以及那几个lib从phase里面添加进去
