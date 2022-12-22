/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/3/6 16:46:51                            */
/*==============================================================*/


drop table if exists ARTICLE_INFO;

drop table if exists COMMENT_INFO;

drop table if exists LABEL_INFO;

drop table if exists MAIL_INFO;

drop table if exists RE_ARTICLE_LABEL;

drop table if exists RE_ARTICLE_TASTE;

drop table if exists RE_COMMENT_TASTE;

drop table if exists RE_USER;

drop table if exists RE_USER_LABEL;

drop table if exists USER_CATEGORY;

drop table if exists USER_INFO;

/*==============================================================*/
/* Table: ARTICLE_INFO                                          */
/*==============================================================*/
create table ARTICLE_INFO
(
   ID                   varchar(50) not null comment '文章ID',
   USER_ID              varchar(50) not null comment '用户ID',
   CATEGORY_ID          varchar(50) comment '分类ID',
   NAME                 varchar(256) comment '文章名',
   PATH                 varchar(256) not null comment '文章路径',
   IMG_PATH             varchar(256) comment '文章图片',
   LIKE_COUNT           int comment '喜欢数',
   HATE_COUNT           int comment '讨厌数',
   COMMENT_COUNT        int comment '评论数',
   VISIT_COUNT          int comment '访问数',
   CREATE_TIME          time comment '创建时间',
   ISSUE_TIME           time comment '发表时间',
   HIDE_FLAG            int comment '隐藏标志',
   ISSUE_FLAG           int comment '发行标志',
   ORIGINAL_FLAG        int comment '原创标志',
   DEL_FLAG             int comment '删除标志',
   primary key (ID)
);

alter table ARTICLE_INFO comment '文章信息';

/*==============================================================*/
/* Table: COMMENT_INFO                                          */
/*==============================================================*/
create table COMMENT_INFO
(
   ID                   varchar(50) not null comment '评论信息ID',
   USER_ID              varchar(50) not null comment '用户ID',
   REPLY_USER_ID        varchar(50) comment '回复用户ID',
   ROOT_ID              varchar(50) comment '根评论ID',
   PAR_ID               varchar(50) comment '父ID',
   ARTICLE_ID           varchar(50) comment '文章ID',
   HEAD_PATH            varchar(256) comment '用户头像',
   LIKE_COUNT           int comment '喜欢数',
   HATE_COUNT           int comment '讨厌数',
   CONTENT              varchar(1024) comment '内容',
   CREATE_TIME          time comment '创建时间',
   DEL_FLAG             int comment '删除标志',
   primary key (ID)
);

alter table COMMENT_INFO comment '评论信息';

/*==============================================================*/
/* Table: LABEL_INFO                                            */
/*==============================================================*/
create table LABEL_INFO
(
   ID                   varchar(50) not null comment '标签ID',
   NAME                 varchar(40) comment '标签名',
   CREATE_USER_NAME     varchar(40) comment '创建人名',
   CREATE_TIME          time comment '创建时间',
   primary key (ID)
);

alter table LABEL_INFO comment '标签信息';

/*==============================================================*/
/* Table: MAIL_INFO                                             */
/*==============================================================*/
create table MAIL_INFO
(
   ID                   varchar(50) not null comment '邮箱ID',
   LOCAL                varchar(60) not null comment '邮箱LOCAL',
   DOMAIN               varchar(256) not null comment '邮箱DOMAIN',
   USE_COUNT            int comment '使用次数',
   primary key (ID)
);

alter table MAIL_INFO comment '邮箱';

/*==============================================================*/
/* Table: RE_ARTICLE_LABEL                                      */
/*==============================================================*/
create table RE_ARTICLE_LABEL
(
   ARTICLE_ID           varchar(50) not null comment '文章ID',
   LABEL_ID             varchar(50) not null comment '标签ID',
   LABEL_NAME           varchar(40) not null comment '标签名',
   primary key (ARTICLE_ID, LABEL_ID)
);

alter table RE_ARTICLE_LABEL comment '文章与标签之间的联系';

/*==============================================================*/
/* Table: RE_ARTICLE_TASTE                                      */
/*==============================================================*/
create table RE_ARTICLE_TASTE
(
   USER_ID              varchar(50) not null comment '用户ID',
   ARTICLE_ID           varchar(50) not null comment '文章ID',
   TASTE                int comment '喜恶',
   primary key (USER_ID, ARTICLE_ID)
);

alter table RE_ARTICLE_TASTE comment '用户对文章的喜恶关系';

/*==============================================================*/
/* Table: RE_COMMENT_TASTE                                      */
/*==============================================================*/
create table RE_COMMENT_TASTE
(
   USER_ID              varchar(50) not null comment '用户ID',
   COMMENT_ID           varchar(50) not null comment '评论ID',
   TASTE                int comment '喜恶',
   primary key (USER_ID, COMMENT_ID)
);

alter table RE_COMMENT_TASTE comment '用户对评论的喜恶关系';

/*==============================================================*/
/* Table: RE_USER                                               */
/*==============================================================*/
create table RE_USER
(
   USER_ID              varchar(50) not null comment '用户ID',
   LIKE_USER_ID         varchar(50) not null comment '喜欢的用户ID',
   LIKE_USER_NAME       varchar(40) comment '喜欢的用户名',
   LIKE_USER_HEAD_PATH  varchar(256) comment '喜欢的用户头像',
   primary key (USER_ID, LIKE_USER_ID)
);

alter table RE_USER comment '存储关注和粉丝信息';

/*==============================================================*/
/* Table: RE_USER_LABEL                                         */
/*==============================================================*/
create table RE_USER_LABEL
(
   USER_ID              varchar(50) not null comment '用户ID',
   LABEL_ID             varchar(50) not null comment '标签ID',
   LABEL_NAME           varchar(40) not null comment '标签名',
   primary key (USER_ID, LABEL_ID)
);

alter table RE_USER_LABEL comment '用户与标签之间的联系';

/*==============================================================*/
/* Table: USER_CATEGORY                                         */
/*==============================================================*/
create table USER_CATEGORY
(
   ID                   varchar(50) not null comment '用户分类ID',
   NAME                 varchar(40) comment '分类名',
   USER_ID              varchar(50) comment '用户ID',
   PAR_ID               varchar(50) comment '父分类ID',
   DEL_FLAG             int comment '删除标志',
   primary key (ID)
);

alter table USER_CATEGORY comment '用户分类';

/*==============================================================*/
/* Table: USER_INFO                                             */
/*==============================================================*/
create table USER_INFO
(
   ID                   varchar(50) not null comment '用户用户信息',
   ACCOUNT              numeric(20,0) not null comment '账号',
   USER_NAME            varchar(40) not null comment '用户名',
   PWD                  varchar(60) not null comment '密码',
   MAIL_ID              varchar(50) not null comment '邮箱',
   PHONE_CODE           varchar(20) comment '电话',
   QQ                   varchar(20) comment 'QQ',
   WECHAT               varchar(25) comment '微信',
   SEX                  int comment '性别',
   BIRTHDAY             date comment '生日',
   LIKE_COUNT           int comment '总喜欢',
   HATE_COUNT           int comment '总讨厌',
   VISIT_COUNT          numeric(50,0) comment '访问量',
   ARTICLE_COUNT        int comment '文章数',
   HEAD_PATH            varchar(256) comment '头像',
   CREATE_TIME          time comment '注册时间',
   LIKE_USER_COUNT      int comment '关注数',
   LIKED_USER_COUNT     int comment '粉丝数',
   primary key (ID)
);

alter table USER_INFO comment '用户信息';

