create database if not exists d_cllxyz default charset utf8 collate utf8_general_ci;

use d_cllxyz;

-- 删除数据表
drop table if exists t_role_permission;
drop table if exists t_permission;
drop table if exists t_ads;
drop table if exists t_article;
drop table if exists t_article_type;
drop table if exists t_admin;
drop table if exists t_appointment;
drop table if exists t_sale;
drop table if exists t_buildings_img;
drop table if exists t_activity;
drop table if exists t_room;
drop table if exists t_house;
drop table if exists t_building;
drop table if exists t_customer;
drop table if exists t_mission;
drop table if exists t_employee;
drop table if exists t_message;
drop table if exists t_comment;
drop table if exists t_like;
drop table if exists t_history;
drop table if exists t_user;
drop table if exists t_buildings;
drop table if exists t_agency;
drop table if exists t_role;

	-- 22，创建角色表t_role

create table t_role
(
	id	varchar(36) primary key,-- 编号,UUID，主键
	name	varchar(50) not null,-- 角色名称,not null
	des	varchar(50) not null,-- 角色描述,not null
	created_time datetime,-- 创建时间
	status	tinyint -- 状态，激活或冻结
);

insert into t_role values ('b07db0289b5344cf911723bd9e6e3832', 'admin', '平台管理员', '2017-08-23 21:57:40', '1');
insert into t_role values ('ba18d787e0fc4019a4611943c5193765', 'agency', '房产经销商管理员', '2017-08-23 22:11:01', '1');
insert into t_role values ('235e964e87c34ac2959ce702f4a50e3d', 'employee', '房产经销商销售员工', '2017-08-23 22:12:01', '1');
insert into t_role values ('3944c4378b3a4d5fa813455d6cca16f6', 'user', '购房用户', '2017-08-23 22:13:10', '1');

-- 1，创建管理员表t_admin

create table t_admin
(
	id	varchar(36) primary key, -- 编号,UUID，主键
	phone varchar(11),	-- 手机号
	email varchar(50),	-- 邮箱
	pwd	varchar(50), -- 密码
	name varchar(50), -- 管理员名称
	role_id varchar(36) -- 外键关联t_role表的id字段
);

alter table t_admin add constraint fk_admin_role_id foreign key(role_id) references t_role(id);

insert into t_admin values('06dec3adcc9e464aadacb8b432bc5450', '12345678900', '123@qq.com', 'Qpf0SxOVUjUkWySXOZ16kw==', 'superAdmin', 'b07db0289b5344cf911723bd9e6e3832');

-- 2,创建经销商表t_agency

create table t_agency
(
	id varchar(36) primary key,-- 编号,UUID，主键
	name	varchar(50) unique,	-- 经销商名称，unique
	email	varchar(50) unique not null	,-- 邮箱，作为登录账号，unique, not null
	pwd	varchar(50) not null, -- 密码,md5加密，not null
	leader	varchar(20),-- 负责人姓名
	phone	varchar(11) unique not null	,-- 手机号,unique，not null
	tel	varchar(11)	,-- 固定电话
	address	varchar(100),-- 地址
	logo	varchar(500),-- 商标图片，default
	intro	varchar(500),-- 简介
	created_time datetime, -- 创建时间
	checked_status tinyint, -- 审核状态，默认为0,审核后为1
	role_id	varchar(36),-- 外键关联t_role表的id字段
	status tinyint -- 状态，激活1或冻结0
);

alter table t_agency add constraint fk_agency_role_id foreign key(role_id) references t_role(id);

-- 3,创建楼盘表t_buildings

create table t_buildings
(
	id	varchar(36)  primary key, -- 编号,UUID，主键
	name	varchar(50),	-- 楼盘名称
	area	varchar(50),	-- 所属区域
	address	varchar(100),	-- 地址
	floor_area	double,	-- 占地面积
	building_area	double,	-- 建筑面积
	house_type	varchar(20),	-- 房源类型，如商业，住宅
	building_type	varchar(20),	 -- 建筑类型，如塔楼，板楼
	longitude	double not null,	-- 经度，not null
	latitude	double not null,	-- 纬度,not null
	avg_price	double	not null, -- 楼盘均价，not null
	company	varchar(100),	-- 开发公司
	open_date	date, -- 开盘时间
	total_rooms	int	,-- 总套数
	reception_address	varchar(100) not null,-- 接待地址, not null
	tel	varchar(11) not null,	-- 楼盘售楼电话,not null
	green_ratio	double,	-- 绿化率
	plot_ratio	double,	-- 容积率
	property_company	varchar(100), -- 物业公司
	property_fee	double,	-- 物业费
	car_station	int,	-- 车位数
	traffic	text,-- 交通状况
	equipments	text, -- 周边配套
	logo	varchar(500) default '/buildings_logo.jpg', -- 楼盘封面，default
	intro	varchar(500), -- 简介
	created_time	datetime,	-- 创建时间
	agency_id	varchar(36),--  来源于t_agency表，外键字段
	status	tinyint	-- 状态，激活或冻结
);

alter table t_buildings add constraint fk_buildings_agency_id foreign key(agency_id) references  t_agency(id);

-- 4,创建楼盘图片表

create table t_buildings_img
(
	id varchar(36) primary key,
	img_path varchar(500) not null,
	img_des varchar(50),
	buildings_id varchar(36),-- 楼盘编号，外键字段，来源于t_buildings的id字段
	created_time datetime
);
alter table t_buildings_img add constraint fk_buildings_img_buildings_id foreign key(buildings_id) references  t_buildings(id);


-- 5,创建楼栋表t_building

create table t_building
(
	id	varchar(36) primary key, -- 编号,UUID，主键
	name	varchar(50),	-- 楼栋名称
	total_floor	int	not null,-- 总层数,not null
	total_lift	int	not null,-- 电梯数,not null
	floor_rooms	int	not null,-- 每层多少户,not null
	total_room	int	not null,-- 总户数,not null
	buildings_id	varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段
	created_time	datetime,	-- 创建时间
	status	tinyint,	-- 状态，激活或冻结
	room_status -- 是否已经生成房号。1：已生成，0：未生成
);
alter table t_building add constraint fk_t_building_buildings_id foreign key(buildings_id) references  t_buildings(id);

-- 6,创建户型表t_house

create table t_house
(
	id	varchar(36)	primary key,-- 编号,UUID，主键
	name varchar(50), -- 户型名称
	logo varchar(500), -- 户型图片，default
	intro varchar(500),-- 简介
	area double not null, -- 面积，not null
	unit_price	double not null,	-- 参考单价，not null
	buildings_id varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段
	created_time datetime,	-- 创建时间
	agency_id varchar(36),
	status	tinyint	-- 状态，激活或冻结
);
alter table t_house add constraint fk_t_house_buildings_id foreign key(buildings_id) references  t_buildings(id);
alter table t_house add constraint fk_t_house_agency_id foreign key(agency_id) references  t_agency(id);


-- 7,创建房号表t_room

create table t_room
(
	id varchar(36) primary key,-- 编号,UUID，主键
	house_id varchar(36) ,	-- 户型编号，外键字段，来源于t_house表的id字段
	building_id	varchar(36),	-- 楼栋编号，外键字段，来源于t_building表的id字段
	name varchar(50), -- 房号名称
	sale_status	varchar(20) not null -- 销售状态，not null，默认为待售中
);
alter table t_room add constraint fk_t_room_house_id foreign key(house_id) references  t_house(id);
alter table t_room add constraint fk_t_room_building_id foreign key(building_id) references  t_building(id);


-- 8,创建员工表t_employee

create table t_employee
(
	id	varchar(36) primary key,-- 员工编号,UUID，主键
	name	varchar(50),-- 员工名称
	email	varchar(50) unique , -- 邮箱，unique
	pwd	varchar(50) not null, -- 密码,自动生成，使用默认密码not null
	phone	varchar(11) unique not null,-- 手机号,用于登录账号，unique，not null
	qq	varchar(20),-- qq号
	wechat	varchar(50),-- 微信号
	gender	varchar(2),-- 性别
	exp	varchar(50),-- 工作经验描述
	des	varchar(100),-- 最多50个字的个人说明
	address	varchar(100),-- 地址
	basic_salary	double not null,-- 基本工资，not null
	headicon	varchar(500) default 'logo.jpg', -- 头像，default
	intro	varchar(500),-- 简介
	agency_id	varchar(36),-- 员工所属经销商,外键字段，来源于t_angency的id字段
	buildings_id	varchar(36),-- 负责的楼盘，外键字段，来源于t_buildings的id字段
	created_time	datetime,-- 创建时间
	status	tinyint -- 状态，激活或冻结
);
alter table t_employee add constraint fk_t_employee_agency_id foreign key(agency_id) references  t_agency(id);
alter table t_employee add constraint fk_t_employee_buildings_id foreign key(buildings_id) references  t_buildings(id);

-- 9,创建绩效表t_mission

create table t_mission
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	quantity	int	,-- 员工任务量
	monthes	 varchar(50), -- 月份
	emp_id	varchar(36), -- 员工编号，外键字段，来源于t_employee表的id字段
	bonus_percent	double, -- 销售提成百分比
	agency_id varchar(36)
);
alter table t_mission add constraint fk_t_mission_emp_id foreign key(emp_id) references  t_employee(id);
alter table t_mission add constraint fk_t_mission_agency_id foreign key(agency_id) references  t_agency(id);

-- 10,创建活动表t_activity

create table t_activity
(
	id	varchar(36) primary key, -- 编号,UUID，主键
	title	varchar(50)	not null, -- 活动标题,not null
	start_time	datetime, -- 开始时间
	end_time	datetime,-- 结束时间
	address	varchar(100),-- 活动地址
	content	text, -- 活动内容
	logo	varchar(500), -- 活动图片
	buildings_id	varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段，如果此字段为空，则表示是由平台管理员发布的活动
	agency_id varchar(36), -- 经销商的id
	status tinyint
);
alter table t_activity add constraint fk_t_activity_buildings_id foreign key(buildings_id) references  t_buildings(id);
alter table t_activity add constraint fk_t_activity_agency_id foreign key(agency_id) references  t_agency(id);

-- 11,创建用户表t_user

create table t_user
(
	id	varchar(36)	primary key,-- 编号,UUID，主键
	email	varchar(50)	not null, -- 用户邮箱,not null
	phone	varchar(11) unique not null, -- 手机号,unique,not null
	pwd	varchar(50) not null, -- 密码,md5加密，not null
	qq	varchar(20),	-- qq号
	wechat	varchar(50),	-- 微信号
	gender	varchar(2),	-- 性别
	birthday	date,	-- 生日
	nickname	varchar(50),	-- 昵称
	name	varchar(20),	-- 真实姓名
	headicon	varchar(500) default 'logo.jpg',	-- 用户头像，default
	role_id	varchar(36),	-- 外键关联t_role表的id字段
	sataus tinyint
);
alter table t_user add constraint fk_t_user_role_id foreign key(role_id) references  t_role(id);


-- 12,创建预约表t_appointment

create table t_appointment
(
	id	varchar(36)	primary key,-- 编号,UUID，主键
	emp_id	varchar(36),	-- 员工编号，外键字段，来源于t_employee表的id字段
	user_id	varchar(36),	-- 用户编号，外键字段，来源于t_user表的id字段
	agency_id	varchar(36),	-- 经销商编号，外键字段
	app_arrive_time	datetime,	-- 预约看房时间
	arrive_time	datetime,	-- 真实看房时间
	house_id	varchar(36),	-- 户型编号，外键字段，来源于t_house表的id字段
	app_status	varchar(20),-- 预约状态
	created_time	datetime, -- 创建时间
	status	tinyint-- 状态，激活或冻结
);
alter table t_appointment add constraint fk_t_appointment_emp_id foreign key(emp_id) references  t_employee(id);
alter table t_appointment add constraint fk_t_appointment_user_id foreign key(user_id) references  t_user(id);
alter table t_appointment add constraint fk_t_appointment_house_id foreign key(house_id) references  t_house(id);

-- 13,创建留言表t_message

create table t_message
(
	id	varchar(36) primary key,	-- 编号,UUID，主键
	content	text,	-- 留言内容
	buildings_id	varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段，如果此字段为空，则表示是由平台管理员发布的活动
	reply	text,	-- 回复内容
	leave_time	datetime,	-- 留言时间
	reply_time	datetime,	-- 回复时间
	user_id	varchar(36),	-- 用户编号，外键字段，来源于t_user表的id字段
	status	tinyint	-- 状态，激活或冻结
);
alter table t_message add constraint fk_t_message_buildings_id foreign key(buildings_id) references  t_buildings(id);
alter table t_message add constraint fk_t_message_user_id foreign key(user_id) references  t_user(id);


-- 14,创建评论表t_comment

create table t_comment
(
	id	varchar(36)	primary key,-- 编号,UUID，主键
	content	text,	-- 评价内容
	buildings_id	varchar(36),-- 楼盘编号，外键字段，来源于t_buildings的id字段，如果此字段为空，则表示是由平台管理员发布的活动
	comment_time	datetime,	-- 评价时间
	user_id	varchar(36),	-- 用户编号，外键字段，来源于t_user表的id字段
	status	tinyint	-- 状态，激活或冻结
);
alter table t_comment add constraint fk_t_comment_buildings_id foreign key(buildings_id) references  t_buildings(id);
alter table t_comment add constraint fk_t_comment_user_id foreign key(user_id) references  t_user(id);


-- 15,创建客户表

create table t_customer
(
	id	varchar(36) primary key,	-- 编号,UUID，主键
	name	text,	-- 姓名
	gender	varchar(2),	-- 性别
	birthday	date,	-- 生日
	identity_id	varchar(18),	-- 身份证号
	email	varchar(50) not null,-- 邮箱,not null
	phone	varchar(11)	 unique not null,-- 手机号，not null,unique
	address	varchar(100) not null,	-- 联系地址,not null
	customer_type	varchar(20),	-- 客户类型，如预约客户，意向客户，预定客户，购房客户
	together	varchar(100),	-- 共同购房人姓名，多个姓名用英文逗号隔开
	contract	varchar(500),	-- 电子版购房合同路径
	archives	varchar(500),	-- zip版电子档案路径
	created_time	datetime,	-- 创建时间
	emp_id	varchar(36),	-- 员工编号，外键字段
	agency_id	varchar(36)	,-- 经销商编号，外键字段
	status	tinyint-- 状态，激活或冻结
);
alter table t_customer add constraint fk_t_customer_emp_id foreign key(emp_id) references  t_employee(id);
alter table t_customer add constraint fk_t_customer_agency_id foreign key(agency_id) references  t_agency(id);


-- 16创建销售记录表

create table t_sale
(
	id	varchar(36) primary key,	-- 编号,UUID，主键
	customer_id	varchar(50),	-- 客户编号，外键字段，来源于t_customer表的id字段 
	sale_time	datetime,	-- 销售时间
	unit_price	double,	-- 销售单价
	room_id	varchar(36),	-- 房屋编号
	discount	double,	-- 销售折扣
	total_cost	double,	-- 销售总价
	emp_id	varchar(36),	-- 员工编号，外键字段，来源于t_employee表的id字段
	agency_id	varchar(36),	-- 经销商编号，外键字段
	created_time	datetime,	-- 创建时间
	status	varchar(2)	-- 状态，激活或冻结
);
alter table t_sale add constraint fk_t_sale_customer_id foreign key(customer_id) references  t_customer(id);
alter table t_sale add constraint fk_t_sale_room_id foreign key(room_id) references  t_room(id);
alter table t_sale add constraint fk_t_sale_emp_id foreign key(emp_id) references  t_employee(id);
alter table t_sale add constraint fk_t_sale_agency_id foreign key(agency_id) references  t_agency(id);

-- 17创建点赞表

create table t_like
(
	id	varchar(36) primary key, -- 编号,UUID，主键
	user_id	varchar(50), -- 客户编号，外键字段，来源于t_user表的id字段 
	buildings_id varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段
	created_time	datetime -- 点赞创建时间
);
alter table t_like add constraint fk_t_like_user_id foreign key(user_id) references  t_user(id);
alter table t_like add constraint fk_t_like_buildings_id foreign key(buildings_id) references  t_buildings(id);

-- 18创建历史记录表

create table t_history
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	user_id	varchar(50)	,-- 客户编号，外键字段，来源于t_user表的id字段 
	buildings_id	varchar(36),	-- 楼盘编号，外键字段，来源于t_buildings的id字段
	created_time	datetime	-- 创建时间
);
alter table t_history add constraint fk_t_history_user_id foreign key(user_id) references  t_user(id);
alter table t_history add constraint fk_t_history_buildings_id foreign key(buildings_id) references  t_buildings(id);


-- 19创建文章类别表

create table t_article_type
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	name	varchar(50) unique not null, -- 类别名称，uniquue,not null
	des	varchar(500),  -- 类别描述
	status tinyint
);

-- 20创建文章表

create table t_article
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	title	varchar(50)	not null,-- 文章标题,not null
	abstracts	varchar(100)not null,-- 	文章摘要,not null
	content	text not null,-- 	文章内容，not null
	logo	varchar(500),	-- 文章图片路径
	type_id	varchar(36),	-- 文章类别编号，外键字段
	created_time	datetime,	-- 创建时间
	status	varchar(2)	-- 状态，激活或冻结
);
alter table t_article add constraint fk_t_article_type_id foreign key(type_id) references  t_article_type(id);

-- 21创建广告表

create table t_ads
(
	id	varchar(36)	primary key,  -- 编号,UUID，主键
	title	varchar(50)	not null, -- 广告标题,not null
	content	varchar(50)	not null, -- 广告描述,not null
	logo	varchar(500),-- 广告图片路径
	ad_url	varchar(500), -- 广告URL路径，可链接到单独的广告页面
	show_status	tinyint,-- 是否显示
	show_order	int, -- 显示顺序，按照主页，详情页的从左到右，从上到下的顺序规定广告位置
	created_time datetime, -- 创建时间
	status	tinyint -- 状态，激活或冻结
);

-- 23创建权限表

create table t_permission
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	name	varchar(500)	not null,-- 权限名称,not null
	des	varchar(50)		not null,-- 权限描述,not null
	created_time	datetime,	-- 创建时间
	status	varchar(2)	-- 状态，激活或冻结
);

-- 24创建角色权限表

create table t_role_permission
(
	id	varchar(36)	primary key, -- 编号,UUID，主键
	role_id	varchar(500)	,-- 角色编号，外键字段，来源于t_role表的id字段
	permission_id	varchar(50),-- 权限编号，外键字段，来源于t_permission表的id字段
	created_time	datetime -- 创建时间
);
alter table t_role_permission add constraint fk_t_role_permission_role_id foreign key(role_id) references  t_role(id);
alter table t_role_permission add constraint fk_t_role_permission_permission_id foreign key(permission_id) references  t_permission(id);