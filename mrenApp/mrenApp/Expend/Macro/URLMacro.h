//
//  URLMacro.h
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h

#define URL_TEST @"http://192.168.1.189:8080/mrenApp/"

#define URL_HOST @"https://oxyxx.com:8443/mrenApp/"

#define URL_LINE @"https://oxyxx.com:8443/mrenLine/"

#ifdef DEBUG
//#define URL_PATH(path) [NSString stringWithFormat:@"%@%@",URL_TEST,path]
#define URL_PATH(path) [NSString stringWithFormat:@"%@%@",URL_HOST,path]
#else
#define URL_PATH(path) [NSString stringWithFormat:@"%@%@",URL_HOST,path]
#endif

#define URL_LINE_PATH(path) [NSString stringWithFormat:@"%@%@",URL_LINE,path]



#define IMAGE_ALBUM_PATH(path) [NSString stringWithFormat:@"https://oxyxx.com:8443/mrAsset/album/%@",path]

#define IMAGE_HEADER_PATH(path) [NSString stringWithFormat:@"https://oxyxx.com:8443/mrAsset/headImage/%@",path]

#define IMAGE_ALBUM_LINEPATH(path) [NSString stringWithFormat:@"https://oxyxx.com:8443/mrlAsset/album/%@",path]

#define IMAGE_HEADER_LINEPATH(path) [NSString stringWithFormat:@"https://oxyxx.com:8443/mrlAsset/headImage/%@",path]


/**-----------------目录---------------------------*/
/** 相册一级目录 GET */
static NSString * const URL_PHOTO_CATEGORY1 = @"category/getCategory_1.do";


/**
 相册二级目录 GET
 
 String parentId 一级目录ID
 */
static NSString * const URL_PHOTO_CATEGORY2 = @"category/getCategory_2.do";

/**-----------------目录---------------------------*/


/**-----------------相册---------------------------*/
/**
 相册相册列表 POST
 
 String  categoryId ,
 Integer start ,
 Integer rows ，
 Integer state 1 显示 2 上线
 */
static NSString * const URL_PHOTO_ALBUM = @"photos/getPhotoAlbum.do";


/**
 相册相册列表 POST
 
 String  title ,
 Integer start ,
 Integer rows ，
 Integer state 1 显示 2 上线
 */
static NSString * const URL_PHOTO_FUZZYQUERY = @"photos/fuzzyQuery.do";


/**
 更新相册 POST
 
 MEAlbum photoAlbum 相册实体类
 */
static NSString * const URL_ALBUM_UPDATE = @"photos/updatePhotoAlbum.do";


/**
 相册图片列表 POST
 
 String photoUuid //相册uuid
 */
static NSString * const URL_PHOTO_IMAGES = @"image/getAlbumImageList.do";

/**-----------------相册---------------------------*/


/**-----------------用户---------------------------*/
/**
 用户验证码登录 POST
 
 String phoneNumber //手机号
 String authCode    //验证码
 */
static NSString * const URL_USER_AUTHLOGIN = @"user/authCodeLogin.do";

/**
 更新用户信息 POST
 
 String userUuid // uuid 必须
 String nickname
 Integer sex
 String birthday
 */
static NSString * const URL_USER_UPDATEINFO = @"user/updateUserInfo.do";

/**
 获取用户信息 POST
 
 String uuid // uuid 必须
 */
static NSString * const URL_USER_GETINFO = @"user/getUserInfo.do";


/**
 上传头像 POST
 
 String uuid // uuid 必须
 */
static NSString * const URL_UPLOAD_AVATAR = @"user/uploadAvatar.do";


/**
 获取App版本信息 POST
 
 String appVersion
 */
static NSString * const URL_USER_APPVERSION = @"user/appVersionControl.do";

/**-----------------用户---------------------------*/



#endif /* URLMacro_h */
