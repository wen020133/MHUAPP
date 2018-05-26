//
//  MHUURL.h
//  MHUAPP
//
//  Created by jinri on 2017/12/9.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#ifndef MHUURL_h
#define MHUURL_h



#define   kMSBaseLargeCollectionPortURL              @"http://api.miyomei.com"                // 杨印章 端口
#define   kMSBaseMiYoMeiPortURL              @"http://api.miyomei.com/api"                // 程帝洲 端口
#define   kMSBaseUserHeadPortURL              @"https://www.miyomei.com/"                // 头像端口

#define __WECHATAJAX @"wechatAjax/notifyurl.do"


//验证码
#define   kMSBaseCodePortURL              @"/code"                // 验证码端口


/*用户相关*/
#define   kMSUserRegister         @"/user/register"              //注册
#define   kMSLoginURL             @"/user/login"                 //登陆
#define   kMSLoginqq             @"/user/qq"                 //第三方登陆
#define   kMSOutLogin          @"OutLogin"      //退出登录


#define   kMSAddressGetsite            @"/address/get_site"                 //用户收货地址
#define   kMSAddressChangeDefault            @"/address/change_default_site"                 //修改默认收货地址
#define   kMSAddressChangeType            @"/address/change_type"                 //增/删/改 收货地址
#define   kMSAddressSiteList            @"/address/site_list"                 //平台收货地址



#define   kMSFind_pwdURL             @"/user/find_pwd"                 //找回密码
#define   kMSUpLoadIcon             @"/user/icon"                 //上传头像
#define   kMSUserNickName             @"/user/nickname"              //修改昵称
#define   kMSUserBindUsername             @"/user/bind_username"              //修改手机号邮箱
#define   kMSUserGetcollect             @"/user/get_collect"              //获取个人收藏列表

/*首页*/
#define   kMSGetGoodsGetHotList             @"/goods/get_hot_list"                 //热销列表
#define   kMSGetGoodsShopInfo             @"/goods/shop_info"                 //商品详情页面


/*商品分类*/

#define   kMSGetGoodsClassType             @"/goods/get_goods_class"                 //获取分类
#define   kMSVideoTypeSum             @"/video/sum_video"                 //获取分类总条数
#define   kMSVideoList             @"/video/port_video"                 //视屏列表
#define   kMSUserCollect             @"/user/user_collect"                 //收藏列表
#define   kMSGoodsfuzzyquery             @"/goods/fuzzy_query"                 //搜索商品
#define   kMSGoodsStoreQuery             @"/goods/store_query"                 //搜索店铺

#define   kMSMainGetSeckill             @"getSeckill"                 //秒杀
#define   kMSMainGetAdThird             @"getAd/3"                 //首页轮播
#define   kMSMainGetTopic             @"getTopic"                 //专题
#define   kMSMainGoods100             @"goods/30"                 //猜你喜欢
#define   kMSGetReputation            @"getReputation/4"                 //人气推荐
#define   kMSGetToday            @"getToday"                 //今日秒杀
//#define   kMSMainGetStreet            @"getStreet"                 //店铺街
#define   kMSGetComment            @"getComment"                 //评论
#define   kMSGetDetailed           @"getDetailed"                 //商品详情页面

#define   kMSPostCart          @"/v1/postCart"                 //向购物车添加数据
#define   kMSGetGoodsDesc          @"getGoodsDesc"                 //商品的详细描述
#define   kMSGetCartList          @"getCart"                 //购物车列表数据
#define   kMSDeleteCart          @"deleteCart"                 //删除购车商品
#define   kMSPlaceAnOrder          @"/v1/placeAnOrder"                 //添加订单
#define   kMSWholeOrder          @"wholeOrder"                 //全部订单

#define   kMSListWaitPay          @"ListWaitPay"                 //待付款列表
#define   kMSDetailedPay          @"DetailedPay"                 //待付款详情

#define   kMSGetDelivery          @"getDelivery"                 //待发货列表
#define   kMSGetReceive          @"getReceive"                 //待收货列表
#define   kMSMiYoMeipay        @"/v1/pay"                 //生产支付宝签名
#define   kMSMiYoMeiWXpay        @"/v1/wxPay"                 //微信s支付宝签名

#define   kMSGetIntegralList       @"getList"                 //积分商品列表
#define   kMSGetIntegral       @"getIntegral"                 //用户积分
#define   kMSRegister       @"/v1/register"                 //积分签到
#define   kMSGetStreetCategory       @"getStreetCategory"                 //店铺分类
#define   kMSGetStreetGoods      @"getStreetGoods"                 //店铺街
#define   kMSGetSupplierNum      @"getSupplierNum"                 //某个店铺的商品总数
#define   kMSGetBestSeller      @"newGoods"                 //某个店铺热销商品
#define   kMSPostOrderIntegral      @"/v1/postOrderIntegral"                 //积分商城用户下单
#define   kMSGetGroupList      @"getGroupList"                 //拼团列表
#define   kMSGetOrderIntegral      @"getOrderIntegral"                 //积分订单
#define   kMSMiYoMeiGetNum      @"getNum"                 //获取某个商品的销售数量
#define   kMSPostGoodsList      @"/goods/list"                 //获取分类商品列表

#define   kMSMiYoMeiQuery        @"/v1/query"                 //物流详情

#define   kMSGetIsNewGoods        @"getIsNewGoods"                 //更多新品
#define   kMSMiYoMeigetGroupOrder        @"/v1/getGroupOrder"                 //拼团下单
#endif /* MHUURL_h */
