//
//  MHUURL.h
//  MHUAPP
//
//  Created by jinri on 2017/12/9.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#ifndef MHUURL_h
#define MHUURL_h



//#define   kMSBaseLargeCollectionPortURL              @"http://api.snryid.top"                // 端口
#define   kMSBaseLargeCollectionPortURL              @"http://api.mhuapp.com"                // 端口
#define   kMSBaseUserHeadPortURL              @"http://api.mhuapp.com"                // 头像端口


//验证码
#define   kMSBaseCodePortURL              @"http://api.mhuapp.com/code"                // 验证码端口


/*用户相关*/
#define   kMSUserRegister         @"/user/register"              //注册
#define   kMSLoginURL             @"/user/login"                 //登陆
#define   kMSLoginqq             @"/user/qq"                 //第三方登陆
#define   kMSAddressGetsite            @"/address/get_site"                 //用户收货地址
#define   kMSAddressChangeDefault            @"/address/change_default_site"                 //修改默认收货地址
#define   kMSAddressChangeType            @"/address/change_type"                 //增/删/改 收货地址
#define   kMSAddressSiteList            @"/address/site_list"                 //平台收货地址



#define   kMSFind_pwdURL             @"/user/find_pwd"                 //找回密码
#define   kMSUpLoadIcon             @"/user/upload_icon"                 //上传头像
#define   kMSUserNickName             @"/user/nickname"              //修改昵称
#define   kMSUserBindUsername             @"/user/bind_username"              //修改手机号邮箱
#define   kMSUserGetcollect             @"/user/get_collect"              //获取个人收藏列表


/*商品分类*/
#define   kMSGetGoodsClassType             @"/goods/get_goods_class"                 //获取分类
#define   kMSVideoTypeSum             @"/video/sum_video"                 //获取分类总条数
#define   kMSVideoList             @"/video/port_video"                 //视屏列表
#define   kMSUserCollect             @"/user/user_collect"                 //收藏列表


/*交流圈 */
#define   kMSNewsSumNews            @"/news/sum_news"          //获取新闻公告总数/
#define   kMSNewsQuery            @"/news/query"          //获取新闻公告/
#define   kMSFriendsSumtribune            @"/friends/sum_tribune"          //朋友圈数据总条数
#define   kMSForumExchange            @"/friends/exchange"          //朋友圈接口
#define   kMSFriendsPubArticle            @"/friends/pub_article"          //发布朋友圈

#define   kMSForumDiscuss            @"/friends/discuss"          //获取评论内容
#define   kMSFriendsAddComment            @"/friends/add_comment"          //添加评论内容
#define   kMSFriendsLick            @"/friends/lick"          //点赞


/*图片库*/
#define   kMSImageType            @"/image/img_type"          //获取图库类型
#define   kMSImageTypeSum            @"/image/img_sum"          //获取某类型总条数
#define   kMSImageTypeGet            @"/image/get_img"          //获取图片

#endif /* MHUURL_h */
