/*
 Navicat Premium Dump SQL

 Source Server         : blog
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : customer

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 30/06/2026 09:33:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for applicant
-- ----------------------------
DROP TABLE IF EXISTS `applicant`;
CREATE TABLE `applicant`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint UNSIGNED NOT NULL COMMENT '关联客户ID',
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户名称',
  `customer_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户代码',
  `customer_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户编号',
  `applicant_name_cn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人中文名称',
  `applicant_name_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '申请人英文名称',
  `applicant_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人编号',
  `applicant_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '申请人类型',
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实体类型',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '中国' COMMENT '国籍',
  `id_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '证件类型',
  `id_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '证件号码',
  `fee_reduction_filing` tinyint NOT NULL DEFAULT 0 COMMENT '费减备案 0=否,1=是',
  `fee_reduction_start` date NULL DEFAULT NULL COMMENT '费减开始时间',
  `fee_reduction_end` date NULL DEFAULT NULL COMMENT '费减结束时间',
  `region_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '行政区划ID',
  `street` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '街道详细地址',
  `business_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经营地址',
  `address_en` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文地址',
  `zip_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮编',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `attorney_power_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '总委托书编号',
  `sync_date` date NULL DEFAULT NULL COMMENT '同步日期',
  `operator_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '业务人员ID',
  `applicant_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '备注',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 0=正常,1=删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `applicant_applicant_no_unique`(`applicant_no` ASC) USING BTREE,
  INDEX `applicant_customer_id_index`(`customer_id` ASC) USING BTREE,
  INDEX `applicant_applicant_name_cn_index`(`applicant_name_cn` ASC) USING BTREE,
  INDEX `applicant_region_id_index`(`region_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of applicant
-- ----------------------------
INSERT INTO `applicant` VALUES (1, 1, '测试客户', NULL, NULL, '张三', NULL, 'AP-20260629-45844', '个人', '大实体', '中国', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:21:12', NULL, '2026-06-29 16:21:12', 0);
INSERT INTO `applicant` VALUES (2, 1, '测试客户', NULL, NULL, '张三', NULL, 'AP-20260629-47896', '个人', '大实体', '中国', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:22:15', NULL, '2026-06-29 16:22:15', 0);

-- ----------------------------
-- Table structure for biz_file_description
-- ----------------------------
DROP TABLE IF EXISTS `biz_file_description`;
CREATE TABLE `biz_file_description`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目类型',
  `country_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国家/地区代码',
  `file_category_id` bigint UNSIGNED NOT NULL COMMENT '文件大类ID',
  `file_subcategory_id` bigint UNSIGNED NOT NULL COMMENT '文件小类ID',
  `file_name_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称模板',
  `file_code_rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件编号规则',
  `internal_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内部代码',
  `auth_role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '授权角色',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `biz_file_description_project_type_index`(`project_type` ASC) USING BTREE,
  INDEX `biz_file_description_country_code_index`(`country_code` ASC) USING BTREE,
  INDEX `biz_file_description_file_category_id_index`(`file_category_id` ASC) USING BTREE,
  INDEX `biz_file_description_file_subcategory_id_index`(`file_subcategory_id` ASC) USING BTREE,
  INDEX `biz_file_description_status_index`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_file_description
-- ----------------------------
INSERT INTO `biz_file_description` VALUES (5, '专利', 'US', 1, 3, '999', '99', '99', NULL, 1, 1, '2026-06-30 09:14:38', '2026-06-30 09:14:38', NULL);

-- ----------------------------
-- Table structure for biz_innovation_index
-- ----------------------------
DROP TABLE IF EXISTS `biz_innovation_index`;
CREATE TABLE `biz_innovation_index`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `index_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '指数名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `biz_innovation_index_status_index`(`status` ASC) USING BTREE,
  INDEX `biz_innovation_index_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_innovation_index
-- ----------------------------
INSERT INTO `biz_innovation_index` VALUES (1, 1, '企业创新指数', '衡量企业技术创新能力', 1, '2026-06-29 16:31:56', '2026-06-29 16:31:56', NULL);
INSERT INTO `biz_innovation_index` VALUES (2, 1, '的地区的', 'd去掉', 1, '2026-06-29 23:10:50', '2026-06-29 23:10:50', NULL);
INSERT INTO `biz_innovation_index` VALUES (3, 1, '的地区的', 'd去掉', 1, '2026-06-29 23:10:51', '2026-06-29 23:10:51', NULL);
INSERT INTO `biz_innovation_index` VALUES (4, 1, '的地区的', 'd去掉', 1, '2026-06-29 23:10:52', '2026-06-29 23:10:52', NULL);
INSERT INTO `biz_innovation_index` VALUES (5, 1, '1221', '1221', 1, '2026-06-30 09:24:47', '2026-06-30 09:24:47', NULL);
INSERT INTO `biz_innovation_index` VALUES (6, 1, '12', '1212', 1, '2026-06-30 09:32:42', '2026-06-30 09:32:42', NULL);

-- ----------------------------
-- Table structure for biz_price_index
-- ----------------------------
DROP TABLE IF EXISTS `biz_price_index`;
CREATE TABLE `biz_price_index`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `index_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '指数名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `biz_price_index_status_index`(`status` ASC) USING BTREE,
  INDEX `biz_price_index_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_price_index
-- ----------------------------
INSERT INTO `biz_price_index` VALUES (1, 1, '专利代理价格指数', '专利代理服务价格参考指数', 0, '2026-06-29 16:31:42', '2026-06-29 23:10:23', NULL);
INSERT INTO `biz_price_index` VALUES (2, 1, '1', NULL, 0, '2026-06-29 19:27:07', '2026-06-30 09:29:13', NULL);
INSERT INTO `biz_price_index` VALUES (3, 1, '1', NULL, 1, '2026-06-29 22:36:46', '2026-06-29 22:36:46', NULL);
INSERT INTO `biz_price_index` VALUES (4, 1, '1', '2', 0, '2026-06-29 23:06:09', '2026-06-29 23:10:38', NULL);

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for customer_addresses
-- ----------------------------
DROP TABLE IF EXISTS `customer_addresses`;
CREATE TABLE `customer_addresses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `nationality` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国籍',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '城市',
  `district` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '区县',
  `street_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '街道地址',
  `address_en` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文地址',
  `other_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '其他地址',
  `industrial_park` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '产业园区',
  `postal_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `company_website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司网站',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_addresses_nationality_index`(`nationality` ASC) USING BTREE,
  INDEX `customer_addresses_province_index`(`province` ASC) USING BTREE,
  INDEX `customer_addresses_city_index`(`city` ASC) USING BTREE,
  INDEX `customer_addresses_district_index`(`district` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_addresses
-- ----------------------------
INSERT INTO `customer_addresses` VALUES (13, '中国', '北京市', '市辖区', '门头沟区', '世纪大道100号环球金融中心', '100 Century Avenue, Pudong New Area, Shanghai', '60楼', '陆家嘴金融贸易区', '200120', 'https://www.example-shanghai.com', '2026-06-29 16:54:24', '2026-06-29 19:20:27');
INSERT INTO `customer_addresses` VALUES (14, '中国', '北京市', '北京市', '朝阳区', '建国门外大街1号国贸大厦', '1 Jianguomenwai Avenue, Chaoyang, Beijing', 'A座28层', '国贸CBD', '100004', 'https://www.example-beijing.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (15, '中国', '浙江省', '杭州市', '西湖区', '文三路398号东信大厦', '398 Wensan Road, Xihu District, Hangzhou', '15楼', '杭州高新技术产业开发区', '310012', 'https://www.example-hangzhou.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (16, '中国', '广东省', '深圳市', '南山区', '科技园南区高新南七道R2-B栋5楼', '5F, Building R2-B, Gaoxin South 7th Road, Science Park, Nanshan District, Shenzhen', 'B区', '深圳南山科技园', '518000', 'https://www.example-shenzhen.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (17, '中国', '广东省', '广州市', '黄埔区', '科学城科丰路88号A栋', '88 Kefeng Road, Science City, Building A, Huangpu District, Guangzhou', 'A栋', '广州科学城产业园', '510700', 'https://www.gz-mz.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (18, '中国', '广东省', '佛山市', '南海区', '桂城街道南海大道北XX号', 'XX, North Nanhai Avenue, Guicheng Street, Nanhai District, Foshan, Guangdong, China', '佛山某新材料研究院', '南海软件科技园', '528200', 'https://www.fs-mzxyjy.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (19, '中国', '广东省', '深圳市', '南山区', '科技园南区高新南七道R2-B栋5楼', '5F, Building R2-B, Gaoxin South 7th Road, Science Park, Nanshan District, Shenzhen', 'B区', '深圳南山科技园', '518000', 'https://www.example-shenzhen.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (20, '中国', '广东省', '广州市', '黄埔区', '科学城科丰路88号', '88 Kefeng Road, Science City, Huangpu District, Guangzhou', 'A栋', '广州科学城产业园', '510700', 'https://www.gz-mz.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (21, '中国', '广东省', '东莞市', '长安镇', '乌沙社区振安路12号', '12 Zhenan Road, Wusha Community, Changan Town, Dongguan', 'C座', '长安精密制造工业园', '523850', 'https://www.dg-mz.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (22, '中国', '广东省', '佛山市', '南海区', '狮山镇三环西路23号', '23 West Sanhuan Road, Shishan Town, Nanhai District, Foshan', '研发楼', '佛山南海大学城', '528225', 'https://www.fs-mz.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (23, '中国', '广东省', '珠海市', '金湾区', '三灶镇定湾七路28号', '28 Qiwan 7th Road, Sanzao Town, Jinwan District, Zhuhai', 'A区', '珠海航空产业园', '519040', 'https://www.zh-mz.com', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_addresses` VALUES (27, '中国', '四川省', '成都市', '武侯区', '天府大道中段688号天府软件园B区7栋', 'Building 7, Zone B, Tianfu Software Park', NULL, 'park-1', '610041', 'https://www.chengdu-tech.com', '2026-06-29 20:03:41', '2026-06-29 20:03:41');
INSERT INTO `customer_addresses` VALUES (28, '中国', '内蒙古自治区', '通辽市', '开鲁县', '四川省成都东软学院', 'xhhjhiik', '成都西北学院', 'park-1', '000', 'http://baidu.com', '2026-06-29 20:11:40', '2026-06-29 20:11:40');
INSERT INTO `customer_addresses` VALUES (29, '中国', '四川省', '成都市', '锦江区', '四川省成都东软学院', 'xhhjhiik', '成都西北学院', 'park-1', '000', 'http://baidu.com', '2026-06-29 22:53:00', '2026-06-29 22:53:00');
INSERT INTO `customer_addresses` VALUES (30, '中国', NULL, NULL, NULL, '世纪大道100号环球金融中心', '100 Century Avenue, Pudong New Area, Shanghai', '60楼', NULL, '200120', 'https://www.example-shanghai.com', '2026-06-29 23:27:40', '2026-06-29 23:27:40');
INSERT INTO `customer_addresses` VALUES (31, '中国', '新疆维吾尔自治区', '乌鲁木齐市', '天山区', '世纪大道100号环球金融中心', '100 Century Avenue, Pudong New Area, Shanghai', '60楼', 'park-1', '200120', 'https://www.example-shanghai.com', '2026-06-30 09:12:54', '2026-06-30 09:12:54');

-- ----------------------------
-- Table structure for customer_basics
-- ----------------------------
DROP TABLE IF EXISTS `customer_basics`;
CREATE TABLE `customer_basics`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户编号',
  `innovation_subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创新主体',
  `innovation_subject_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创新主体英文名称',
  `credit_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '信用代码',
  `legal_representative` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '法定代表人',
  `company_contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司负责人',
  `customer_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户等级',
  `customer_scale` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户规模',
  `creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `price_index` decimal(5, 2) NULL DEFAULT NULL COMMENT '价格指数',
  `innovation_index` decimal(5, 2) NULL DEFAULT NULL COMMENT '创新指数',
  `contract_count` int UNSIGNED NULL DEFAULT 0 COMMENT '合同数量',
  `latest_contract_date` date NULL DEFAULT NULL COMMENT '最新合同日期',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '客户资料备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_basics_customer_no_index`(`customer_no` ASC) USING BTREE,
  INDEX `customer_basics_innovation_subject_index`(`innovation_subject` ASC) USING BTREE,
  INDEX `customer_basics_credit_code_index`(`credit_code` ASC) USING BTREE,
  INDEX `customer_basics_customer_level_index`(`customer_level` ASC) USING BTREE,
  INDEX `customer_basics_customer_scale_index`(`customer_scale` ASC) USING BTREE,
  INDEX `customer_basics_creator_index`(`creator` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_basics
-- ----------------------------
INSERT INTO `customer_basics` VALUES (11, 'C20260002', '广州某某创新研究院', 'Guangzhou XXX Innovation Research Institute', '91440100MA5DQWXY34', '王五', '赵六', 'B', '小微企业', 'GYZ', 70.00, 88.50, 1, '2026-05-20', '测试客户2', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (12, 'C20260003', '北京某某数据服务有限公司', 'Beijing XXX Data Service Co., Ltd.', '91110000MA5DQWXY56', '孙七', '周八', 'C', '大型企业', 'GYZ', 95.00, 99.50, 10, '2026-06-15', '测试客户3', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (13, 'C2026060004', '北京某某科技有限公司', 'Beijing XXX Technology Co., Ltd.', '91110100MA5CXTYU12', '赵一', '钱二', 'A', '规模以上企业', 'admin', 0.00, 0.00, 0, '2026-05-10', '重点客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (14, 'C2026060005', '杭州某某网络技术有限公司', 'Hangzhou XXX Network Technology Co., Ltd.', '91330100MA5CXTZV34', '孙二', '李三', 'B', '科技型中小企业', 'admin', 0.00, 0.00, 0, '2026-04-20', '优质客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (15, 'C20260003', '深圳某某创新科技有限公司', 'Shenzhen XXX Innovation Technology Co., Ltd.', '91440300MA5DQPXY67', '李四', '张经理', 'A', '科技型中小企业', 'admin', 85.00, 92.00, 2, '2026-06-15', '重点客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (16, 'C20260004', '广州某智造科技股份有限公司', 'Guangzhou MZ Zhizao Technology Co., Ltd.', '91440101MA5CXTYU89', '王二', '陈总', 'A', '规模以上企业', 'admin', 88.00, 95.00, 5, '2026-06-20', '重点扶持企业', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (17, 'C20260005', '东莞某精密机械有限公司', 'Dongguan MZ Precision Machinery Co., Ltd.', '91441900MA5CYHZV12', '赵六', '刘经理', 'B', '规模以上企业', 'admin', 72.00, 80.00, 3, '2026-06-10', '优质客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (18, 'C20260006', '佛山某新材料研究院有限公司', 'Foshan MZ New Materials Research Institute Co., Ltd.', '91440605MA5CZABW34', '孙七', '周高工', 'A', '科技型中小企业', 'admin', 90.00, 97.00, 4, '2026-06-18', '战略合作客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (19, 'C20260007', '珠海某海洋工程装备有限公司', 'Zhuhai MZ Ocean Engineering Equipment Co., Ltd.', '91440400MA5CZBCY56', '钱八', '郑总工', 'B', '规模以上企业', 'admin', 75.00, 82.00, 2, '2026-06-05', '潜力客户', '2026-06-29 16:54:24', '2026-06-29 16:54:24');
INSERT INTO `customer_basics` VALUES (20, NULL, '111', 'Jensen', '111', 'PZJ', 'PZJ', 'A', 'large', NULL, 2.00, 1.00, 0, NULL, 'PZJ谢谢谢', '2026-06-29 18:27:00', '2026-06-29 19:20:27');
INSERT INTO `customer_basics` VALUES (24, NULL, '成都科技有限公司', 'Chengdu Technology Co., Ltd.', '91510100MA6ABCD123', '张三', '李四', 'A', '中型企业', NULL, 2.00, 3.00, 0, NULL, '完整测试客户数据', '2026-06-29 20:03:39', '2026-06-29 20:03:39');
INSERT INTO `customer_basics` VALUES (25, NULL, '测试2', 'Jensen', '1234567', 'PZJ', 'PZJ', 'A', 'large', NULL, 1.00, 1.00, 0, NULL, 'PZJ', '2026-06-29 20:11:39', '2026-06-29 20:11:39');
INSERT INTO `customer_basics` VALUES (26, NULL, '测试3', 'Jensen', '123456', '裴振江', '裴振江', 'A', 'large', NULL, 1.00, 2.00, 0, NULL, NULL, '2026-06-29 22:52:59', '2026-06-29 22:52:59');
INSERT INTO `customer_basics` VALUES (27, NULL, 'wdw', 'wd', 'dwd', 'dwd', 'wdd', 'D', 'medium', NULL, 3.00, 2.00, 0, NULL, 'dwdwd', '2026-06-29 22:53:37', '2026-06-29 22:53:37');
INSERT INTO `customer_basics` VALUES (28, NULL, 'wdw', 'wd', 'dwd', 'dwd', 'wdd', 'D', 'medium', NULL, 3.00, 2.00, 0, NULL, 'dwdwd', '2026-06-29 22:53:53', '2026-06-29 22:53:53');
INSERT INTO `customer_basics` VALUES (29, NULL, '1', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2026-06-29 23:27:39', '2026-06-29 23:27:39');
INSERT INTO `customer_basics` VALUES (30, NULL, '测试4', 'Jenden', '123', 'PZJ', 'PZJ', 'A', 'large', NULL, 1.00, 4.00, 0, NULL, '测试备注', '2026-06-30 09:12:54', '2026-06-30 09:15:11');
INSERT INTO `customer_basics` VALUES (31, NULL, '99', NULL, '99', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2026-06-30 09:15:54', '2026-06-30 09:15:54');

-- ----------------------------
-- Table structure for customer_business
-- ----------------------------
DROP TABLE IF EXISTS `customer_business`;
CREATE TABLE `customer_business`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `economy_category_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '国民经济分类编码',
  `basic_id` bigint UNSIGNED NOT NULL COMMENT '关联客户基本信息表ID',
  `established_time` date NULL DEFAULT NULL COMMENT '成立时间',
  `employee_count` int UNSIGNED NULL DEFAULT NULL COMMENT '员工人数',
  `registered_capital` decimal(15, 2) NULL DEFAULT NULL COMMENT '注册资本',
  `main_business_product` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '主营业务产品',
  `rd_personnel` int UNSIGNED NULL DEFAULT NULL COMMENT '研发人数',
  `phd_count` int UNSIGNED NULL DEFAULT NULL COMMENT '博士人数',
  `senior_engineer_count` int UNSIGNED NULL DEFAULT NULL COMMENT '高工人数',
  `master_count` int UNSIGNED NULL DEFAULT NULL COMMENT '硕士人数',
  `intermediate_engineer_count` int UNSIGNED NULL DEFAULT NULL COMMENT '中工人数',
  `bachelor_count` int UNSIGNED NULL DEFAULT NULL COMMENT '本科人数',
  `overseas_returnee_count` int UNSIGNED NULL DEFAULT NULL COMMENT '海归人数',
  `business_scope` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '营业范围',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `economy_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济行业分类-门类',
  `economy_large_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济行业分类-大类',
  `economy_mid_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济行业分类-中类',
  `economy_sub_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济行业分类-小类',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_business_basic_id_index`(`basic_id` ASC) USING BTREE,
  INDEX `customer_business_economy_category_code_index`(`economy_category_code` ASC) USING BTREE,
  INDEX `customer_business_established_time_index`(`established_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_business
-- ----------------------------
INSERT INTO `customer_business` VALUES (1, 'M73', 1, '2015-06-01', 100, 5000000.00, '软件产品', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '软件开发', '2026-06-29 16:33:35', '2026-06-29 16:33:35', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (2, 'M73', 1, '2015-06-01', 100, 5000000.00, '软件产品', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '软件开发', '2026-06-29 16:48:35', '2026-06-29 16:48:35', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (3, 'A.农、林、牧、渔业', 20, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NULL, '2026-06-29 18:27:01', '2026-06-29 18:27:01', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (6, 'I6513', 24, '2018-06-15', 120, 5000.00, '软件开发与技术服务', 35, 3, 8, 12, 20, 45, 2, '软件开发;信息技术咨询服务;数据处理和存储服务;集成电路设计;数字内容服务', '2026-06-29 20:03:47', '2026-06-29 20:03:47', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (7, 'B.采矿业', 25, '2026-06-01', 24, 28.00, '测试产品1', 4, 13, 11, 6, 5, 4, 5, '测试', '2026-06-29 20:11:43', '2026-06-29 20:14:10', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (8, 'B', 28, '2026-06-22', 47, 41.00, '测试产品3', 5, 17, 25, 11, 13, 17, 6, NULL, '2026-06-29 22:53:03', '2026-06-29 23:22:10', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (9, 'A', 29, NULL, 3, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, NULL, '2026-06-29 23:27:42', '2026-06-29 23:27:42', NULL, NULL, NULL, NULL);
INSERT INTO `customer_business` VALUES (10, 'A', 30, '2026-05-31', 100, 100.00, '测试产品', 20, 40, 20, 30, 40, 20, 30, '测试', '2026-06-30 09:12:56', '2026-06-30 09:15:14', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for customer_contacts
-- ----------------------------
DROP TABLE IF EXISTS `customer_contacts`;
CREATE TABLE `customer_contacts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `innovation_entity_id` bigint UNSIGNED NOT NULL COMMENT '创新主体，关联 innovation_entities 表',
  `contact_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人类型',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `landline` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '座机',
  `is_active` tinyint(1) NOT NULL COMMENT '是否在职',
  `position` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职位',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `sales_rep_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '业务人员，关联 users 表',
  `sales_assistant_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '业务助理，关联 users 表',
  `tech_lead_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '技术主导部门',
  `tech_lead_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '技术主导，关联 users 表',
  `work_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '工作地址',
  `notes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '备注',
  `created_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '创建人ID，关联 users 表',
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID，关联 users 表',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_contacts_innovation_entity_id_index`(`innovation_entity_id` ASC) USING BTREE,
  INDEX `customer_contacts_contact_type_index`(`contact_type` ASC) USING BTREE,
  INDEX `customer_contacts_name_index`(`name` ASC) USING BTREE,
  INDEX `customer_contacts_phone_index`(`phone` ASC) USING BTREE,
  INDEX `customer_contacts_sales_rep_id_index`(`sales_rep_id` ASC) USING BTREE,
  INDEX `customer_contacts_sales_assistant_id_index`(`sales_assistant_id` ASC) USING BTREE,
  INDEX `customer_contacts_tech_lead_id_index`(`tech_lead_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_contacts
-- ----------------------------

-- ----------------------------
-- Table structure for customer_enterprise_investments
-- ----------------------------
DROP TABLE IF EXISTS `customer_enterprise_investments`;
CREATE TABLE `customer_enterprise_investments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint UNSIGNED NOT NULL COMMENT '客户ID',
  `year` smallint UNSIGNED NOT NULL COMMENT '年份，如2025',
  `has_audit_report` tinyint(1) NULL DEFAULT NULL COMMENT '是否有审计报告',
  `has_imported_equipment` tinyint(1) NULL DEFAULT NULL COMMENT '是否有进口设备',
  `has_investment_filing` tinyint(1) NULL DEFAULT NULL COMMENT '是否有投资备案表',
  `rd_equipment_original_value` decimal(15, 2) NULL DEFAULT NULL COMMENT '研发设备原值',
  `asset_liability_ratio` decimal(5, 2) NULL DEFAULT NULL COMMENT '资产负债率(%)',
  `fixed_asset_investment` decimal(15, 2) NULL DEFAULT NULL COMMENT '固定资产投资',
  `equipment_investment` decimal(15, 2) NULL DEFAULT NULL COMMENT '设备投资',
  `smart_equipment_investment` decimal(15, 2) NULL DEFAULT NULL COMMENT '智能设备投资',
  `rd_equipment_investment` decimal(15, 2) NULL DEFAULT NULL COMMENT '研发设备投资',
  `informatization_investment` decimal(15, 2) NULL DEFAULT NULL COMMENT '信息化投资',
  `filing_amount` decimal(15, 2) NULL DEFAULT NULL COMMENT '备案金额',
  `filing_start_date` date NULL DEFAULT NULL COMMENT '备案开始日期',
  `filing_end_date` date NULL DEFAULT NULL COMMENT '备案结束日期',
  `created_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `customer_enterprise_investments_customer_id_year_unique`(`customer_id` ASC, `year` ASC) USING BTREE,
  INDEX `customer_enterprise_investments_year_index`(`year` ASC) USING BTREE,
  INDEX `customer_enterprise_investments_customer_id_index`(`customer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_enterprise_investments
-- ----------------------------
INSERT INTO `customer_enterprise_investments` VALUES (1, 25, 2025, 1, 0, 1, 1111111.00, 55.00, 145.00, 2323.00, 222.00, 6589.00, 4321.00, 98432.00, '2024-12-04', '2025-01-30', NULL, NULL, '2026-06-29 17:14:04', '2026-06-29 20:14:14');
INSERT INTO `customer_enterprise_investments` VALUES (5, 25, 2023, 1, 0, 1, 500000.00, 35.50, 2000000.00, 800000.00, 300000.00, 500000.00, 200000.00, 3000000.00, '2023-01-14', '2023-12-30', NULL, NULL, '2026-06-29 20:04:07', '2026-06-29 20:14:14');
INSERT INTO `customer_enterprise_investments` VALUES (6, 25, 2024, 0, 1, 1, 1111111.00, 32.80, 2500000.00, 3333.00, 450000.00, 650000.00, 300000.00, 4000000.00, '2024-02-14', '2024-03-31', NULL, NULL, '2026-06-29 20:04:07', '2026-06-29 20:14:14');
INSERT INTO `customer_enterprise_investments` VALUES (7, 24, 2025, 1, 1, 1, 800000.00, 28.50, 3200000.00, 1200000.00, 600000.00, 800000.00, 500000.00, 5500000.00, '2025-01-10', '2025-12-31', NULL, NULL, '2026-06-29 20:04:08', '2026-06-29 20:04:08');
INSERT INTO `customer_enterprise_investments` VALUES (8, 29, 2025, 0, 1, NULL, NULL, 1.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 23:35:43', '2026-06-29 23:35:43');
INSERT INTO `customer_enterprise_investments` VALUES (9, 30, 2025, 1, 0, 0, 11.00, 11.00, 11.00, 11.00, 11.00, 11.00, 111.00, 111.00, '2026-06-03', '2026-07-31', NULL, NULL, '2026-06-30 09:15:17', '2026-06-30 09:15:17');

-- ----------------------------
-- Table structure for customer_enterprises
-- ----------------------------
DROP TABLE IF EXISTS `customer_enterprises`;
CREATE TABLE `customer_enterprises`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `company_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '企业类型',
  `registered_capital` decimal(15, 2) NULL DEFAULT NULL COMMENT '注册资本',
  `established_date` date NULL DEFAULT NULL COMMENT '成立日期',
  `industry_category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '行业分类',
  `main_business` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '主营业务',
  `company_website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司网址',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_enterprises_company_type_index`(`company_type` ASC) USING BTREE,
  INDEX `customer_enterprises_industry_category_index`(`industry_category` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_enterprises
-- ----------------------------
INSERT INTO `customer_enterprises` VALUES (1, '有限责任公司', 10000000.00, '2010-06-15', '科学研究和技术服务业', '软件开发、技术咨询服务', 'https://www.example.com', '2026-06-29 16:33:20', '2026-06-29 16:33:20');
INSERT INTO `customer_enterprises` VALUES (2, '有限责任公司', 10000000.00, '2010-06-15', '科学研究和技术服务业', '软件开发、技术咨询服务', 'https://www.example.com', '2026-06-29 16:39:38', '2026-06-29 16:39:38');
INSERT INTO `customer_enterprises` VALUES (3, '有限责任公司', 10000000.00, '2010-06-15', '科学研究和技术服务业', '软件开发、技术咨询服务', 'https://www.example.com', '2026-06-29 16:48:26', '2026-06-29 16:48:26');
INSERT INTO `customer_enterprises` VALUES (7, '有限责任公司', 5000.00, '2018-06-15', '信息技术', '软件开发与技术服务', 'https://www.chengdu-tech.com', '2026-06-29 20:03:46', '2026-06-29 20:03:46');
INSERT INTO `customer_enterprises` VALUES (8, '国有企业', 1111111111.00, '2026-06-01', '农、林、牧、渔业', '测试2', 'http://xxx.com', '2026-06-29 20:11:42', '2026-06-29 20:11:42');
INSERT INTO `customer_enterprises` VALUES (9, '国有企业', 100.00, '2026-06-07', '农、林、牧、渔业', '测试3', 'Http://xxx.com', '2026-06-29 22:53:02', '2026-06-29 22:53:02');
INSERT INTO `customer_enterprises` VALUES (10, '国有企业', NULL, NULL, '农、林、牧、渔业', NULL, NULL, '2026-06-29 23:27:41', '2026-06-29 23:27:41');
INSERT INTO `customer_enterprises` VALUES (11, '国有企业', 120.00, '2026-06-01', '农、林、牧、渔业', '测试业务', 'http://xxx.com', '2026-06-30 09:12:56', '2026-06-30 09:12:56');

-- ----------------------------
-- Table structure for customer_fees
-- ----------------------------
DROP TABLE IF EXISTS `customer_fees`;
CREATE TABLE `customer_fees`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开户名称',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开户银行',
  `bank_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '银行账号',
  `invoice_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开票地址',
  `invoice_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开票电话',
  `taxpayer_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '一般纳税人',
  `billing_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账单地址',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `invoice_credit_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开票信用代码',
  `is_general_taxpayer` tinyint(1) NULL DEFAULT 0 COMMENT '是否一般纳税人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_fees_account_name_index`(`account_name` ASC) USING BTREE,
  INDEX `customer_fees_bank_account_index`(`bank_account` ASC) USING BTREE,
  INDEX `customer_fees_taxpayer_type_index`(`taxpayer_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_fees
-- ----------------------------
INSERT INTO `customer_fees` VALUES (12, '上海某某金融信息服务有限公司', '招商银行上海浦东支行', '6214830123456789', '上海市浦东新区世纪大道100号环球金融中心60楼', '021-68881234', '小规模纳税人', '上海市浦东新区世纪大道100号环球金融中心60楼', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (13, '北京某某科技有限公司', '中国银行北京朝阳支行', '621660010001234567', '北京市朝阳区建国门外大街1号国贸大厦A座28层', '010-65001234', '一般纳税人', '北京市朝阳区建国门外大街1号国贸大厦A座28层财务中心', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (14, '杭州某某网络技术有限公司', '浙江杭州联合农村商业银行', '201000123456789', '浙江省杭州市西湖区文三路398号东信大厦15楼', '0571-88001234', '小规模纳税人', '浙江省杭州市西湖区文三路398号东信大厦15楼', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (15, '深圳某某创新科技有限公司', '中国银行深圳南山支行', '6217858000012345678', '广东省深圳市南山区科技园南区高新南七道R2-B栋5楼', '0755-26781234', '一般纳税人', '广东省深圳市南山区科技园南区高新南七道R2-B栋5楼', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (16, '广州某智造科技股份有限公司', '工商银行广州科学城支行', '6222083602012345679', '广州市黄埔区科学城科丰路88号A栋', '020-82081234', '一般纳税人', '广州市黄埔区科学城科丰路88号A栋', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (17, '佛山某新材料研究院有限公司', '中国建设银行佛山南海支行', '44050166789900001234', '广东省佛山市南海区桂城街道南海大道北XX号', '0757-86712345', '一般纳税人', '广东省佛山市南海区桂城街道南海大道北XX号', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (18, '广州某智造科技股份有限公司', '工商银行广州科学城支行', '6222083602012345679', '广州市黄埔区科学城科丰路88号A栋', '020-82081234', '一般纳税人', '广州市黄埔区科学城科丰路88号A栋', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (19, '东莞某精密机械有限公司', '建设银行东莞长安支行', '6217003240012345670', '广东省东莞市长安镇乌沙社区振安路12号C座', '0769-85341234', '一般纳税人', '广东省东莞市长安镇乌沙社区振安路12号C座', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (20, '佛山某新材料研究院有限公司', '农业银行佛山狮山支行', '6228481234567890123', '广东省佛山市南海区狮山镇三环西路23号研发楼', '0757-86601234', '一般纳税人', '广东省佛山市南海区狮山镇三环西路23号研发楼', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (21, '珠海某海洋工程装备有限公司', '中国银行珠海金湾支行', '6217858000023456789', '广东省珠海市金湾区三灶镇定湾七路28号A区', '0756-7781234', '小规模纳税人', '广东省珠海市金湾区三灶镇定湾七路28号A区', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL, 0);
INSERT INTO `customer_fees` VALUES (22, '振江裴', '四川农业银行', '123456789010', NULL, '17726361083', '小规模纳税人', '四川省成都东软学院', '2026-06-29 18:27:01', '2026-06-29 19:20:28', NULL, 0);
INSERT INTO `customer_fees` VALUES (26, '成都科技有限公司', '中国工商银行成都高新支行', '4402012345678901234', '四川省成都市武侯区天府大道中段688号', '028-61234567', '一般纳税人', '四川省成都市武侯区天府大道中段688号天府软件园B区7栋', '2026-06-29 20:03:43', '2026-06-29 20:03:43', NULL, 0);
INSERT INTO `customer_fees` VALUES (27, '振江裴', '四川农业银行', '123456789010', '四川省成都东软学院', '17726361083', '小规模纳税人', '四川省成都东软学院', '2026-06-29 20:11:41', '2026-06-29 20:11:41', NULL, 0);
INSERT INTO `customer_fees` VALUES (28, '振江裴', '四川农业银行', '123456789010', '四川省成都东软学院', '17726361083', '小规模纳税人', '四川省成都东软学院', '2026-06-29 22:53:01', '2026-06-29 22:53:01', '12324', 0);
INSERT INTO `customer_fees` VALUES (29, NULL, NULL, NULL, NULL, NULL, '小规模纳税人', NULL, '2026-06-29 22:53:38', '2026-06-29 22:53:38', NULL, 0);
INSERT INTO `customer_fees` VALUES (30, '11', '111', '111', NULL, '11', '小规模纳税人', '1111', '2026-06-29 22:53:54', '2026-06-29 23:22:09', '111', 0);
INSERT INTO `customer_fees` VALUES (31, '11', NULL, NULL, '1111', '11', NULL, NULL, '2026-06-29 23:27:40', '2026-06-29 23:27:40', NULL, 0);
INSERT INTO `customer_fees` VALUES (32, '振江裴', '四川农业银行', '123456789010', '四川省成都东软学院', '17726361083', '一般纳税人', '四川省成都东软学院', '2026-06-30 09:12:55', '2026-06-30 09:12:55', '123', 0);

-- ----------------------------
-- Table structure for customer_files
-- ----------------------------
DROP TABLE IF EXISTS `customer_files`;
CREATE TABLE `customer_files`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_id` bigint UNSIGNED NULL DEFAULT NULL,
  `customer_id` bigint UNSIGNED NULL DEFAULT NULL,
  `salesperson_id` bigint UNSIGNED NOT NULL COMMENT '业务人员，关联 users 表',
  `remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '文件备注信息',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件存储路径或URL（如 OSS 地址）',
  `file_size` int UNSIGNED NULL DEFAULT NULL COMMENT '文件大小，单位：字节 (Bytes)',
  `created_by` bigint UNSIGNED NOT NULL COMMENT '上传人/创建人ID，关联 users 表',
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '最后修改人ID，关联 users 表',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '软删除，防止误删',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_files_category_id_index`(`category_id` ASC) USING BTREE,
  INDEX `customer_files_customer_id_index`(`customer_id` ASC) USING BTREE,
  INDEX `customer_files_salesperson_id_index`(`salesperson_id` ASC) USING BTREE,
  INDEX `customer_files_created_by_index`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_files
-- ----------------------------
INSERT INTO `customer_files` VALUES (1, NULL, NULL, 1, NULL, 'http://fmy-base.oss-cn-chengdu.aliyuncs.com/uploads/6a4261d361e2f_1782735315.jpg?Expires=1782738915&OSSAccessKeyId=LTAI5t74GC388hyoSC634cXG&Signature=Wo5eb84C0PCUYBkcEhQne1NTfZU%3D', 203414, 1, 1, 'com.xingin.xhs_20260201151245.jpg', '2026-06-29 20:15:15', '2026-06-29 23:02:27', '2026-06-29 23:02:27');
INSERT INTO `customer_files` VALUES (2, NULL, NULL, 1, NULL, 'uploads/6a427ae320186_1782741731.png', 85067, 1, 1, '屏幕截图 2026-05-09 213900.png', '2026-06-29 22:02:11', '2026-06-29 22:35:57', '2026-06-29 22:35:57');
INSERT INTO `customer_files` VALUES (3, 5, 11, 3, '1', 'customer_files/6a427b5457f7c_1782741844.jpg', 679331, 3, 3, '4037DDEAFFA693887CD9D19C0D1_17C28C7C_A5DA3.jpg', '2026-06-29 22:04:04', '2026-06-29 22:04:04', NULL);
INSERT INTO `customer_files` VALUES (4, 5, 12, 3, 'e2', 'customer_files/6a4289205ea83_1782745376.txt', 12282, 3, 3, '核对结果.txt', '2026-06-29 23:02:56', '2026-06-29 23:02:56', NULL);
INSERT INTO `customer_files` VALUES (5, 1, 1001, 1, '合同扫描件', 'customer_files/6a428cc6a2d8f_1782746310.jpg', 203414, 1, 1, 'com.xingin.xhs_20260201151245.jpg', '2026-06-29 23:18:30', '2026-06-29 23:18:30', NULL);
INSERT INTO `customer_files` VALUES (6, 8, 12, 3, '', 'customer_files/6a4319e3d1ef3_1782782435.jpg', 301679, 3, 3, 'FF4BCFDE1C22C17F3F14B35E24A_18BB3A57_49A6F.jpg', '2026-06-30 09:20:36', '2026-06-30 09:20:36', NULL);

-- ----------------------------
-- Table structure for customer_financials
-- ----------------------------
DROP TABLE IF EXISTS `customer_financials`;
CREATE TABLE `customer_financials`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `basic_id` bigint UNSIGNED NOT NULL COMMENT '关联客户基本信息表ID',
  `sales_2025` decimal(15, 4) NULL DEFAULT NULL COMMENT '2025年度销售额(万元)',
  `sales_2024` decimal(15, 4) NULL DEFAULT NULL COMMENT '2024年度销售额(万元)',
  `sales_2023` decimal(15, 4) NULL DEFAULT NULL COMMENT '2023年度销售额(万元)',
  `rd_fee_2025` decimal(15, 4) NULL DEFAULT NULL COMMENT '2025年度研发费用(万元)',
  `rd_fee_2024` decimal(15, 4) NULL DEFAULT NULL COMMENT '2024年度研发费用(万元)',
  `rd_fee_2023` decimal(15, 4) NULL DEFAULT NULL COMMENT '2023年度研发费用(万元)',
  `loan_2025` decimal(15, 4) NULL DEFAULT NULL COMMENT '2025年度贷款(万元)',
  `loan_2024` decimal(15, 4) NULL DEFAULT NULL COMMENT '2024年度贷款(万元)',
  `loan_2023` decimal(15, 4) NULL DEFAULT NULL COMMENT '2023年度贷款(万元)',
  `creator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `customer_financials_basic_id_unique`(`basic_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_financials
-- ----------------------------
INSERT INTO `customer_financials` VALUES (2, 20, 11111111111.0000, 222.0000, 222.0000, 222.0000, 222.0000, 222.0000, 222.0000, 222.0000, 222.0000, NULL, '2026-06-29 18:28:14', '2026-06-29 19:20:29');
INSERT INTO `customer_financials` VALUES (3, 11, 5500.0000, 4300.0000, 3900.0000, 850.0000, 660.0000, 510.0000, 1300.0000, 1100.0000, 950.0000, NULL, '2026-06-29 18:30:25', '2026-06-29 18:31:12');
INSERT INTO `customer_financials` VALUES (5, 24, 8500000.0000, 7200000.0000, 6000000.0000, 1200000.0000, 980000.0000, 850000.0000, 2000000.0000, 1500000.0000, 1000000.0000, NULL, '2026-06-29 20:03:45', '2026-06-29 20:03:45');
INSERT INTO `customer_financials` VALUES (6, 25, 1111.0000, 111.0000, 1111.0000, 1111.0000, 111111.0000, 1111.0000, 111.0000, 111111.0000, 111.0000, NULL, '2026-06-29 20:14:08', '2026-06-29 20:14:08');
INSERT INTO `customer_financials` VALUES (7, 29, 1111111.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 23:35:38', '2026-06-29 23:35:38');
INSERT INTO `customer_financials` VALUES (8, 30, 11111.0000, 11111.0000, 1111.0000, 111.0000, 111111.0000, 111111.0000, 11111.0000, 111.0000, 1111111.0000, NULL, '2026-06-30 09:15:13', '2026-06-30 09:15:13');
INSERT INTO `customer_financials` VALUES (9, 17, 5000.0000, 4200.0000, 3800.0000, 800.0000, 650.0000, 500.0000, 1200.0000, 1000.0000, 900.0000, NULL, '2026-06-30 09:31:12', '2026-06-30 09:31:12');
INSERT INTO `customer_financials` VALUES (10, 18, 5000.0000, 4200.0000, 3800.0000, 800.0000, 650.0000, 500.0000, 1200.0000, 1000.0000, 900.0000, NULL, '2026-06-30 09:31:47', '2026-06-30 09:31:47');

-- ----------------------------
-- Table structure for customer_ip_rights
-- ----------------------------
DROP TABLE IF EXISTS `customer_ip_rights`;
CREATE TABLE `customer_ip_rights`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `trademark_count` int NOT NULL DEFAULT 0 COMMENT '商标数量/件',
  `patent_count` int NOT NULL DEFAULT 0 COMMENT '专利数量/件',
  `authorized_invention_patent_count` int NOT NULL DEFAULT 0 COMMENT '授权发明专利数量/件',
  `copyright_count` int NOT NULL DEFAULT 0 COMMENT '版权登记数量/件',
  `has_enjoyed_additional_deduction` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否享受过加计扣除',
  `has_school_enterprise_cooperation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有校企合作',
  `cooperative_university_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '合作高校名称',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_ip_rights
-- ----------------------------
INSERT INTO `customer_ip_rights` VALUES (1, 2, 5, 1, 3, 1, 0, '清华大学', '2026-06-29 16:48:43', '2026-06-29 16:48:43');
INSERT INTO `customer_ip_rights` VALUES (2, 6, 0, 0, 0, 0, 0, NULL, '2026-06-29 18:27:01', '2026-06-29 18:27:01');
INSERT INTO `customer_ip_rights` VALUES (6, 15, 28, 8, 42, 1, 1, '四川大学、电子科技大学', '2026-06-29 20:03:48', '2026-06-29 20:03:48');
INSERT INTO `customer_ip_rights` VALUES (7, 4, 3, 3, 4, 0, 1, '成都东软学院', '2026-06-29 20:11:44', '2026-06-29 20:11:44');
INSERT INTO `customer_ip_rights` VALUES (8, 11, 4, 5, 13, 0, 0, '清华大学', '2026-06-29 22:53:04', '2026-06-29 22:53:04');
INSERT INTO `customer_ip_rights` VALUES (9, 0, 0, 0, 0, 0, 0, NULL, '2026-06-29 22:53:38', '2026-06-29 22:53:38');
INSERT INTO `customer_ip_rights` VALUES (10, 4, 1, 0, 0, 0, 0, NULL, '2026-06-29 22:53:54', '2026-06-29 23:22:11');
INSERT INTO `customer_ip_rights` VALUES (11, 2, 0, 0, 3, 0, 0, NULL, '2026-06-29 23:27:43', '2026-06-29 23:27:43');
INSERT INTO `customer_ip_rights` VALUES (12, 10, 10, 10, 10, 1, 0, '清华大学', '2026-06-30 09:12:57', '2026-06-30 09:12:57');

-- ----------------------------
-- Table structure for customer_qualifications
-- ----------------------------
DROP TABLE IF EXISTS `customer_qualifications`;
CREATE TABLE `customer_qualifications`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint UNSIGNED NOT NULL COMMENT '关联客户ID',
  `is_economic_accepted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '经信口是否验收',
  `economic_accept_time` date NULL DEFAULT NULL COMMENT '经信口验收时间',
  `is_tech_accepted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '科技口是否验收',
  `tech_accept_time` date NULL DEFAULT NULL COMMENT '科技口验收时间',
  `is_high_tech` tinyint(1) NOT NULL DEFAULT 0 COMMENT '高企',
  `high_tech_time` date NULL DEFAULT NULL COMMENT '高企认定时间',
  `is_province_tech` tinyint(1) NOT NULL DEFAULT 0 COMMENT '省企',
  `province_tech_time` date NULL DEFAULT NULL COMMENT '省企认定时间',
  `is_city_tech` tinyint(1) NOT NULL DEFAULT 0 COMMENT '市企',
  `city_tech_time` date NULL DEFAULT NULL COMMENT '市企认定时间',
  `is_province_engineer_center` tinyint(1) NOT NULL DEFAULT 0 COMMENT '省级工程技术中心',
  `province_engineer_center_time` date NULL DEFAULT NULL COMMENT '省级工程技术中心认定时间',
  `is_ip_standard` tinyint(1) NOT NULL DEFAULT 0 COMMENT '知识产权贯标',
  `ip_standard_time` date NULL DEFAULT NULL COMMENT '知识产权贯标认定时间',
  `is_integration_standard` tinyint(1) NOT NULL DEFAULT 0 COMMENT '两化融合贯标',
  `integration_standard_time` date NULL DEFAULT NULL COMMENT '两化融合贯标认定时间',
  `creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_qualifications_customer_id_index`(`customer_id` ASC) USING BTREE,
  INDEX `customer_qualifications_is_high_tech_index`(`is_high_tech` ASC) USING BTREE,
  INDEX `customer_qualifications_is_province_tech_index`(`is_province_tech` ASC) USING BTREE,
  INDEX `customer_qualifications_is_city_tech_index`(`is_city_tech` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_qualifications
-- ----------------------------
INSERT INTO `customer_qualifications` VALUES (1, 20, 1, '2025-03-15', 1, NULL, 1, '2024-06-01', 0, NULL, 0, NULL, 0, NULL, 1, '2025-01-10', 0, NULL, NULL, '2026-06-29 16:50:56', '2026-06-29 18:28:17');
INSERT INTO `customer_qualifications` VALUES (3, 25, 1, '2024-03-15', 1, '2024-06-20', 1, '2023-12-01', 1, '2024-08-10', 0, '2025-01-05', 1, '2024-11-20', 0, '2024-05-10', 0, '2026-06-19', NULL, '2026-06-29 20:03:49', '2026-06-29 20:14:11');
INSERT INTO `customer_qualifications` VALUES (4, 29, 0, NULL, 1, NULL, 0, NULL, 1, NULL, 0, NULL, 1, NULL, 0, NULL, 1, NULL, NULL, '2026-06-29 23:35:42', '2026-06-29 23:35:42');
INSERT INTO `customer_qualifications` VALUES (5, 30, 1, '2026-06-02', 1, '2026-06-13', 1, '2026-06-04', 0, '2026-06-06', 1, '2026-06-29', 0, '2026-06-01', 0, '2026-06-28', 0, '2026-06-02', NULL, '2026-06-30 09:15:15', '2026-06-30 09:15:15');
INSERT INTO `customer_qualifications` VALUES (6, 30, 1, '2026-06-02', 1, '2026-06-13', 1, '2026-06-04', 0, '2026-06-06', 1, '2026-06-29', 0, '2026-06-01', 0, '2026-06-28', 0, '2026-06-02', NULL, '2026-06-30 09:15:31', '2026-06-30 09:15:31');

-- ----------------------------
-- Table structure for customer_rd_investments
-- ----------------------------
DROP TABLE IF EXISTS `customer_rd_investments`;
CREATE TABLE `customer_rd_investments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `basic_id` bigint UNSIGNED NOT NULL COMMENT '关联客户基础信息ID',
  `year` year NOT NULL COMMENT '年份，如2025',
  `projects` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '研发项目，多个项目逗号分隔',
  `amount` decimal(15, 2) NULL DEFAULT NULL COMMENT '项目金额',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `customer_rd_investments_basic_id_year_unique`(`basic_id` ASC, `year` ASC) USING BTREE,
  INDEX `customer_rd_investments_basic_id_index`(`basic_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_rd_investments
-- ----------------------------
INSERT INTO `customer_rd_investments` VALUES (1, 1, 2025, '智能机器人算法优化, 新能源电池管理系统, 工业互联网平台V2', 2800000.00, '2026-06-29 16:44:13', '2026-06-29 16:53:53');
INSERT INTO `customer_rd_investments` VALUES (9, 2, 2025, '智能机器人算法优化, 新能源电池管理系统, 工业互联网平台', 2500000.00, '2026-06-29 18:09:26', '2026-06-29 18:09:26');
INSERT INTO `customer_rd_investments` VALUES (13, 24, 2023, 'AI智能分析平台研发,大数据处理引擎开发', 850000.00, '2026-06-29 20:04:04', '2026-06-29 20:04:04');
INSERT INTO `customer_rd_investments` VALUES (14, 24, 2024, '云计算资源调度系统,物联网边缘计算平台', 1200000.00, '2026-06-29 20:04:05', '2026-06-29 20:04:05');
INSERT INTO `customer_rd_investments` VALUES (15, 24, 2025, '基于大语言模型的企业知识库,智能运维AIOps平台', 1800000.00, '2026-06-29 20:04:06', '2026-06-29 20:04:06');
INSERT INTO `customer_rd_investments` VALUES (16, 25, 2025, '项目A，项目B，项目C', 3232.00, '2026-06-29 20:14:12', '2026-06-29 20:14:12');
INSERT INTO `customer_rd_investments` VALUES (17, 25, 2023, '项目A，项目B，项目C', 5332.00, '2026-06-29 20:14:13', '2026-06-29 20:14:13');
INSERT INTO `customer_rd_investments` VALUES (18, 25, 2024, '项目A，项目B，项目C', 2323.00, '2026-06-29 20:14:13', '2026-06-29 20:14:13');
INSERT INTO `customer_rd_investments` VALUES (19, 29, 2025, '1', 1.00, '2026-06-29 23:35:43', '2026-06-29 23:35:43');
INSERT INTO `customer_rd_investments` VALUES (20, 30, 2025, '项目A，项目B，项目C', 1111.00, '2026-06-30 09:15:16', '2026-06-30 09:15:16');
INSERT INTO `customer_rd_investments` VALUES (21, 30, 2023, '项目A，项目B，项目C', 11111.00, '2026-06-30 09:15:16', '2026-06-30 09:15:16');
INSERT INTO `customer_rd_investments` VALUES (22, 30, 2024, '项目A，项目B，项目C', 1111.00, '2026-06-30 09:15:16', '2026-06-30 09:15:16');

-- ----------------------------
-- Table structure for customer_statistics
-- ----------------------------
DROP TABLE IF EXISTS `customer_statistics`;
CREATE TABLE `customer_statistics`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `economy_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济门类',
  `economy_sub_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济小类',
  `economy_large_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济大类',
  `economy_mid_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国民经济中类',
  `sales_2021` decimal(18, 4) NULL DEFAULT NULL COMMENT '2021年销售额度',
  `sales_2020` decimal(18, 4) NULL DEFAULT NULL COMMENT '2020年销售额度',
  `sales_2019` decimal(18, 4) NULL DEFAULT NULL COMMENT '2019年销售额度',
  `rd_fee_2021` decimal(18, 4) NULL DEFAULT NULL COMMENT '2021年研发费用',
  `rd_fee_2020` decimal(18, 4) NULL DEFAULT NULL COMMENT '2020年研发费用',
  `rd_fee_2019` decimal(18, 4) NULL DEFAULT NULL COMMENT '2019年研发费用',
  `loan_2021` decimal(18, 4) NULL DEFAULT NULL COMMENT '2021年贷款',
  `loan_2020` decimal(18, 4) NULL DEFAULT NULL COMMENT '2020年贷款',
  `loan_2019` decimal(18, 4) NULL DEFAULT NULL COMMENT '2019年贷款',
  `tech_verified` tinyint(1) NOT NULL DEFAULT 0 COMMENT '科技口是否验证',
  `is_high_tech` tinyint(1) NOT NULL DEFAULT 0 COMMENT '高企',
  `is_provincial_enterprise` tinyint(1) NOT NULL DEFAULT 0 COMMENT '省企',
  `is_municipal_enterprise` tinyint(1) NOT NULL DEFAULT 0 COMMENT '市企',
  `is_engineering_center` tinyint(1) NOT NULL DEFAULT 0 COMMENT '省级工程技术中心',
  `ip_index` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '知识产权指标',
  `integration_standard` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '两化融合贯标',
  `creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `basic_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '关联客户基本信息表ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_statistics_basic_id_index`(`basic_id` ASC) USING BTREE,
  CONSTRAINT `customer_statistics_basic_id_foreign` FOREIGN KEY (`basic_id`) REFERENCES `customer_basics` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_statistics
-- ----------------------------
INSERT INTO `customer_statistics` VALUES (8, '制造业', '专用设备制造业', '电工机械专用设备制造', '电机制造', 4500000.0000, 3900000.0000, 3400000.0000, 980000.0000, 860000.0000, 750000.0000, 2200000.0000, 1800000.0000, 1500000.0000, 1, 1, 0, 1, 0, 'A', 'AA', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (9, '科学研究和技术服务业', '研究和试验发展', '工程和技术研究和试验发展', '材料科学研究服务', 3200000.0000, 2800000.0000, 2400000.0000, 1500000.0000, 1300000.0000, 1100000.0000, 1500000.0000, 1200000.0000, 900000.0000, 1, 1, 1, 0, 1, 'AA', 'AAA', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (10, '制造业', '金属制品业', '通用零部件制造', '紧固件制造', 6800000.0000, 5900000.0000, 5100000.0000, 1450000.0000, 1250000.0000, 1050000.0000, 3500000.0000, 2900000.0000, 2400000.0000, 0, 1, 0, 0, 0, 'B', 'A', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (11, '制造业', '计算机、通信和其他电子设备制造业', '电子器件制造业', '电子元件及电子专用材料制造', 5680000.0000, 4890000.0000, 4230000.0000, 1250000.0000, 1080000.0000, 920000.0000, 3000000.0000, 2500000.0000, 1800000.0000, 1, 1, 1, 0, 1, 'AA', 'AAA', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (12, '制造业', '通用设备制造业', '金属加工机械制造', '金属成形机床制造', 8900000.0000, 7600000.0000, 6500000.0000, 2100000.0000, 1850000.0000, 1600000.0000, 4500000.0000, 3800000.0000, 3000000.0000, 1, 1, 1, 1, 1, 'AAA', 'AAA', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (13, '科学研究和技术服务业', '研究和试验发展', '工程和技术研究和试验发展', '材料科学研究服务', 4200000.0000, 3650000.0000, 3100000.0000, 1800000.0000, 1550000.0000, 1300000.0000, 2000000.0000, 1700000.0000, 1400000.0000, 1, 1, 1, 1, 1, 'AA', 'AAA', 'admin', '2026-06-29 16:54:24', '2026-06-29 16:54:24', NULL);
INSERT INTO `customer_statistics` VALUES (26, '建筑业', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, '2026-06-29 18:26:15', '2026-06-29 18:26:15', NULL);
INSERT INTO `customer_statistics` VALUES (27, '制造业', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, '2026-06-29 18:29:01', '2026-06-30 09:10:43', NULL);

-- ----------------------------
-- Table structure for inventor
-- ----------------------------
DROP TABLE IF EXISTS `inventor`;
CREATE TABLE `inventor`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint UNSIGNED NOT NULL COMMENT '关联客户ID',
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户名称',
  `customer_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发明人姓名',
  `english_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文姓名',
  `inventor_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发明人编号',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '中国' COMMENT '国籍',
  `id_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '身份证' COMMENT '证件类型',
  `id_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '证件号码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `landline` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '座机',
  `wechat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `region_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '行政区划ID',
  `street_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '街道地址',
  `address_en` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文地址',
  `zip_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮编',
  `inventor_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '备注',
  `operator_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '业务人员ID',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除 0=正常,1=删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `inventor_inventor_no_unique`(`inventor_no` ASC) USING BTREE,
  INDEX `inventor_customer_id_index`(`customer_id` ASC) USING BTREE,
  INDEX `inventor_name_index`(`name` ASC) USING BTREE,
  INDEX `inventor_region_id_index`(`region_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventor
-- ----------------------------
INSERT INTO `inventor` VALUES (1, 15, '123', NULL, '1111', NULL, 'IV-20260629-67722', '中国', '身份证', NULL, '15151515151', NULL, NULL, 'ECTR@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:05:05', NULL, '2026-06-29 16:05:09', 1);
INSERT INTO `inventor` VALUES (2, 2, '测试客户', NULL, '李四-修改后', NULL, 'IV-20260629-36994', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:25:07', NULL, '2026-06-29 17:19:11', 0);
INSERT INTO `inventor` VALUES (3, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-35209', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:25:25', NULL, '2026-06-30 09:08:40', 1);
INSERT INTO `inventor` VALUES (4, 2, '测试客户', NULL, '王五', NULL, 'IV-20260629-13689', '中国', '身份证', NULL, '13800138001', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:25:27', NULL, '2026-06-29 18:28:02', 1);
INSERT INTO `inventor` VALUES (5, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-38808', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:31:48', NULL, '2026-06-30 09:08:45', 1);
INSERT INTO `inventor` VALUES (6, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-15075', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:48:32', NULL, '2026-06-30 09:26:01', 1);
INSERT INTO `inventor` VALUES (7, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-90404', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:48:36', NULL, '2026-06-29 16:48:36', 0);
INSERT INTO `inventor` VALUES (8, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-65846', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:51:37', NULL, '2026-06-29 16:51:37', 0);
INSERT INTO `inventor` VALUES (9, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-49412', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:51:40', NULL, '2026-06-30 09:25:31', 1);
INSERT INTO `inventor` VALUES (10, 2, '测试客户', NULL, '王五', NULL, 'IV-20260629-69509', '中国', '身份证', NULL, '13800138001', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:51:42', NULL, '2026-06-29 16:56:00', 1);
INSERT INTO `inventor` VALUES (11, 14, '杭州某某网络技术有限公司', NULL, '地产市场的', NULL, 'IV-20260629-20057', '美国', '身份证', NULL, '11111111111', NULL, NULL, '1@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 16:55:54', NULL, '2026-06-29 23:05:47', 1);
INSERT INTO `inventor` VALUES (12, 2, '测试客户', NULL, '王五', NULL, 'IV-20260629-53684', '中国', '身份证', NULL, '13800138001', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 17:15:29', NULL, '2026-06-29 17:15:29', 0);
INSERT INTO `inventor` VALUES (13, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-76265', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 18:15:33', NULL, '2026-06-29 18:25:42', 1);
INSERT INTO `inventor` VALUES (14, 1, '测试客户', NULL, '李四', NULL, 'IV-20260629-68885', '中国', '身份证', NULL, '13800138000', NULL, NULL, 'lisi@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 18:15:48', NULL, '2026-06-29 20:05:53', 1);
INSERT INTO `inventor` VALUES (15, 12, '北京某某数据服务有限公司', NULL, 'wdw', NULL, 'IV-20260629-93271', '中国', '护照', NULL, '12121212121', NULL, NULL, '1@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 18:27:53', NULL, '2026-06-29 23:31:21', 1);
INSERT INTO `inventor` VALUES (16, 25, '测试2', NULL, '大晚上的', NULL, 'IV-20260629-51063', '中国', '身份证', NULL, '12121212121', NULL, NULL, '1@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-29 23:05:37', NULL, '2026-06-29 23:05:37', 0);
INSERT INTO `inventor` VALUES (17, 26, '测试3', NULL, '手擦', NULL, 'IV-20260630-77160', '中国', '身份证', NULL, '12121212121', NULL, NULL, '111@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-30 09:10:07', NULL, '2026-06-30 09:10:07', 0);
INSERT INTO `inventor` VALUES (18, 28, 'wdw', NULL, 'scac', NULL, 'IV-20260630-24976', '中国', '身份证', NULL, '11111111111', NULL, NULL, '11@qq.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-30 09:25:57', NULL, '2026-06-30 09:25:57', 0);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2026_06_12_000001_create_customer_basics_table', 1);
INSERT INTO `migrations` VALUES (2, '2026_06_12_000002_create_customer_addresses_table', 1);
INSERT INTO `migrations` VALUES (3, '2026_06_12_000003_create_customer_fees_table', 1);
INSERT INTO `migrations` VALUES (4, '2026_06_12_000004_create_customer_enterprises_table', 1);
INSERT INTO `migrations` VALUES (5, '2026_06_12_000005_create_sys_customer_level_table', 1);
INSERT INTO `migrations` VALUES (6, '2026_06_12_000006_create_sys_customer_scale_table', 1);
INSERT INTO `migrations` VALUES (7, '2026_06_12_000007_create_biz_file_description_table', 1);
INSERT INTO `migrations` VALUES (8, '2026_06_12_000008_create_sys_file_category_table', 1);
INSERT INTO `migrations` VALUES (9, '2026_06_12_000009_create_biz_price_index_table', 1);
INSERT INTO `migrations` VALUES (10, '2026_06_12_000010_create_biz_innovation_index_table', 1);
INSERT INTO `migrations` VALUES (11, '2026_06_12_000011_create_sys_industrial_park_table', 1);
INSERT INTO `migrations` VALUES (12, '2026_06_12_000012_create_sys_location_region_table', 1);
INSERT INTO `migrations` VALUES (13, '2026_06_12_000013_create_sys_economy_category_table', 1);
INSERT INTO `migrations` VALUES (14, '2026_06_12_000014_create_sys_user_table', 1);
INSERT INTO `migrations` VALUES (15, '2026_06_12_000015_create_sys_dept_table', 1);
INSERT INTO `migrations` VALUES (16, '2026_06_12_000016_create_sys_role_table', 1);
INSERT INTO `migrations` VALUES (17, '2026_06_12_000017_create_sys_menu_table', 1);
INSERT INTO `migrations` VALUES (18, '2026_06_12_000018_create_sys_role_menu_table', 1);
INSERT INTO `migrations` VALUES (19, '2026_06_26_060107_create_customer_business_table', 1);
INSERT INTO `migrations` VALUES (20, '2026_06_26_060122_create_applicants_table', 1);
INSERT INTO `migrations` VALUES (21, '2026_06_26_060127_create_inventors_table', 1);
INSERT INTO `migrations` VALUES (22, '2026_06_26_162737_create_cache_table', 1);
INSERT INTO `migrations` VALUES (23, '2026_06_26_171950_add_role_id_to_sys_user_table', 1);
INSERT INTO `migrations` VALUES (24, '2026_06_27_000001_create_customer_files_table', 1);
INSERT INTO `migrations` VALUES (25, '2026_06_27_000002_create_customer_contacts_table', 1);
INSERT INTO `migrations` VALUES (26, '2026_06_27_000003_create_customer_ip_rights_table', 1);
INSERT INTO `migrations` VALUES (27, '2026_06_28_000001_create_customer_data_table', 1);
INSERT INTO `migrations` VALUES (28, '2026_06_28_165603_rename_customer_data_to_customer_statistics', 1);
INSERT INTO `migrations` VALUES (29, '2026_06_29_000001_add_basic_id_to_customer_statistics', 1);
INSERT INTO `migrations` VALUES (30, '2026_06_29_000001_create_customer_qualifications_table', 1);
INSERT INTO `migrations` VALUES (31, '2026_06_29_102447_add_economy_category_fields_to_customer_business_table', 1);
INSERT INTO `migrations` VALUES (33, '2026_06_29_145143_create_customer_rd_investments_table', 2);
INSERT INTO `migrations` VALUES (34, '2026_06_29_create_customer_financials_table', 2);
INSERT INTO `migrations` VALUES (35, '2026_06_29_000001_create_customer_enterprise_investments_table', 3);
INSERT INTO `migrations` VALUES (36, '2026_06_29_200317_make_category_id_nullable_in_customer_files_table', 4);
INSERT INTO `migrations` VALUES (37, '2026_06_29_201424_make_customer_id_nullable_in_customer_files_table', 5);
INSERT INTO `migrations` VALUES (38, '2026_06_29_201851_add_invoice_credit_code_to_customer_fees_table', 6);
INSERT INTO `migrations` VALUES (39, '2026_06_29_202007_add_is_general_taxpayer_to_customer_fees_table', 7);

-- ----------------------------
-- Table structure for sys_customer_level
-- ----------------------------
DROP TABLE IF EXISTS `sys_customer_level`;
CREATE TABLE `sys_customer_level`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户等级名称',
  `level_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '等级编码',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_customer_level_level_code_index`(`level_code` ASC) USING BTREE,
  INDEX `sys_customer_level_status_index`(`status` ASC) USING BTREE,
  INDEX `sys_customer_level_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_customer_level
-- ----------------------------
INSERT INTO `sys_customer_level` VALUES (1, 1, 'A级客户', '456777scac', NULL, 0, '2026-06-29 16:29:56', '2026-06-30 09:11:44', NULL);
INSERT INTO `sys_customer_level` VALUES (2, 1, 'B级客户', 'B', NULL, 0, '2026-06-29 16:29:59', '2026-06-29 23:07:32', NULL);
INSERT INTO `sys_customer_level` VALUES (3, 4, 'S级客户', 'Sew', NULL, 1, '2026-06-29 16:30:01', '2026-06-30 09:11:10', NULL);
INSERT INTO `sys_customer_level` VALUES (4, 1, 'A级客户', 'Axsa', NULL, 1, '2026-06-29 18:21:45', '2026-06-30 09:11:30', NULL);
INSERT INTO `sys_customer_level` VALUES (5, 11, 'agvfav', NULL, NULL, 1, '2026-06-29 18:26:37', '2026-06-30 09:27:07', NULL);
INSERT INTO `sys_customer_level` VALUES (6, 1, 'bfdzvf', NULL, NULL, 1, '2026-06-29 18:35:14', '2026-06-29 18:35:14', NULL);
INSERT INTO `sys_customer_level` VALUES (7, 1, 'qdwd', 'qdq', NULL, 0, '2026-06-29 19:07:05', '2026-06-29 19:07:05', NULL);
INSERT INTO `sys_customer_level` VALUES (8, 1, 'csac', 'sac', NULL, 1, '2026-06-29 23:07:23', '2026-06-29 23:07:23', NULL);
INSERT INTO `sys_customer_level` VALUES (9, 1, 'xasx', 'cac', NULL, 1, '2026-06-30 09:27:02', '2026-06-30 09:27:02', NULL);

-- ----------------------------
-- Table structure for sys_customer_scale
-- ----------------------------
DROP TABLE IF EXISTS `sys_customer_scale`;
CREATE TABLE `sys_customer_scale`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `scale_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户规模名称',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_customer_scale_status_index`(`status` ASC) USING BTREE,
  INDEX `sys_customer_scale_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_customer_scale
-- ----------------------------
INSERT INTO `sys_customer_scale` VALUES (1, 2, '初创', 1, '2026-06-29 16:30:09', '2026-06-29 23:08:07', NULL);
INSERT INTO `sys_customer_scale` VALUES (2, 3, '央企', 1, '2026-06-29 16:30:11', '2026-06-30 09:11:49', NULL);
INSERT INTO `sys_customer_scale` VALUES (3, 1, '国企', 0, '2026-06-29 16:30:14', '2026-06-30 09:27:30', NULL);
INSERT INTO `sys_customer_scale` VALUES (4, 1, 'ewfwsac', 0, '2026-06-29 18:26:52', '2026-06-30 09:27:24', NULL);
INSERT INTO `sys_customer_scale` VALUES (5, 1, 'dva', 1, '2026-06-29 18:35:24', '2026-06-29 18:35:24', NULL);
INSERT INTO `sys_customer_scale` VALUES (6, 3, 'sqs', 1, '2026-06-29 19:07:53', '2026-06-29 19:07:53', NULL);
INSERT INTO `sys_customer_scale` VALUES (7, 4, 'scaca', 1, '2026-06-30 09:12:03', '2026-06-30 09:12:03', NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父部门ID，顶级为0',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门名称',
  `dept_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '部门编码',
  `leader_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '负责人ID',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门描述',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '备注',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：0-停用，1-正常',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sys_dept_dept_code_unique`(`dept_code` ASC) USING BTREE,
  INDEX `sys_dept_parent_id_index`(`parent_id` ASC) USING BTREE,
  INDEX `sys_dept_leader_id_index`(`leader_id` ASC) USING BTREE,
  INDEX `sys_dept_status_index`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, '测试部', 'TEST001', NULL, '负责质量保障', '新建部门', 1, '2026-06-29 16:19:44', '2026-06-29 16:19:44');
INSERT INTO `sys_dept` VALUES (2, 2, '研发部', 'RD001', NULL, '负责研发', '测试部门下的子部门', 1, '2026-06-29 16:19:47', '2026-06-29 16:19:47');
INSERT INTO `sys_dept` VALUES (3, 1, '财务', '1', NULL, '管理财务', NULL, 1, '2026-06-30 09:23:10', '2026-06-30 09:23:10');

-- ----------------------------
-- Table structure for sys_economy_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_economy_category`;
CREATE TABLE `sys_economy_category`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级ID，顶级为0',
  `category_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行业代码',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行业名称',
  `level` tinyint UNSIGNED NOT NULL COMMENT '层级深度：1-门类，2-大类，3-中类，4-小类',
  `full_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '全路径名称',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-停用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_economy_category_parent_id_index`(`parent_id` ASC) USING BTREE,
  INDEX `sys_economy_category_category_code_index`(`category_code` ASC) USING BTREE,
  INDEX `sys_economy_category_level_index`(`level` ASC) USING BTREE,
  INDEX `sys_economy_category_status_index`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1380 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_economy_category
-- ----------------------------
INSERT INTO `sys_economy_category` VALUES (591, 0, 'A', '农、林、牧、渔业', 1, '农、林、牧、渔业', 1, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (592, 591, '01', '农业', 2, '农、林、牧、渔业 > 农业', 1, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (593, 592, '011', '谷物种植', 3, '农、林、牧、渔业 > 农业 > 谷物种植', 11, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (594, 592, '012', '豆类、油料和薯类种植', 3, '农、林、牧、渔业 > 农业 > 豆类、油料和薯类种植', 12, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (595, 592, '013', '棉、麻、糖、烟草种植', 3, '农、林、牧、渔业 > 农业 > 棉、麻、糖、烟草种植', 13, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (596, 592, '014', '蔬菜、食用菌及园艺作物种植', 3, '农、林、牧、渔业 > 农业 > 蔬菜、食用菌及园艺作物种植', 14, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (597, 592, '015', '水果种植', 3, '农、林、牧、渔业 > 农业 > 水果种植', 15, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (598, 592, '016', '坚果、含油果、香料和饮料作物种植', 3, '农、林、牧、渔业 > 农业 > 坚果、含油果、香料和饮料作物种植', 16, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (599, 592, '017', '中药材种植', 3, '农、林、牧、渔业 > 农业 > 中药材种植', 17, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (600, 592, '018', '草种植及割草', 3, '农、林、牧、渔业 > 农业 > 草种植及割草', 18, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (601, 592, '019', '其他农业', 3, '农、林、牧、渔业 > 农业 > 其他农业', 19, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (602, 601, '0190', '其他农业', 4, '农、林、牧、渔业 > 农业 > 其他农业', 190, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (603, 591, '02', '林业', 2, '农、林、牧、渔业 > 林业', 2, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (604, 603, '021', '林木育种和育苗', 3, '农、林、牧、渔业 > 林业 > 林木育种和育苗', 21, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (605, 603, '022', '造林和更新', 3, '农、林、牧、渔业 > 林业 > 造林和更新', 22, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (606, 603, '023', '森林经营、管护和改培', 3, '农、林、牧、渔业 > 林业 > 森林经营、管护和改培', 23, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (607, 603, '024', '木材和竹材采运', 3, '农、林、牧、渔业 > 林业 > 木材和竹材采运', 24, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (608, 603, '025', '林产品采集', 3, '农、林、牧、渔业 > 林业 > 林产品采集', 25, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (609, 605, '0220', '造林和更新', 4, '农、林、牧、渔业 > 林业 > 造林和更新', 220, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (610, 591, '03', '畜牧业', 2, '农、林、牧、渔业 > 畜牧业', 3, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (611, 610, '031', '牲畜饲养', 3, '农、林、牧、渔业 > 畜牧业 > 牲畜饲养', 31, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (612, 610, '032', '家禽饲养', 3, '农、林、牧、渔业 > 畜牧业 > 家禽饲养', 32, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (613, 610, '033', '狩猎和捕捉动物', 3, '农、林、牧、渔业 > 畜牧业 > 狩猎和捕捉动物', 33, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (614, 610, '039', '其他畜牧业', 3, '农、林、牧、渔业 > 畜牧业 > 其他畜牧业', 39, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (615, 613, '0330', '狩猎和捕捉动物', 4, '农、林、牧、渔业 > 畜牧业 > 狩猎和捕捉动物', 330, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (616, 591, '04', '渔业', 2, '农、林、牧、渔业 > 渔业', 4, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (617, 616, '041', '水产养殖', 3, '农、林、牧、渔业 > 渔业 > 水产养殖', 41, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (618, 616, '042', '水产捕捞', 3, '农、林、牧、渔业 > 渔业 > 水产捕捞', 42, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (619, 591, '05', '农、林、牧、渔专业及辅助性活动', 2, '农、林、牧、渔业 > 农、林、牧、渔专业及辅助性活动', 5, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (620, 619, '051', '农业专业及辅助性活动', 3, '农、林、牧、渔业 > 农、林、牧、渔专业及辅助性活动 > 农业专业及辅助性活动', 51, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (621, 619, '052', '林业专业及辅助性活动', 3, '农、林、牧、渔业 > 农、林、牧、渔专业及辅助性活动 > 林业专业及辅助性活动', 52, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (622, 619, '053', '畜牧专业及辅助性活动', 3, '农、林、牧、渔业 > 农、林、牧、渔专业及辅助性活动 > 畜牧专业及辅助性活动', 53, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (623, 619, '054', '渔业专业及辅助性活动', 3, '农、林、牧、渔业 > 农、林、牧、渔专业及辅助性活动 > 渔业专业及辅助性活动', 54, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (624, 0, 'B', '采矿业', 1, '采矿业', 2, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (625, 624, '06', '煤炭开采和洗选业', 2, '采矿业 > 煤炭开采和洗选业', 6, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (626, 625, '061', '烟煤和无烟煤开采洗选', 3, '采矿业 > 煤炭开采和洗选业 > 烟煤和无烟煤开采洗选', 61, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (627, 625, '062', '褐煤开采洗选', 3, '采矿业 > 煤炭开采和洗选业 > 褐煤开采洗选', 62, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (628, 625, '069', '其他煤炭采选', 3, '采矿业 > 煤炭开采和洗选业 > 其他煤炭采选', 69, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (629, 626, '0610', '烟煤和无烟煤开采洗选', 4, '采矿业 > 煤炭开采和洗选业 > 烟煤和无烟煤开采洗选', 610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (630, 627, '0620', '褐煤开采洗选', 4, '采矿业 > 煤炭开采和洗选业 > 褐煤开采洗选', 620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (631, 628, '0690', '其他煤炭采选', 4, '采矿业 > 煤炭开采和洗选业 > 其他煤炭采选', 690, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (632, 624, '07', '石油和天然气开采业', 2, '采矿业 > 石油和天然气开采业', 7, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (633, 632, '071', '石油开采', 3, '采矿业 > 石油和天然气开采业 > 石油开采', 71, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (634, 632, '072', '天然气开采', 3, '采矿业 > 石油和天然气开采业 > 天然气开采', 72, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (635, 624, '08', '黑色金属矿采选业', 2, '采矿业 > 黑色金属矿采选业', 8, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (636, 635, '081', '铁矿采选', 3, '采矿业 > 黑色金属矿采选业 > 铁矿采选', 81, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (637, 635, '082', '锰矿、铬矿采选', 3, '采矿业 > 黑色金属矿采选业 > 锰矿、铬矿采选', 82, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (638, 635, '089', '其他黑色金属矿采选', 3, '采矿业 > 黑色金属矿采选业 > 其他黑色金属矿采选', 89, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (639, 636, '0810', '铁矿采选', 4, '采矿业 > 黑色金属矿采选业 > 铁矿采选', 810, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (640, 637, '0820', '锰矿、铬矿采选', 4, '采矿业 > 黑色金属矿采选业 > 锰矿、铬矿采选', 820, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (641, 638, '0890', '其他黑色金属矿采选', 4, '采矿业 > 黑色金属矿采选业 > 其他黑色金属矿采选', 890, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (642, 624, '09', '有色金属矿采选业', 2, '采矿业 > 有色金属矿采选业', 9, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (643, 642, '091', '常用有色金属矿采选', 3, '采矿业 > 有色金属矿采选业 > 常用有色金属矿采选', 91, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (644, 642, '092', '贵金属矿采选', 3, '采矿业 > 有色金属矿采选业 > 贵金属矿采选', 92, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (645, 642, '093', '稀有稀土金属矿采选', 3, '采矿业 > 有色金属矿采选业 > 稀有稀土金属矿采选', 93, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (646, 624, '10', '非金属矿采选业', 2, '采矿业 > 非金属矿采选业', 10, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (647, 646, '101', '土砂石开采', 3, '采矿业 > 非金属矿采选业 > 土砂石开采', 101, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (648, 646, '102', '化学矿开采', 3, '采矿业 > 非金属矿采选业 > 化学矿开采', 102, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (649, 646, '103', '采盐', 3, '采矿业 > 非金属矿采选业 > 采盐', 103, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (650, 646, '109', '石棉及其他非金属矿采选', 3, '采矿业 > 非金属矿采选业 > 石棉及其他非金属矿采选', 109, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (651, 648, '1020', '化学矿开采', 4, '采矿业 > 非金属矿采选业 > 化学矿开采', 1020, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (652, 649, '1030', '采盐', 4, '采矿业 > 非金属矿采选业 > 采盐', 1030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (653, 624, '11', '开采专业及辅助性活动', 2, '采矿业 > 开采专业及辅助性活动', 11, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (654, 653, '111', '煤炭开采和洗选专业及辅助性活动', 3, '采矿业 > 开采专业及辅助性活动 > 煤炭开采和洗选专业及辅助性活动', 111, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (655, 653, '112', '石油和天然气开采专业及辅助性活动', 3, '采矿业 > 开采专业及辅助性活动 > 石油和天然气开采专业及辅助性活动', 112, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (656, 653, '119', '其他开采专业及辅助性活动', 3, '采矿业 > 开采专业及辅助性活动 > 其他开采专业及辅助性活动', 119, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (657, 654, '1110', '煤炭开采和洗选专业及辅助性活动', 4, '采矿业 > 开采专业及辅助性活动 > 煤炭开采和洗选专业及辅助性活动', 1110, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (658, 655, '1120', '石油和天然气开采专业及辅助性活动', 4, '采矿业 > 开采专业及辅助性活动 > 石油和天然气开采专业及辅助性活动', 1120, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (659, 656, '1190', '其他开采专业及辅助性活动', 4, '采矿业 > 开采专业及辅助性活动 > 其他开采专业及辅助性活动', 1190, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (660, 624, '12', '其他采矿业', 2, '采矿业 > 其他采矿业', 12, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (661, 660, '120', '其他采矿业', 3, '采矿业 > 其他采矿业 > 其他采矿业', 120, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (662, 661, '1200', '其他采矿业', 4, '采矿业 > 其他采矿业 > 其他采矿业', 1200, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (663, 0, 'C', '制造业', 1, '制造业', 3, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (664, 663, '13', '农副食品加工业', 2, '制造业 > 农副食品加工业', 13, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (665, 664, '131', '谷物磨制', 3, '制造业 > 农副食品加工业 > 谷物磨制', 131, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (666, 664, '132', '饲料加工', 3, '制造业 > 农副食品加工业 > 饲料加工', 132, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (667, 664, '133', '植物油加工', 3, '制造业 > 农副食品加工业 > 植物油加工', 133, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (668, 664, '134', '制糖业', 3, '制造业 > 农副食品加工业 > 制糖业', 134, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (669, 664, '135', '屠宰及肉类加工', 3, '制造业 > 农副食品加工业 > 屠宰及肉类加工', 135, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (670, 664, '136', '水产品加工', 3, '制造业 > 农副食品加工业 > 水产品加工', 136, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (671, 664, '137', '蔬菜、菌类、水果和坚果加工', 3, '制造业 > 农副食品加工业 > 蔬菜、菌类、水果和坚果加工', 137, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (672, 664, '139', '其他农副食品加工', 3, '制造业 > 农副食品加工业 > 其他农副食品加工', 139, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (673, 668, '1340', '制糖业', 4, '制造业 > 农副食品加工业 > 制糖业', 1340, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (674, 663, '14', '食品制造业', 2, '制造业 > 食品制造业', 14, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (675, 674, '141', '焙烤食品制造', 3, '制造业 > 食品制造业 > 焙烤食品制造', 141, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (676, 674, '142', '糖果、巧克力及蜜饯制造', 3, '制造业 > 食品制造业 > 糖果、巧克力及蜜饯制造', 142, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (677, 674, '143', '方便食品制造', 3, '制造业 > 食品制造业 > 方便食品制造', 143, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (678, 674, '144', '乳制品制造', 3, '制造业 > 食品制造业 > 乳制品制造', 144, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (679, 674, '145', '罐头食品制造', 3, '制造业 > 食品制造业 > 罐头食品制造', 145, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (680, 674, '146', '调味品、发酵制品制造', 3, '制造业 > 食品制造业 > 调味品、发酵制品制造', 146, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (681, 674, '149', '其他食品制造', 3, '制造业 > 食品制造业 > 其他食品制造', 149, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (682, 663, '15', '酒、饮料和精制茶制造业', 2, '制造业 > 酒、饮料和精制茶制造业', 15, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (683, 682, '151', '酒的制造', 3, '制造业 > 酒、饮料和精制茶制造业 > 酒的制造', 151, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (684, 682, '152', '饮料制造', 3, '制造业 > 酒、饮料和精制茶制造业 > 饮料制造', 152, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (685, 682, '153', '精制茶加工', 3, '制造业 > 酒、饮料和精制茶制造业 > 精制茶加工', 153, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (686, 685, '1530', '精制茶加工', 4, '制造业 > 酒、饮料和精制茶制造业 > 精制茶加工', 1530, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (687, 663, '16', '烟草制品业', 2, '制造业 > 烟草制品业', 16, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (688, 687, '161', '烟叶复烤', 3, '制造业 > 烟草制品业 > 烟叶复烤', 161, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (689, 687, '162', '卷烟制造', 3, '制造业 > 烟草制品业 > 卷烟制造', 162, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (690, 687, '169', '其他烟草制品制造', 3, '制造业 > 烟草制品业 > 其他烟草制品制造', 169, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (691, 688, '1610', '烟叶复烤', 4, '制造业 > 烟草制品业 > 烟叶复烤', 1610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (692, 689, '1620', '卷烟制造', 4, '制造业 > 烟草制品业 > 卷烟制造', 1620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (693, 690, '1690', '其他烟草制品制造', 4, '制造业 > 烟草制品业 > 其他烟草制品制造', 1690, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (694, 663, '17', '纺织业', 2, '制造业 > 纺织业', 17, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (695, 694, '171', '棉纺织及印染精加工', 3, '制造业 > 纺织业 > 棉纺织及印染精加工', 171, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (696, 694, '172', '毛纺织及染整精加工', 3, '制造业 > 纺织业 > 毛纺织及染整精加工', 172, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (697, 694, '173', '麻纺织及染整精加工', 3, '制造业 > 纺织业 > 麻纺织及染整精加工', 173, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (698, 694, '174', '丝绢纺织及印染精加工', 3, '制造业 > 纺织业 > 丝绢纺织及印染精加工', 174, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (699, 694, '175', '化纤织造及印染精加工', 3, '制造业 > 纺织业 > 化纤织造及印染精加工', 175, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (700, 694, '176', '针织或钩针编织物及其制品制造', 3, '制造业 > 纺织业 > 针织或钩针编织物及其制品制造', 176, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (701, 694, '177', '家用纺织制成品制造', 3, '制造业 > 纺织业 > 家用纺织制成品制造', 177, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (702, 694, '178', '产业用纺织制成品制造', 3, '制造业 > 纺织业 > 产业用纺织制成品制造', 178, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (703, 663, '18', '纺织服装、服饰业', 2, '制造业 > 纺织服装、服饰业', 18, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (704, 703, '181', '机织服装制造', 3, '制造业 > 纺织服装、服饰业 > 机织服装制造', 181, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (705, 703, '182', '针织或钩针编织服装制造', 3, '制造业 > 纺织服装、服饰业 > 针织或钩针编织服装制造', 182, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (706, 703, '183', '服饰制造', 3, '制造业 > 纺织服装、服饰业 > 服饰制造', 183, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (707, 706, '1830', '服饰制造', 4, '制造业 > 纺织服装、服饰业 > 服饰制造', 1830, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (708, 663, '19', '皮革、毛皮、羽毛及其制品和制鞋业', 2, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业', 19, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (709, 708, '191', '皮革鞣制加工', 3, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 皮革鞣制加工', 191, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (710, 708, '192', '皮革制品制造', 3, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 皮革制品制造', 192, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (711, 708, '193', '毛皮鞣制及制品加工', 3, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 毛皮鞣制及制品加工', 193, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (712, 708, '194', '羽毛（绒）加工及制品制造', 3, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 羽毛（绒）加工及制品制造', 194, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (713, 708, '195', '制鞋业', 3, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 制鞋业', 195, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (714, 709, '1910', '皮革鞣制加工', 4, '制造业 > 皮革、毛皮、羽毛及其制品和制鞋业 > 皮革鞣制加工', 1910, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (715, 663, '20', '木材加工和木、竹、藤、棕、草制品业', 2, '制造业 > 木材加工和木、竹、藤、棕、草制品业', 20, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (716, 715, '201', '木材加工', 3, '制造业 > 木材加工和木、竹、藤、棕、草制品业 > 木材加工', 201, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (717, 715, '202', '人造板制造', 3, '制造业 > 木材加工和木、竹、藤、棕、草制品业 > 人造板制造', 202, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (718, 715, '203', '木质制品制造', 3, '制造业 > 木材加工和木、竹、藤、棕、草制品业 > 木质制品制造', 203, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (719, 715, '204', '竹、藤、棕、草等制品制造', 3, '制造业 > 木材加工和木、竹、藤、棕、草制品业 > 竹、藤、棕、草等制品制造', 204, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (720, 663, '21', '家具制造业', 2, '制造业 > 家具制造业', 21, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (721, 720, '211', '木质家具制造', 3, '制造业 > 家具制造业 > 木质家具制造', 211, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (722, 720, '212', '竹、藤家具制造', 3, '制造业 > 家具制造业 > 竹、藤家具制造', 212, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (723, 720, '213', '金属家具制造', 3, '制造业 > 家具制造业 > 金属家具制造', 213, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (724, 720, '214', '塑料家具制造', 3, '制造业 > 家具制造业 > 塑料家具制造', 214, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (725, 720, '219', '其他家具制造', 3, '制造业 > 家具制造业 > 其他家具制造', 219, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (726, 721, '2110', '木质家具制造', 4, '制造业 > 家具制造业 > 木质家具制造', 2110, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (727, 722, '2120', '竹、藤家具制造', 4, '制造业 > 家具制造业 > 竹、藤家具制造', 2120, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (728, 723, '2130', '金属家具制造', 4, '制造业 > 家具制造业 > 金属家具制造', 2130, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (729, 724, '2140', '塑料家具制造', 4, '制造业 > 家具制造业 > 塑料家具制造', 2140, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (730, 725, '2190', '其他家具制造', 4, '制造业 > 家具制造业 > 其他家具制造', 2190, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (731, 663, '22', '造纸和纸制品业', 2, '制造业 > 造纸和纸制品业', 22, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (732, 731, '221', '纸浆制造', 3, '制造业 > 造纸和纸制品业 > 纸浆制造', 221, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (733, 731, '222', '造纸', 3, '制造业 > 造纸和纸制品业 > 造纸', 222, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (734, 731, '223', '纸制品制造', 3, '制造业 > 造纸和纸制品业 > 纸制品制造', 223, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (735, 663, '23', '印刷和记录媒介复制业', 2, '制造业 > 印刷和记录媒介复制业', 23, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (736, 735, '231', '印刷', 3, '制造业 > 印刷和记录媒介复制业 > 印刷', 231, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (737, 735, '232', '装订及印刷相关服务', 3, '制造业 > 印刷和记录媒介复制业 > 装订及印刷相关服务', 232, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (738, 735, '233', '记录媒介复制', 3, '制造业 > 印刷和记录媒介复制业 > 记录媒介复制', 233, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (739, 737, '2320', '装订及印刷相关服务', 4, '制造业 > 印刷和记录媒介复制业 > 装订及印刷相关服务', 2320, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (740, 738, '2330', '记录媒介复制', 4, '制造业 > 印刷和记录媒介复制业 > 记录媒介复制', 2330, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (741, 663, '24', '文教、工美、体育和娱乐用品制造业', 2, '制造业 > 文教、工美、体育和娱乐用品制造业', 24, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (742, 741, '241', '文教办公用品制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 文教办公用品制造', 241, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (743, 741, '242', '乐器制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 乐器制造', 242, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (744, 741, '243', '工艺美术及礼仪用品制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 工艺美术及礼仪用品制造', 243, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (745, 741, '244', '体育用品制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 体育用品制造', 244, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (746, 741, '245', '玩具制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 玩具制造', 245, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (747, 741, '246', '游艺器材及娱乐用品制造', 3, '制造业 > 文教、工美、体育和娱乐用品制造业 > 游艺器材及娱乐用品制造', 246, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (748, 663, '25', '石油、煤炭及其他燃料加工业', 2, '制造业 > 石油、煤炭及其他燃料加工业', 25, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (749, 748, '251', '精炼石油产品制造', 3, '制造业 > 石油、煤炭及其他燃料加工业 > 精炼石油产品制造', 251, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (750, 748, '252', '煤炭加工', 3, '制造业 > 石油、煤炭及其他燃料加工业 > 煤炭加工', 252, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (751, 748, '253', '核燃料加工', 3, '制造业 > 石油、煤炭及其他燃料加工业 > 核燃料加工', 253, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (752, 748, '254', '生物质燃料加工', 3, '制造业 > 石油、煤炭及其他燃料加工业 > 生物质燃料加工', 254, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (753, 751, '2530', '核燃料加工', 4, '制造业 > 石油、煤炭及其他燃料加工业 > 核燃料加工', 2530, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (754, 663, '26', '化学原料和化学制品制造业', 2, '制造业 > 化学原料和化学制品制造业', 26, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (755, 754, '261', '基础化学原料制造', 3, '制造业 > 化学原料和化学制品制造业 > 基础化学原料制造', 261, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (756, 754, '262', '肥料制造', 3, '制造业 > 化学原料和化学制品制造业 > 肥料制造', 262, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (757, 754, '263', '农药制造', 3, '制造业 > 化学原料和化学制品制造业 > 农药制造', 263, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (758, 754, '264', '涂料、油墨、颜料及类似产品制造', 3, '制造业 > 化学原料和化学制品制造业 > 涂料、油墨、颜料及类似产品制造', 264, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (759, 754, '265', '合成材料制造', 3, '制造业 > 化学原料和化学制品制造业 > 合成材料制造', 265, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (760, 754, '266', '专用化学产品制造', 3, '制造业 > 化学原料和化学制品制造业 > 专用化学产品制造', 266, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (761, 754, '267', '炸药、火工及焰火产品制造', 3, '制造业 > 化学原料和化学制品制造业 > 炸药、火工及焰火产品制造', 267, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (762, 754, '268', '日用化学产品制造', 3, '制造业 > 化学原料和化学制品制造业 > 日用化学产品制造', 268, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (763, 663, '27', '医药制造业', 2, '制造业 > 医药制造业', 27, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (764, 763, '271', '化学药品原料药制造', 3, '制造业 > 医药制造业 > 化学药品原料药制造', 271, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (765, 763, '272', '化学药品制剂制造', 3, '制造业 > 医药制造业 > 化学药品制剂制造', 272, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (766, 763, '273', '中药饮片加工', 3, '制造业 > 医药制造业 > 中药饮片加工', 273, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (767, 763, '274', '中成药生产', 3, '制造业 > 医药制造业 > 中成药生产', 274, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (768, 763, '275', '兽用药品制造', 3, '制造业 > 医药制造业 > 兽用药品制造', 275, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (769, 763, '276', '生物药品制品制造', 3, '制造业 > 医药制造业 > 生物药品制品制造', 276, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (770, 763, '277', '卫生材料及医药用品制造', 3, '制造业 > 医药制造业 > 卫生材料及医药用品制造', 277, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (771, 763, '278', '药用辅料及包装材料制造', 3, '制造业 > 医药制造业 > 药用辅料及包装材料制造', 278, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (772, 764, '2710', '化学药品原料药制造', 4, '制造业 > 医药制造业 > 化学药品原料药制造', 2710, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (773, 765, '2720', '化学药品制剂制造', 4, '制造业 > 医药制造业 > 化学药品制剂制造', 2720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (774, 766, '2730', '中药饮片加工', 4, '制造业 > 医药制造业 > 中药饮片加工', 2730, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (775, 767, '2740', '中成药生产', 4, '制造业 > 医药制造业 > 中成药生产', 2740, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (776, 768, '2750', '兽用药品制造', 4, '制造业 > 医药制造业 > 兽用药品制造', 2750, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (777, 770, '2770', '卫生材料及医药用品制造', 4, '制造业 > 医药制造业 > 卫生材料及医药用品制造', 2770, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (778, 771, '2780', '药用辅料及包装材料制造', 4, '制造业 > 医药制造业 > 药用辅料及包装材料制造', 2780, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (779, 663, '28', '化学纤维制造业', 2, '制造业 > 化学纤维制造业', 28, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (780, 779, '281', '纤维素纤维原料及纤维制造', 3, '制造业 > 化学纤维制造业 > 纤维素纤维原料及纤维制造', 281, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (781, 779, '282', '合成纤维制造', 3, '制造业 > 化学纤维制造业 > 合成纤维制造', 282, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (782, 779, '283', '生物基材料制造', 3, '制造业 > 化学纤维制造业 > 生物基材料制造', 283, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (783, 663, '29', '橡胶和塑料制品业', 2, '制造业 > 橡胶和塑料制品业', 29, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (784, 783, '291', '橡胶制品业', 3, '制造业 > 橡胶和塑料制品业 > 橡胶制品业', 291, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (785, 783, '292', '塑料制品业', 3, '制造业 > 橡胶和塑料制品业 > 塑料制品业', 292, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (786, 663, '30', '非金属矿物制品业', 2, '制造业 > 非金属矿物制品业', 30, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (787, 786, '301', '水泥、石灰和石膏制造', 3, '制造业 > 非金属矿物制品业 > 水泥、石灰和石膏制造', 301, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (788, 786, '302', '石膏、水泥制品及类似制品制造', 3, '制造业 > 非金属矿物制品业 > 石膏、水泥制品及类似制品制造', 302, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (789, 786, '303', '砖瓦、石材等建筑材料制造', 3, '制造业 > 非金属矿物制品业 > 砖瓦、石材等建筑材料制造', 303, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (790, 786, '304', '玻璃制造', 3, '制造业 > 非金属矿物制品业 > 玻璃制造', 304, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (791, 786, '305', '玻璃制品制造', 3, '制造业 > 非金属矿物制品业 > 玻璃制品制造', 305, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (792, 786, '306', '玻璃纤维和玻璃纤维增强塑料制品制造', 3, '制造业 > 非金属矿物制品业 > 玻璃纤维和玻璃纤维增强塑料制品制造', 306, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (793, 786, '307', '陶瓷制品制造', 3, '制造业 > 非金属矿物制品业 > 陶瓷制品制造', 307, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (794, 786, '308', '耐火材料制品制造', 3, '制造业 > 非金属矿物制品业 > 耐火材料制品制造', 308, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (795, 786, '309', '石墨及其他非金属矿物制品制造', 3, '制造业 > 非金属矿物制品业 > 石墨及其他非金属矿物制品制造', 309, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (796, 663, '31', '黑色金属冶炼和压延加工业', 2, '制造业 > 黑色金属冶炼和压延加工业', 31, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (797, 796, '311', '炼铁', 3, '制造业 > 黑色金属冶炼和压延加工业 > 炼铁', 311, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (798, 796, '312', '炼钢', 3, '制造业 > 黑色金属冶炼和压延加工业 > 炼钢', 312, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (799, 796, '313', '钢压延加工', 3, '制造业 > 黑色金属冶炼和压延加工业 > 钢压延加工', 313, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (800, 796, '314', '铁合金冶炼', 3, '制造业 > 黑色金属冶炼和压延加工业 > 铁合金冶炼', 314, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (801, 797, '3110', '炼铁', 4, '制造业 > 黑色金属冶炼和压延加工业 > 炼铁', 3110, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (802, 798, '3120', '炼钢', 4, '制造业 > 黑色金属冶炼和压延加工业 > 炼钢', 3120, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (803, 799, '3130', '钢压延加工', 4, '制造业 > 黑色金属冶炼和压延加工业 > 钢压延加工', 3130, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (804, 800, '3140', '铁合金冶炼', 4, '制造业 > 黑色金属冶炼和压延加工业 > 铁合金冶炼', 3140, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (805, 663, '32', '有色金属冶炼和压延加工业', 2, '制造业 > 有色金属冶炼和压延加工业', 32, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (806, 805, '321', '常用有色金属冶炼', 3, '制造业 > 有色金属冶炼和压延加工业 > 常用有色金属冶炼', 321, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (807, 805, '322', '贵金属冶炼', 3, '制造业 > 有色金属冶炼和压延加工业 > 贵金属冶炼', 322, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (808, 805, '323', '稀有稀土金属冶炼', 3, '制造业 > 有色金属冶炼和压延加工业 > 稀有稀土金属冶炼', 323, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (809, 805, '324', '有色金属合金制造', 3, '制造业 > 有色金属冶炼和压延加工业 > 有色金属合金制造', 324, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (810, 805, '325', '有色金属压延加工', 3, '制造业 > 有色金属冶炼和压延加工业 > 有色金属压延加工', 325, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (811, 809, '3240', '有色金属合金制造', 4, '制造业 > 有色金属冶炼和压延加工业 > 有色金属合金制造', 3240, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (812, 663, '33', '金属制品业', 2, '制造业 > 金属制品业', 33, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (813, 812, '331', '结构性金属制品制造', 3, '制造业 > 金属制品业 > 结构性金属制品制造', 331, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (814, 812, '332', '金属工具制造', 3, '制造业 > 金属制品业 > 金属工具制造', 332, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (815, 812, '333', '集装箱及金属包装容器制造', 3, '制造业 > 金属制品业 > 集装箱及金属包装容器制造', 333, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (816, 812, '334', '金属丝绳及其制品制造', 3, '制造业 > 金属制品业 > 金属丝绳及其制品制造', 334, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (817, 812, '335', '建筑、安全用金属制品制造', 3, '制造业 > 金属制品业 > 建筑、安全用金属制品制造', 335, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (818, 812, '336', '金属表面处理及热处理加工', 3, '制造业 > 金属制品业 > 金属表面处理及热处理加工', 336, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (819, 812, '337', '搪瓷制品制造', 3, '制造业 > 金属制品业 > 搪瓷制品制造', 337, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (820, 812, '338', '金属制日用品制造', 3, '制造业 > 金属制品业 > 金属制日用品制造', 338, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (821, 812, '339', '铸造及其他金属制品制造', 3, '制造业 > 金属制品业 > 铸造及其他金属制品制造', 339, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (822, 816, '3340', '金属丝绳及其制品制造', 4, '制造业 > 金属制品业 > 金属丝绳及其制品制造', 3340, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (823, 818, '3360', '金属表面处理及热处理加工', 4, '制造业 > 金属制品业 > 金属表面处理及热处理加工', 3360, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (824, 663, '34', '通用设备制造业', 2, '制造业 > 通用设备制造业', 34, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (825, 824, '341', '锅炉及原动设备制造', 3, '制造业 > 通用设备制造业 > 锅炉及原动设备制造', 341, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (826, 824, '342', '金属加工机械制造', 3, '制造业 > 通用设备制造业 > 金属加工机械制造', 342, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (827, 824, '343', '物料搬运设备制造', 3, '制造业 > 通用设备制造业 > 物料搬运设备制造', 343, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (828, 824, '344', '泵、阀门、压缩机及类似机械制造', 3, '制造业 > 通用设备制造业 > 泵、阀门、压缩机及类似机械制造', 344, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (829, 824, '345', '轴承、齿轮和传动部件制造', 3, '制造业 > 通用设备制造业 > 轴承、齿轮和传动部件制造', 345, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (830, 824, '346', '烘炉、风机、包装等设备制造', 3, '制造业 > 通用设备制造业 > 烘炉、风机、包装等设备制造', 346, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (831, 824, '347', '文化、办公用机械制造', 3, '制造业 > 通用设备制造业 > 文化、办公用机械制造', 347, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (832, 824, '348', '通用零部件制造', 3, '制造业 > 通用设备制造业 > 通用零部件制造', 348, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (833, 824, '349', '其他通用设备制造业', 3, '制造业 > 通用设备制造业 > 其他通用设备制造业', 349, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (834, 663, '35', '专用设备制造业', 2, '制造业 > 专用设备制造业', 35, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (835, 834, '351', '采矿、冶金、建筑专用设备制造', 3, '制造业 > 专用设备制造业 > 采矿、冶金、建筑专用设备制造', 351, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (836, 834, '352', '化工、木材、非金属加工专用设备制造', 3, '制造业 > 专用设备制造业 > 化工、木材、非金属加工专用设备制造', 352, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (837, 834, '353', '食品、饮料、烟草及饲料生产专用设备制造', 3, '制造业 > 专用设备制造业 > 食品、饮料、烟草及饲料生产专用设备制造', 353, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (838, 834, '354', '印刷、制药、日化及日用品生产专用设备制造', 3, '制造业 > 专用设备制造业 > 印刷、制药、日化及日用品生产专用设备制造', 354, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (839, 834, '355', '纺织、服装和皮革加工专用设备制造', 3, '制造业 > 专用设备制造业 > 纺织、服装和皮革加工专用设备制造', 355, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (840, 834, '356', '电子和电工机械专用设备制造', 3, '制造业 > 专用设备制造业 > 电子和电工机械专用设备制造', 356, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (841, 834, '357', '农、林、牧、渔专用机械制造', 3, '制造业 > 专用设备制造业 > 农、林、牧、渔专用机械制造', 357, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (842, 834, '358', '医疗仪器设备及器械制造', 3, '制造业 > 专用设备制造业 > 医疗仪器设备及器械制造', 358, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (843, 834, '359', '环保、邮政、社会公共服务及其他专用设备制造', 3, '制造业 > 专用设备制造业 > 环保、邮政、社会公共服务及其他专用设备制造', 359, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (844, 663, '36', '汽车制造业', 2, '制造业 > 汽车制造业', 36, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (845, 844, '361', '汽车整车制造', 3, '制造业 > 汽车制造业 > 汽车整车制造', 361, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (846, 844, '362', '汽车用发动机制造', 3, '制造业 > 汽车制造业 > 汽车用发动机制造', 362, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (847, 844, '363', '改装汽车制造', 3, '制造业 > 汽车制造业 > 改装汽车制造', 363, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (848, 844, '364', '低速汽车制造', 3, '制造业 > 汽车制造业 > 低速汽车制造', 364, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (849, 844, '365', '电车制造', 3, '制造业 > 汽车制造业 > 电车制造', 365, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (850, 844, '366', '汽车车身、挂车制造', 3, '制造业 > 汽车制造业 > 汽车车身、挂车制造', 366, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (851, 844, '367', '汽车零部件及配件制造', 3, '制造业 > 汽车制造业 > 汽车零部件及配件制造', 367, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (852, 846, '3620', '汽车用发动机制造', 4, '制造业 > 汽车制造业 > 汽车用发动机制造', 3620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (853, 847, '3630', '改装汽车制造', 4, '制造业 > 汽车制造业 > 改装汽车制造', 3630, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (854, 848, '3640', '低速汽车制造', 4, '制造业 > 汽车制造业 > 低速汽车制造', 3640, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (855, 849, '3650', '电车制造', 4, '制造业 > 汽车制造业 > 电车制造', 3650, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (856, 850, '3660', '汽车车身、挂车制造', 4, '制造业 > 汽车制造业 > 汽车车身、挂车制造', 3660, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (857, 851, '3670', '汽车零部件及配件制造', 4, '制造业 > 汽车制造业 > 汽车零部件及配件制造', 3670, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (858, 663, '37', '铁路、船舶、航空航天和其他运输设备制造业', 2, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业', 37, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (859, 858, '371', '铁路运输设备制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 铁路运输设备制造', 371, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (860, 858, '372', '城市轨道交通设备制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 城市轨道交通设备制造', 372, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (861, 858, '373', '船舶及相关装置制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 船舶及相关装置制造', 373, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (862, 858, '374', '航空、航天器及设备制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 航空、航天器及设备制造', 374, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (863, 858, '375', '摩托车制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 摩托车制造', 375, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (864, 858, '376', '自行车和残疾人座车制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 自行车和残疾人座车制造', 376, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (865, 858, '377', '助动车制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 助动车制造', 377, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (866, 858, '378', '非公路休闲车及零配件制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 非公路休闲车及零配件制造', 378, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (867, 858, '379', '潜水救捞及其他未列明运输设备制造', 3, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 潜水救捞及其他未列明运输设备制造', 379, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (868, 860, '3720', '城市轨道交通设备制造', 4, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 城市轨道交通设备制造', 3720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (869, 865, '3770', '助动车制造', 4, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 助动车制造', 3770, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (870, 866, '3780', '非公路休闲车及零配件制造', 4, '制造业 > 铁路、船舶、航空航天和其他运输设备制造业 > 非公路休闲车及零配件制造', 3780, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (871, 663, '38', '电气机械和器材制造业', 2, '制造业 > 电气机械和器材制造业', 38, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (872, 871, '381', '电机制造', 3, '制造业 > 电气机械和器材制造业 > 电机制造', 381, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (873, 871, '382', '输配电及控制设备制造', 3, '制造业 > 电气机械和器材制造业 > 输配电及控制设备制造', 382, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (874, 871, '383', '电线、电缆、光缆及电工器材制造', 3, '制造业 > 电气机械和器材制造业 > 电线、电缆、光缆及电工器材制造', 383, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (875, 871, '384', '电池制造', 3, '制造业 > 电气机械和器材制造业 > 电池制造', 384, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (876, 871, '385', '家用电力器具制造', 3, '制造业 > 电气机械和器材制造业 > 家用电力器具制造', 385, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (877, 871, '386', '非电力家用器具制造', 3, '制造业 > 电气机械和器材制造业 > 非电力家用器具制造', 386, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (878, 871, '387', '照明器具制造', 3, '制造业 > 电气机械和器材制造业 > 照明器具制造', 387, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (879, 871, '389', '其他电气机械及器材制造', 3, '制造业 > 电气机械和器材制造业 > 其他电气机械及器材制造', 389, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (880, 663, '39', '计算机、通信和其他电子设备制造业', 2, '制造业 > 计算机、通信和其他电子设备制造业', 39, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (881, 880, '391', '计算机制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 计算机制造', 391, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (882, 880, '392', '通信设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 通信设备制造', 392, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (883, 880, '393', '广播电视设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 广播电视设备制造', 393, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (884, 880, '394', '雷达及配套设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 雷达及配套设备制造', 394, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (885, 880, '395', '非专业视听设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 非专业视听设备制造', 395, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (886, 880, '396', '智能消费设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 智能消费设备制造', 396, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (887, 880, '397', '电子器件制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 电子器件制造', 397, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (888, 880, '398', '电子元件及电子专用材料制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 电子元件及电子专用材料制造', 398, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (889, 880, '399', '其他电子设备制造', 3, '制造业 > 计算机、通信和其他电子设备制造业 > 其他电子设备制造', 399, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (890, 884, '3940', '雷达及配套设备制造', 4, '制造业 > 计算机、通信和其他电子设备制造业 > 雷达及配套设备制造', 3940, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (891, 889, '3990', '其他电子设备制造', 4, '制造业 > 计算机、通信和其他电子设备制造业 > 其他电子设备制造', 3990, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (892, 663, '40', '仪器仪表制造业', 2, '制造业 > 仪器仪表制造业', 40, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (893, 892, '401', '通用仪器仪表制造', 3, '制造业 > 仪器仪表制造业 > 通用仪器仪表制造', 401, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (894, 892, '402', '专用仪器仪表制造', 3, '制造业 > 仪器仪表制造业 > 专用仪器仪表制造', 402, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (895, 892, '403', '钟表与计时仪器制造', 3, '制造业 > 仪器仪表制造业 > 钟表与计时仪器制造', 403, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (896, 892, '404', '光学仪器制造', 3, '制造业 > 仪器仪表制造业 > 光学仪器制造', 404, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (897, 892, '405', '衡器制造', 3, '制造业 > 仪器仪表制造业 > 衡器制造', 405, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (898, 892, '409', '其他仪器仪表制造业', 3, '制造业 > 仪器仪表制造业 > 其他仪器仪表制造业', 409, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (899, 895, '4030', '钟表与计时仪器制造', 4, '制造业 > 仪器仪表制造业 > 钟表与计时仪器制造', 4030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (900, 896, '4040', '光学仪器制造', 4, '制造业 > 仪器仪表制造业 > 光学仪器制造', 4040, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (901, 897, '4050', '衡器制造', 4, '制造业 > 仪器仪表制造业 > 衡器制造', 4050, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (902, 898, '4090', '其他仪器仪表制造业', 4, '制造业 > 仪器仪表制造业 > 其他仪器仪表制造业', 4090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (903, 663, '41', '其他制造业', 2, '制造业 > 其他制造业', 41, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (904, 903, '411', '日用杂品制造', 3, '制造业 > 其他制造业 > 日用杂品制造', 411, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (905, 903, '412', '核辐射加工', 3, '制造业 > 其他制造业 > 核辐射加工', 412, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (906, 903, '419', '其他未列明制造业', 3, '制造业 > 其他制造业 > 其他未列明制造业', 419, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (907, 905, '4120', '核辐射加工', 4, '制造业 > 其他制造业 > 核辐射加工', 4120, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (908, 906, '4190', '其他未列明制造业', 4, '制造业 > 其他制造业 > 其他未列明制造业', 4190, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (909, 663, '42', '废弃资源综合利用业', 2, '制造业 > 废弃资源综合利用业', 42, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (910, 909, '421', '金属废料和碎屑加工处理', 3, '制造业 > 废弃资源综合利用业 > 金属废料和碎屑加工处理', 421, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (911, 909, '422', '非金属废料和碎屑加工处理', 3, '制造业 > 废弃资源综合利用业 > 非金属废料和碎屑加工处理', 422, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (912, 910, '4210', '金属废料和碎屑加工处理', 4, '制造业 > 废弃资源综合利用业 > 金属废料和碎屑加工处理', 4210, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (913, 911, '4220', '非金属废料和碎屑加工处理', 4, '制造业 > 废弃资源综合利用业 > 非金属废料和碎屑加工处理', 4220, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (914, 663, '43', '金属制品、机械和设备修理业', 2, '制造业 > 金属制品、机械和设备修理业', 43, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (915, 914, '431', '金属制品修理', 3, '制造业 > 金属制品、机械和设备修理业 > 金属制品修理', 431, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (916, 914, '432', '通用设备修理', 3, '制造业 > 金属制品、机械和设备修理业 > 通用设备修理', 432, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (917, 914, '433', '专用设备修理', 3, '制造业 > 金属制品、机械和设备修理业 > 专用设备修理', 433, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (918, 914, '434', '铁路、船舶、航空航天等运输设备修理', 3, '制造业 > 金属制品、机械和设备修理业 > 铁路、船舶、航空航天等运输设备修理', 434, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (919, 914, '435', '电气设备修理', 3, '制造业 > 金属制品、机械和设备修理业 > 电气设备修理', 435, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (920, 914, '436', '仪器仪表修理', 3, '制造业 > 金属制品、机械和设备修理业 > 仪器仪表修理', 436, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (921, 914, '439', '其他机械和设备修理业', 3, '制造业 > 金属制品、机械和设备修理业 > 其他机械和设备修理业', 439, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (922, 915, '4310', '金属制品修理', 4, '制造业 > 金属制品、机械和设备修理业 > 金属制品修理', 4310, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (923, 916, '4320', '通用设备修理', 4, '制造业 > 金属制品、机械和设备修理业 > 通用设备修理', 4320, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (924, 917, '4330', '专用设备修理', 4, '制造业 > 金属制品、机械和设备修理业 > 专用设备修理', 4330, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (925, 919, '4350', '电气设备修理', 4, '制造业 > 金属制品、机械和设备修理业 > 电气设备修理', 4350, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (926, 920, '4360', '仪器仪表修理', 4, '制造业 > 金属制品、机械和设备修理业 > 仪器仪表修理', 4360, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (927, 921, '4390', '其他机械和设备修理业', 4, '制造业 > 金属制品、机械和设备修理业 > 其他机械和设备修理业', 4390, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (928, 0, 'D', '电力、热力、燃气及水生产和供应业', 1, '电力、热力、燃气及水生产和供应业', 4, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (929, 928, '44', '电力、热力生产和供应业', 2, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业', 44, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (930, 929, '441', '电力生产', 3, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业 > 电力生产', 441, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (931, 929, '442', '电力供应', 3, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业 > 电力供应', 442, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (932, 929, '443', '热力生产和供应', 3, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业 > 热力生产和供应', 443, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (933, 931, '4420', '电力供应', 4, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业 > 电力供应', 4420, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (934, 932, '4430', '热力生产和供应', 4, '电力、热力、燃气及水生产和供应业 > 电力、热力生产和供应业 > 热力生产和供应', 4430, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (935, 928, '45', '燃气生产和供应业', 2, '电力、热力、燃气及水生产和供应业 > 燃气生产和供应业', 45, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (936, 935, '451', '燃气生产和供应业', 3, '电力、热力、燃气及水生产和供应业 > 燃气生产和供应业 > 燃气生产和供应业', 451, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (937, 935, '452', '生物质燃气生产和供应业', 3, '电力、热力、燃气及水生产和供应业 > 燃气生产和供应业 > 生物质燃气生产和供应业', 452, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (938, 937, '4520', '生物质燃气生产和供应业', 4, '电力、热力、燃气及水生产和供应业 > 燃气生产和供应业 > 生物质燃气生产和供应业', 4520, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (939, 928, '46', '水的生产和供应业', 2, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业', 46, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (940, 939, '461', '自来水生产和供应', 3, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 自来水生产和供应', 461, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (941, 939, '462', '污水处理及其再生利用', 3, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 污水处理及其再生利用', 462, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (942, 939, '463', '海水淡化处理', 3, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 海水淡化处理', 463, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (943, 939, '469', '其他水的处理、利用与分配', 3, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 其他水的处理、利用与分配', 469, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (944, 940, '4610', '自来水生产和供应', 4, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 自来水生产和供应', 4610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (945, 941, '4620', '污水处理及其再生利用', 4, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 污水处理及其再生利用', 4620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (946, 942, '4630', '海水淡化处理', 4, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 海水淡化处理', 4630, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (947, 943, '4690', '其他水的处理、利用与分配', 4, '电力、热力、燃气及水生产和供应业 > 水的生产和供应业 > 其他水的处理、利用与分配', 4690, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (948, 0, 'E', '建筑业', 1, '建筑业', 5, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (949, 948, '47', '房屋建筑业', 2, '建筑业 > 房屋建筑业', 47, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (950, 949, '471', '住宅房屋建筑', 3, '建筑业 > 房屋建筑业 > 住宅房屋建筑', 471, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (951, 949, '472', '体育场馆建筑', 3, '建筑业 > 房屋建筑业 > 体育场馆建筑', 472, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (952, 949, '479', '其他房屋建筑业', 3, '建筑业 > 房屋建筑业 > 其他房屋建筑业', 479, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (953, 950, '4710', '住宅房屋建筑', 4, '建筑业 > 房屋建筑业 > 住宅房屋建筑', 4710, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (954, 951, '4720', '体育场馆建筑', 4, '建筑业 > 房屋建筑业 > 体育场馆建筑', 4720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (955, 952, '4790', '其他房屋建筑业', 4, '建筑业 > 房屋建筑业 > 其他房屋建筑业', 4790, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (956, 948, '48', '土木工程建筑业', 2, '建筑业 > 土木工程建筑业', 48, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (957, 956, '481', '铁路、道路、隧道和桥梁工程建筑', 3, '建筑业 > 土木工程建筑业 > 铁路、道路、隧道和桥梁工程建筑', 481, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (958, 956, '482', '水利和水运工程建筑', 3, '建筑业 > 土木工程建筑业 > 水利和水运工程建筑', 482, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (959, 956, '483', '海洋工程建筑', 3, '建筑业 > 土木工程建筑业 > 海洋工程建筑', 483, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (960, 956, '484', '工矿工程建筑', 3, '建筑业 > 土木工程建筑业 > 工矿工程建筑', 484, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (961, 956, '485', '架线和管道工程建筑', 3, '建筑业 > 土木工程建筑业 > 架线和管道工程建筑', 485, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (962, 956, '486', '节能环保工程施工', 3, '建筑业 > 土木工程建筑业 > 节能环保工程施工', 486, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (963, 956, '487', '电力工程施工', 3, '建筑业 > 土木工程建筑业 > 电力工程施工', 487, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (964, 956, '489', '其他土木工程建筑', 3, '建筑业 > 土木工程建筑业 > 其他土木工程建筑', 489, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (965, 960, '4840', '工矿工程建筑', 4, '建筑业 > 土木工程建筑业 > 工矿工程建筑', 4840, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (966, 948, '49', '建筑安装业', 2, '建筑业 > 建筑安装业', 49, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (967, 966, '491', '电气安装', 3, '建筑业 > 建筑安装业 > 电气安装', 491, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (968, 966, '492', '管道和设备安装', 3, '建筑业 > 建筑安装业 > 管道和设备安装', 492, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (969, 966, '499', '其他建筑安装业', 3, '建筑业 > 建筑安装业 > 其他建筑安装业', 499, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (970, 967, '4910', '电气安装', 4, '建筑业 > 建筑安装业 > 电气安装', 4910, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (971, 968, '4920', '管道和设备安装', 4, '建筑业 > 建筑安装业 > 管道和设备安装', 4920, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (972, 948, '50', '建筑装饰、装修和其他建筑业', 2, '建筑业 > 建筑装饰、装修和其他建筑业', 50, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (973, 972, '501', '建筑装饰和装修业', 3, '建筑业 > 建筑装饰、装修和其他建筑业 > 建筑装饰和装修业', 501, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (974, 972, '502', '建筑物拆除和场地准备活动', 3, '建筑业 > 建筑装饰、装修和其他建筑业 > 建筑物拆除和场地准备活动', 502, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (975, 972, '503', '提供施工设备服务', 3, '建筑业 > 建筑装饰、装修和其他建筑业 > 提供施工设备服务', 503, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (976, 972, '509', '其他未列明建筑业', 3, '建筑业 > 建筑装饰、装修和其他建筑业 > 其他未列明建筑业', 509, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (977, 975, '5030', '提供施工设备服务', 4, '建筑业 > 建筑装饰、装修和其他建筑业 > 提供施工设备服务', 5030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (978, 976, '5090', '其他未列明建筑业', 4, '建筑业 > 建筑装饰、装修和其他建筑业 > 其他未列明建筑业', 5090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (979, 0, 'F', '批发和零售业', 1, '批发和零售业', 6, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (980, 979, '51', '批发业', 2, '批发和零售业 > 批发业', 51, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (981, 980, '511', '农、林、牧、渔产品批发', 3, '批发和零售业 > 批发业 > 农、林、牧、渔产品批发', 511, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (982, 980, '512', '食品、饮料及烟草制品批发', 3, '批发和零售业 > 批发业 > 食品、饮料及烟草制品批发', 512, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (983, 980, '513', '纺织、服装及家庭用品批发', 3, '批发和零售业 > 批发业 > 纺织、服装及家庭用品批发', 513, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (984, 980, '514', '文化、体育用品及器材批发', 3, '批发和零售业 > 批发业 > 文化、体育用品及器材批发', 514, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (985, 980, '515', '医药及医疗器材批发', 3, '批发和零售业 > 批发业 > 医药及医疗器材批发', 515, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (986, 980, '516', '矿产品、建材及化工产品批发', 3, '批发和零售业 > 批发业 > 矿产品、建材及化工产品批发', 516, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (987, 980, '517', '机械设备、五金产品及电子产品批发', 3, '批发和零售业 > 批发业 > 机械设备、五金产品及电子产品批发', 517, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (988, 980, '518', '贸易经纪与代理', 3, '批发和零售业 > 批发业 > 贸易经纪与代理', 518, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (989, 980, '519', '其他批发业', 3, '批发和零售业 > 批发业 > 其他批发业', 519, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (990, 979, '52', '零售业', 2, '批发和零售业 > 零售业', 52, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (991, 990, '521', '综合零售', 3, '批发和零售业 > 零售业 > 综合零售', 521, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (992, 990, '522', '食品、饮料及烟草制品专门零售', 3, '批发和零售业 > 零售业 > 食品、饮料及烟草制品专门零售', 522, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (993, 990, '523', '纺织、服装及日用品专门零售', 3, '批发和零售业 > 零售业 > 纺织、服装及日用品专门零售', 523, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (994, 990, '524', '文化、体育用品及器材专门零售', 3, '批发和零售业 > 零售业 > 文化、体育用品及器材专门零售', 524, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (995, 990, '525', '医药及医疗器材专门零售', 3, '批发和零售业 > 零售业 > 医药及医疗器材专门零售', 525, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (996, 990, '526', '汽车、摩托车、零配件和燃料及其他动力销售', 3, '批发和零售业 > 零售业 > 汽车、摩托车、零配件和燃料及其他动力销售', 526, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (997, 990, '527', '家用电器及电子产品专门零售', 3, '批发和零售业 > 零售业 > 家用电器及电子产品专门零售', 527, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (998, 990, '528', '五金、家具及室内装饰材料专门零售', 3, '批发和零售业 > 零售业 > 五金、家具及室内装饰材料专门零售', 528, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (999, 990, '529', '货摊、无店铺及其他零售业', 3, '批发和零售业 > 零售业 > 货摊、无店铺及其他零售业', 529, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1000, 0, 'G', '交通运输、仓储和邮政业', 1, '交通运输、仓储和邮政业', 7, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1001, 1000, '53', '铁路运输业', 2, '交通运输、仓储和邮政业 > 铁路运输业', 53, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1002, 1001, '531', '铁路旅客运输', 3, '交通运输、仓储和邮政业 > 铁路运输业 > 铁路旅客运输', 531, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1003, 1001, '532', '铁路货物运输', 3, '交通运输、仓储和邮政业 > 铁路运输业 > 铁路货物运输', 532, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1004, 1001, '533', '铁路运输辅助活动', 3, '交通运输、仓储和邮政业 > 铁路运输业 > 铁路运输辅助活动', 533, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1005, 1003, '5320', '铁路货物运输', 4, '交通运输、仓储和邮政业 > 铁路运输业 > 铁路货物运输', 5320, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1006, 1000, '54', '道路运输业', 2, '交通运输、仓储和邮政业 > 道路运输业', 54, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1007, 1006, '541', '城市公共交通运输', 3, '交通运输、仓储和邮政业 > 道路运输业 > 城市公共交通运输', 541, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1008, 1006, '542', '公路旅客运输', 3, '交通运输、仓储和邮政业 > 道路运输业 > 公路旅客运输', 542, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1009, 1006, '543', '道路货物运输', 3, '交通运输、仓储和邮政业 > 道路运输业 > 道路货物运输', 543, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1010, 1006, '544', '道路运输辅助活动', 3, '交通运输、仓储和邮政业 > 道路运输业 > 道路运输辅助活动', 544, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1011, 1000, '55', '水上运输业', 2, '交通运输、仓储和邮政业 > 水上运输业', 55, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1012, 1011, '551', '水上旅客运输', 3, '交通运输、仓储和邮政业 > 水上运输业 > 水上旅客运输', 551, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1013, 1011, '552', '水上货物运输', 3, '交通运输、仓储和邮政业 > 水上运输业 > 水上货物运输', 552, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1014, 1011, '553', '水上运输辅助活动', 3, '交通运输、仓储和邮政业 > 水上运输业 > 水上运输辅助活动', 553, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1015, 1000, '56', '航空运输业', 2, '交通运输、仓储和邮政业 > 航空运输业', 56, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1016, 1015, '561', '航空客货运输', 3, '交通运输、仓储和邮政业 > 航空运输业 > 航空客货运输', 561, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1017, 1015, '562', '通用航空服务', 3, '交通运输、仓储和邮政业 > 航空运输业 > 通用航空服务', 562, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1018, 1015, '563', '航空运输辅助活动', 3, '交通运输、仓储和邮政业 > 航空运输业 > 航空运输辅助活动', 563, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1019, 1000, '57', '管道运输业', 2, '交通运输、仓储和邮政业 > 管道运输业', 57, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1020, 1019, '571', '海底管道运输', 3, '交通运输、仓储和邮政业 > 管道运输业 > 海底管道运输', 571, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1021, 1019, '572', '陆地管道运输', 3, '交通运输、仓储和邮政业 > 管道运输业 > 陆地管道运输', 572, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1022, 1020, '5710', '海底管道运输', 4, '交通运输、仓储和邮政业 > 管道运输业 > 海底管道运输', 5710, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1023, 1021, '5720', '陆地管道运输', 4, '交通运输、仓储和邮政业 > 管道运输业 > 陆地管道运输', 5720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1024, 1000, '58', '多式联运和运输代理业', 2, '交通运输、仓储和邮政业 > 多式联运和运输代理业', 58, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1025, 1024, '581', '多式联运', 3, '交通运输、仓储和邮政业 > 多式联运和运输代理业 > 多式联运', 581, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1026, 1024, '582', '运输代理业', 3, '交通运输、仓储和邮政业 > 多式联运和运输代理业 > 运输代理业', 582, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1027, 1025, '5810', '多式联运', 4, '交通运输、仓储和邮政业 > 多式联运和运输代理业 > 多式联运', 5810, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1028, 1000, '59', '装卸搬运和仓储业', 2, '交通运输、仓储和邮政业 > 装卸搬运和仓储业', 59, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1029, 1028, '591', '装卸搬运', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 装卸搬运', 591, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1030, 1028, '592', '通用仓储', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 通用仓储', 592, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1031, 1028, '593', '低温仓储', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 低温仓储', 593, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1032, 1028, '594', '危险品仓储', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 危险品仓储', 594, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1033, 1028, '595', '谷物、棉花等农产品仓储', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 谷物、棉花等农产品仓储', 595, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1034, 1028, '596', '中药材仓储', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 中药材仓储', 596, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1035, 1028, '599', '其他仓储业', 3, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 其他仓储业', 599, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1036, 1029, '5910', '装卸搬运', 4, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 装卸搬运', 5910, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1037, 1030, '5920', '通用仓储', 4, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 通用仓储', 5920, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1038, 1031, '5930', '低温仓储', 4, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 低温仓储', 5930, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1039, 1034, '5960', '中药材仓储', 4, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 中药材仓储', 5960, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1040, 1035, '5990', '其他仓储业', 4, '交通运输、仓储和邮政业 > 装卸搬运和仓储业 > 其他仓储业', 5990, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1041, 1000, '60', '邮政业', 2, '交通运输、仓储和邮政业 > 邮政业', 60, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1042, 1041, '601', '邮政基本服务', 3, '交通运输、仓储和邮政业 > 邮政业 > 邮政基本服务', 601, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1043, 1041, '602', '快递服务', 3, '交通运输、仓储和邮政业 > 邮政业 > 快递服务', 602, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1044, 1041, '609', '其他寄递服务', 3, '交通运输、仓储和邮政业 > 邮政业 > 其他寄递服务', 609, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1045, 1042, '6010', '邮政基本服务', 4, '交通运输、仓储和邮政业 > 邮政业 > 邮政基本服务', 6010, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1046, 1043, '6020', '快递服务', 4, '交通运输、仓储和邮政业 > 邮政业 > 快递服务', 6020, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1047, 1044, '6090', '其他寄递服务', 4, '交通运输、仓储和邮政业 > 邮政业 > 其他寄递服务', 6090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1048, 0, 'H', '住宿和餐饮业', 1, '住宿和餐饮业', 8, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1049, 1048, '61', '住宿业', 2, '住宿和餐饮业 > 住宿业', 61, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1050, 1049, '611', '旅游饭店', 3, '住宿和餐饮业 > 住宿业 > 旅游饭店', 611, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1051, 1049, '612', '一般旅馆', 3, '住宿和餐饮业 > 住宿业 > 一般旅馆', 612, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1052, 1049, '613', '民宿服务', 3, '住宿和餐饮业 > 住宿业 > 民宿服务', 613, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1053, 1049, '614', '露营地服务', 3, '住宿和餐饮业 > 住宿业 > 露营地服务', 614, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1054, 1049, '619', '其他住宿业', 3, '住宿和餐饮业 > 住宿业 > 其他住宿业', 619, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1055, 1050, '6110', '旅游饭店', 4, '住宿和餐饮业 > 住宿业 > 旅游饭店', 6110, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1056, 1052, '6130', '民宿服务', 4, '住宿和餐饮业 > 住宿业 > 民宿服务', 6130, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1057, 1053, '6140', '露营地服务', 4, '住宿和餐饮业 > 住宿业 > 露营地服务', 6140, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1058, 1054, '6190', '其他住宿业', 4, '住宿和餐饮业 > 住宿业 > 其他住宿业', 6190, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1059, 1048, '62', '餐饮业', 2, '住宿和餐饮业 > 餐饮业', 62, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1060, 1059, '621', '正餐服务', 3, '住宿和餐饮业 > 餐饮业 > 正餐服务', 621, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1061, 1059, '622', '快餐服务', 3, '住宿和餐饮业 > 餐饮业 > 快餐服务', 622, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1062, 1059, '623', '饮料及冷饮服务', 3, '住宿和餐饮业 > 餐饮业 > 饮料及冷饮服务', 623, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1063, 1059, '624', '餐饮配送及外卖送餐服务', 3, '住宿和餐饮业 > 餐饮业 > 餐饮配送及外卖送餐服务', 624, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1064, 1059, '629', '其他餐饮业', 3, '住宿和餐饮业 > 餐饮业 > 其他餐饮业', 629, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1065, 1060, '6210', '正餐服务', 4, '住宿和餐饮业 > 餐饮业 > 正餐服务', 6210, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1066, 1061, '6220', '快餐服务', 4, '住宿和餐饮业 > 餐饮业 > 快餐服务', 6220, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1067, 0, 'I', '信息传输、软件和信息技术服务业', 1, '信息传输、软件和信息技术服务业', 9, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1068, 1067, '63', '电信、广播电视和卫星传输服务', 2, '信息传输、软件和信息技术服务业 > 电信、广播电视和卫星传输服务', 63, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1069, 1068, '631', '电信', 3, '信息传输、软件和信息技术服务业 > 电信、广播电视和卫星传输服务 > 电信', 631, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1070, 1068, '632', '广播电视传输服务', 3, '信息传输、软件和信息技术服务业 > 电信、广播电视和卫星传输服务 > 广播电视传输服务', 632, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1071, 1068, '633', '卫星传输服务', 3, '信息传输、软件和信息技术服务业 > 电信、广播电视和卫星传输服务 > 卫星传输服务', 633, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1072, 1067, '64', '互联网和相关服务', 2, '信息传输、软件和信息技术服务业 > 互联网和相关服务', 64, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1073, 1072, '641', '互联网接入及相关服务', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网接入及相关服务', 641, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1074, 1072, '642', '互联网信息服务', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网信息服务', 642, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1075, 1072, '643', '互联网平台', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网平台', 643, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1076, 1072, '644', '互联网安全服务', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网安全服务', 644, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1077, 1072, '645', '互联网数据服务', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网数据服务', 645, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1078, 1072, '649', '其他互联网服务', 3, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 其他互联网服务', 649, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1079, 1073, '6410', '互联网接入及相关服务', 4, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网接入及相关服务', 6410, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1080, 1076, '6440', '互联网安全服务', 4, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网安全服务', 6440, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1081, 1077, '6450', '互联网数据服务', 4, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 互联网数据服务', 6450, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1082, 1078, '6490', '其他互联网服务', 4, '信息传输、软件和信息技术服务业 > 互联网和相关服务 > 其他互联网服务', 6490, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1083, 1067, '65', '软件和信息技术服务业', 2, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业', 65, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1084, 1083, '651', '软件开发', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 软件开发', 651, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1085, 1083, '652', '集成电路设计', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 集成电路设计', 652, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1086, 1083, '653', '信息系统集成和物联网技术服务', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 信息系统集成和物联网技术服务', 653, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1087, 1083, '654', '运行维护服务', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 运行维护服务', 654, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1088, 1083, '655', '信息处理和存储支持服务', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 信息处理和存储支持服务', 655, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1089, 1083, '656', '信息技术咨询服务', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 信息技术咨询服务', 656, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1090, 1083, '657', '数字内容服务', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 数字内容服务', 657, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1091, 1083, '659', '其他信息技术服务业', 3, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 其他信息技术服务业', 659, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1092, 1085, '6520', '集成电路设计', 4, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 集成电路设计', 6520, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1093, 1087, '6540', '运行维护服务', 4, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 运行维护服务', 6540, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1094, 1088, '6550', '信息处理和存储支持服务', 4, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 信息处理和存储支持服务', 6550, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1095, 1089, '6560', '信息技术咨询服务', 4, '信息传输、软件和信息技术服务业 > 软件和信息技术服务业 > 信息技术咨询服务', 6560, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1096, 0, 'J', '金融业', 1, '金融业', 10, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1097, 1096, '66', '货币金融服务', 2, '金融业 > 货币金融服务', 66, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1098, 1097, '661', '中央银行服务', 3, '金融业 > 货币金融服务 > 中央银行服务', 661, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1099, 1097, '662', '货币银行服务', 3, '金融业 > 货币金融服务 > 货币银行服务', 662, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1100, 1097, '663', '非货币银行服务', 3, '金融业 > 货币金融服务 > 非货币银行服务', 663, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1101, 1097, '664', '银行理财服务', 3, '金融业 > 货币金融服务 > 银行理财服务', 664, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1102, 1097, '665', '银行监管服务', 3, '金融业 > 货币金融服务 > 银行监管服务', 665, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1103, 1098, '6610', '中央银行服务', 4, '金融业 > 货币金融服务 > 中央银行服务', 6610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1104, 1101, '6640', '银行理财服务', 4, '金融业 > 货币金融服务 > 银行理财服务', 6640, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1105, 1102, '6650', '银行监管服务', 4, '金融业 > 货币金融服务 > 银行监管服务', 6650, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1106, 1096, '67', '资本市场服务', 2, '金融业 > 资本市场服务', 67, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1107, 1106, '671', '证券市场服务', 3, '金融业 > 资本市场服务 > 证券市场服务', 671, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1108, 1106, '672', '公开募集证券投资基金', 3, '金融业 > 资本市场服务 > 公开募集证券投资基金', 672, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1109, 1106, '673', '非公开募集证券投资基金', 3, '金融业 > 资本市场服务 > 非公开募集证券投资基金', 673, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1110, 1106, '674', '期货市场服务', 3, '金融业 > 资本市场服务 > 期货市场服务', 674, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1111, 1106, '675', '证券期货监管服务', 3, '金融业 > 资本市场服务 > 证券期货监管服务', 675, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1112, 1106, '676', '资本投资服务', 3, '金融业 > 资本市场服务 > 资本投资服务', 676, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1113, 1106, '679', '其他资本市场服务', 3, '金融业 > 资本市场服务 > 其他资本市场服务', 679, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1114, 1108, '6720', '公开募集证券投资基金', 4, '金融业 > 资本市场服务 > 公开募集证券投资基金', 6720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1115, 1111, '6750', '证券期货监管服务', 4, '金融业 > 资本市场服务 > 证券期货监管服务', 6750, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1116, 1112, '6760', '资本投资服务', 4, '金融业 > 资本市场服务 > 资本投资服务', 6760, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1117, 1113, '6790', '其他资本市场服务', 4, '金融业 > 资本市场服务 > 其他资本市场服务', 6790, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1118, 1096, '68', '保险业', 2, '金融业 > 保险业', 68, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1119, 1118, '681', '人身保险', 3, '金融业 > 保险业 > 人身保险', 681, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1120, 1118, '682', '财产保险', 3, '金融业 > 保险业 > 财产保险', 682, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1121, 1118, '683', '再保险', 3, '金融业 > 保险业 > 再保险', 683, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1122, 1118, '684', '商业养老金', 3, '金融业 > 保险业 > 商业养老金', 684, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1123, 1118, '685', '保险中介服务', 3, '金融业 > 保险业 > 保险中介服务', 685, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1124, 1118, '686', '保险资产管理', 3, '金融业 > 保险业 > 保险资产管理', 686, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1125, 1118, '687', '保险监管服务', 3, '金融业 > 保险业 > 保险监管服务', 687, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1126, 1118, '689', '其他保险活动', 3, '金融业 > 保险业 > 其他保险活动', 689, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1127, 1120, '6820', '财产保险', 4, '金融业 > 保险业 > 财产保险', 6820, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1128, 1121, '6830', '再保险', 4, '金融业 > 保险业 > 再保险', 6830, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1129, 1122, '6840', '商业养老金', 4, '金融业 > 保险业 > 商业养老金', 6840, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1130, 1124, '6860', '保险资产管理', 4, '金融业 > 保险业 > 保险资产管理', 6860, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1131, 1125, '6870', '保险监管服务', 4, '金融业 > 保险业 > 保险监管服务', 6870, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1132, 1126, '6890', '其他保险活动', 4, '金融业 > 保险业 > 其他保险活动', 6890, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1133, 1096, '69', '其他金融业', 2, '金融业 > 其他金融业', 69, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1134, 1133, '691', '金融信托与管理服务', 3, '金融业 > 其他金融业 > 金融信托与管理服务', 691, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1135, 1133, '692', '控股公司服务', 3, '金融业 > 其他金融业 > 控股公司服务', 692, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1136, 1133, '693', '非金融机构支付服务', 3, '金融业 > 其他金融业 > 非金融机构支付服务', 693, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1137, 1133, '694', '金融信息服务', 3, '金融业 > 其他金融业 > 金融信息服务', 694, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1138, 1133, '695', '金融资产管理公司', 3, '金融业 > 其他金融业 > 金融资产管理公司', 695, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1139, 1133, '699', '其他未列明金融业', 3, '金融业 > 其他金融业 > 其他未列明金融业', 699, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1140, 1135, '6920', '控股公司服务', 4, '金融业 > 其他金融业 > 控股公司服务', 6920, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1141, 1136, '6930', '非金融机构支付服务', 4, '金融业 > 其他金融业 > 非金融机构支付服务', 6930, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1142, 1137, '6940', '金融信息服务', 4, '金融业 > 其他金融业 > 金融信息服务', 6940, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1143, 1138, '6950', '金融资产管理公司', 4, '金融业 > 其他金融业 > 金融资产管理公司', 6950, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1144, 0, 'K', '房地产业', 1, '房地产业', 11, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1145, 1144, '70', '房地产业', 2, '房地产业 > 房地产业', 70, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1146, 1145, '701', '房地产开发经营', 3, '房地产业 > 房地产业 > 房地产开发经营', 701, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1147, 1145, '702', '物业管理', 3, '房地产业 > 房地产业 > 物业管理', 702, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1148, 1145, '703', '房地产中介服务', 3, '房地产业 > 房地产业 > 房地产中介服务', 703, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1149, 1145, '704', '房地产租赁经营', 3, '房地产业 > 房地产业 > 房地产租赁经营', 704, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1150, 1145, '709', '其他房地产业', 3, '房地产业 > 房地产业 > 其他房地产业', 709, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1151, 1146, '7010', '房地产开发经营', 4, '房地产业 > 房地产业 > 房地产开发经营', 7010, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1152, 1147, '7020', '物业管理', 4, '房地产业 > 房地产业 > 物业管理', 7020, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1153, 1148, '7030', '房地产中介服务', 4, '房地产业 > 房地产业 > 房地产中介服务', 7030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1154, 1149, '7040', '房地产租赁经营', 4, '房地产业 > 房地产业 > 房地产租赁经营', 7040, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1155, 1150, '7090', '其他房地产业', 4, '房地产业 > 房地产业 > 其他房地产业', 7090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1156, 0, 'L', '租赁和商务服务业', 1, '租赁和商务服务业', 12, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1157, 1156, '71', '租赁业', 2, '租赁和商务服务业 > 租赁业', 71, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1158, 1157, '711', '机械设备经营租赁', 3, '租赁和商务服务业 > 租赁业 > 机械设备经营租赁', 711, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1159, 1157, '712', '文体设备和用品出租', 3, '租赁和商务服务业 > 租赁业 > 文体设备和用品出租', 712, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1160, 1157, '713', '日用品出租', 3, '租赁和商务服务业 > 租赁业 > 日用品出租', 713, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1161, 1160, '7130', '日用品出租', 4, '租赁和商务服务业 > 租赁业 > 日用品出租', 7130, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1162, 1156, '72', '商务服务业', 2, '租赁和商务服务业 > 商务服务业', 72, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1163, 1162, '721', '组织管理服务', 3, '租赁和商务服务业 > 商务服务业 > 组织管理服务', 721, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1164, 1162, '722', '综合管理服务', 3, '租赁和商务服务业 > 商务服务业 > 综合管理服务', 722, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1165, 1162, '723', '法律服务', 3, '租赁和商务服务业 > 商务服务业 > 法律服务', 723, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1166, 1162, '724', '咨询与调查', 3, '租赁和商务服务业 > 商务服务业 > 咨询与调查', 724, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1167, 1162, '725', '广告业', 3, '租赁和商务服务业 > 商务服务业 > 广告业', 725, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1168, 1162, '726', '人力资源服务', 3, '租赁和商务服务业 > 商务服务业 > 人力资源服务', 726, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1169, 1162, '727', '安全保护服务', 3, '租赁和商务服务业 > 商务服务业 > 安全保护服务', 727, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1170, 1162, '728', '会议、展览及相关服务', 3, '租赁和商务服务业 > 商务服务业 > 会议、展览及相关服务', 728, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1171, 1162, '729', '其他商务服务业', 3, '租赁和商务服务业 > 商务服务业 > 其他商务服务业', 729, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1172, 0, 'M', '科学研究和技术服务业', 1, '科学研究和技术服务业', 13, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1173, 1172, '73', '研究和试验发展', 2, '科学研究和技术服务业 > 研究和试验发展', 73, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1174, 1173, '731', '自然科学研究和试验发展', 3, '科学研究和技术服务业 > 研究和试验发展 > 自然科学研究和试验发展', 731, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1175, 1173, '732', '工程和技术研究和试验发展', 3, '科学研究和技术服务业 > 研究和试验发展 > 工程和技术研究和试验发展', 732, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1176, 1173, '733', '农业科学研究和试验发展', 3, '科学研究和技术服务业 > 研究和试验发展 > 农业科学研究和试验发展', 733, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1177, 1173, '734', '医学研究和试验发展', 3, '科学研究和技术服务业 > 研究和试验发展 > 医学研究和试验发展', 734, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1178, 1173, '735', '社会人文科学研究', 3, '科学研究和技术服务业 > 研究和试验发展 > 社会人文科学研究', 735, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1179, 1174, '7310', '自然科学研究和试验发展', 4, '科学研究和技术服务业 > 研究和试验发展 > 自然科学研究和试验发展', 7310, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1180, 1175, '7320', '工程和技术研究和试验发展', 4, '科学研究和技术服务业 > 研究和试验发展 > 工程和技术研究和试验发展', 7320, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1181, 1176, '7330', '农业科学研究和试验发展', 4, '科学研究和技术服务业 > 研究和试验发展 > 农业科学研究和试验发展', 7330, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1182, 1177, '7340', '医学研究和试验发展', 4, '科学研究和技术服务业 > 研究和试验发展 > 医学研究和试验发展', 7340, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1183, 1178, '7350', '社会人文科学研究', 4, '科学研究和技术服务业 > 研究和试验发展 > 社会人文科学研究', 7350, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1184, 1172, '74', '专业技术服务业', 2, '科学研究和技术服务业 > 专业技术服务业', 74, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1185, 1184, '741', '气象服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 气象服务', 741, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1186, 1184, '742', '地震服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 地震服务', 742, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1187, 1184, '743', '海洋服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 海洋服务', 743, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1188, 1184, '744', '测绘地理信息服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 测绘地理信息服务', 744, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1189, 1184, '745', '质检技术服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 质检技术服务', 745, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1190, 1184, '746', '环境与生态监测检测服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 环境与生态监测检测服务', 746, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1191, 1184, '747', '地质勘查', 3, '科学研究和技术服务业 > 专业技术服务业 > 地质勘查', 747, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1192, 1184, '748', '工程技术与设计服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 工程技术与设计服务', 748, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1193, 1184, '749', '工业与专业设计及其他专业技术服务', 3, '科学研究和技术服务业 > 专业技术服务业 > 工业与专业设计及其他专业技术服务', 749, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1194, 1185, '7410', '气象服务', 4, '科学研究和技术服务业 > 专业技术服务业 > 气象服务', 7410, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1195, 1186, '7420', '地震服务', 4, '科学研究和技术服务业 > 专业技术服务业 > 地震服务', 7420, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1196, 1172, '75', '科技推广和应用服务业', 2, '科学研究和技术服务业 > 科技推广和应用服务业', 75, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1197, 1196, '751', '技术推广服务', 3, '科学研究和技术服务业 > 科技推广和应用服务业 > 技术推广服务', 751, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1198, 1196, '752', '知识产权服务', 3, '科学研究和技术服务业 > 科技推广和应用服务业 > 知识产权服务', 752, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1199, 1196, '753', '科技中介服务', 3, '科学研究和技术服务业 > 科技推广和应用服务业 > 科技中介服务', 753, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1200, 1196, '754', '创业空间服务', 3, '科学研究和技术服务业 > 科技推广和应用服务业 > 创业空间服务', 754, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1201, 1196, '759', '其他科技推广服务业', 3, '科学研究和技术服务业 > 科技推广和应用服务业 > 其他科技推广服务业', 759, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1202, 1198, '7520', '知识产权服务', 4, '科学研究和技术服务业 > 科技推广和应用服务业 > 知识产权服务', 7520, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1203, 1199, '7530', '科技中介服务', 4, '科学研究和技术服务业 > 科技推广和应用服务业 > 科技中介服务', 7530, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1204, 1200, '7540', '创业空间服务', 4, '科学研究和技术服务业 > 科技推广和应用服务业 > 创业空间服务', 7540, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1205, 1201, '7590', '其他科技推广服务业', 4, '科学研究和技术服务业 > 科技推广和应用服务业 > 其他科技推广服务业', 7590, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1206, 0, 'N', '水利、环境和公共设施管理业', 1, '水利、环境和公共设施管理业', 14, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1207, 1206, '76', '水利管理业', 2, '水利、环境和公共设施管理业 > 水利管理业', 76, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1208, 1207, '761', '防洪除涝设施管理', 3, '水利、环境和公共设施管理业 > 水利管理业 > 防洪除涝设施管理', 761, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1209, 1207, '762', '水资源管理', 3, '水利、环境和公共设施管理业 > 水利管理业 > 水资源管理', 762, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1210, 1207, '763', '天然水收集与分配', 3, '水利、环境和公共设施管理业 > 水利管理业 > 天然水收集与分配', 763, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1211, 1207, '764', '水文服务', 3, '水利、环境和公共设施管理业 > 水利管理业 > 水文服务', 764, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1212, 1207, '769', '其他水利管理业', 3, '水利、环境和公共设施管理业 > 水利管理业 > 其他水利管理业', 769, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1213, 1208, '7610', '防洪除涝设施管理', 4, '水利、环境和公共设施管理业 > 水利管理业 > 防洪除涝设施管理', 7610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1214, 1209, '7620', '水资源管理', 4, '水利、环境和公共设施管理业 > 水利管理业 > 水资源管理', 7620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1215, 1210, '7630', '天然水收集与分配', 4, '水利、环境和公共设施管理业 > 水利管理业 > 天然水收集与分配', 7630, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1216, 1211, '7640', '水文服务', 4, '水利、环境和公共设施管理业 > 水利管理业 > 水文服务', 7640, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1217, 1212, '7690', '其他水利管理业', 4, '水利、环境和公共设施管理业 > 水利管理业 > 其他水利管理业', 7690, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1218, 1206, '77', '生态保护和环境治理业', 2, '水利、环境和公共设施管理业 > 生态保护和环境治理业', 77, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1219, 1218, '771', '生态保护', 3, '水利、环境和公共设施管理业 > 生态保护和环境治理业 > 生态保护', 771, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1220, 1218, '772', '环境治理业', 3, '水利、环境和公共设施管理业 > 生态保护和环境治理业 > 环境治理业', 772, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1221, 1206, '78', '公共设施管理业', 2, '水利、环境和公共设施管理业 > 公共设施管理业', 78, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1222, 1221, '781', '市政设施管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 市政设施管理', 781, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1223, 1221, '782', '环境卫生管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 环境卫生管理', 782, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1224, 1221, '783', '城乡市容管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 城乡市容管理', 783, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1225, 1221, '784', '绿化管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 绿化管理', 784, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1226, 1221, '785', '城市公园管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 城市公园管理', 785, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1227, 1221, '786', '游览景区管理', 3, '水利、环境和公共设施管理业 > 公共设施管理业 > 游览景区管理', 786, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1228, 1222, '7810', '市政设施管理', 4, '水利、环境和公共设施管理业 > 公共设施管理业 > 市政设施管理', 7810, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1229, 1223, '7820', '环境卫生管理', 4, '水利、环境和公共设施管理业 > 公共设施管理业 > 环境卫生管理', 7820, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1230, 1224, '7830', '城乡市容管理', 4, '水利、环境和公共设施管理业 > 公共设施管理业 > 城乡市容管理', 7830, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1231, 1225, '7840', '绿化管理', 4, '水利、环境和公共设施管理业 > 公共设施管理业 > 绿化管理', 7840, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1232, 1226, '7850', '城市公园管理', 4, '水利、环境和公共设施管理业 > 公共设施管理业 > 城市公园管理', 7850, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1233, 1206, '79', '土地管理业', 2, '水利、环境和公共设施管理业 > 土地管理业', 79, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1234, 1233, '791', '土地整治服务', 3, '水利、环境和公共设施管理业 > 土地管理业 > 土地整治服务', 791, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1235, 1233, '792', '土地调查评估服务', 3, '水利、环境和公共设施管理业 > 土地管理业 > 土地调查评估服务', 792, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1236, 1233, '793', '土地登记服务', 3, '水利、环境和公共设施管理业 > 土地管理业 > 土地登记服务', 793, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1237, 1233, '794', '土地登记代理服务', 3, '水利、环境和公共设施管理业 > 土地管理业 > 土地登记代理服务', 794, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1238, 1233, '799', '其他土地管理服务', 3, '水利、环境和公共设施管理业 > 土地管理业 > 其他土地管理服务', 799, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1239, 1234, '7910', '土地整治服务', 4, '水利、环境和公共设施管理业 > 土地管理业 > 土地整治服务', 7910, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1240, 1235, '7920', '土地调查评估服务', 4, '水利、环境和公共设施管理业 > 土地管理业 > 土地调查评估服务', 7920, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1241, 1236, '7930', '土地登记服务', 4, '水利、环境和公共设施管理业 > 土地管理业 > 土地登记服务', 7930, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1242, 1237, '7940', '土地登记代理服务', 4, '水利、环境和公共设施管理业 > 土地管理业 > 土地登记代理服务', 7940, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1243, 1238, '7990', '其他土地管理服务', 4, '水利、环境和公共设施管理业 > 土地管理业 > 其他土地管理服务', 7990, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1244, 0, 'O', '居民服务、修理和其他服务业', 1, '居民服务、修理和其他服务业', 15, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1245, 1244, '80', '居民服务业', 2, '居民服务、修理和其他服务业 > 居民服务业', 80, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1246, 1245, '801', '家庭服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 家庭服务', 801, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1247, 1245, '802', '托儿所服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 托儿所服务', 802, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1248, 1245, '803', '洗染服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 洗染服务', 803, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1249, 1245, '804', '理发及美容服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 理发及美容服务', 804, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1250, 1245, '805', '洗浴和保健养生服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 洗浴和保健养生服务', 805, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1251, 1245, '806', '摄影扩印服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 摄影扩印服务', 806, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1252, 1245, '807', '婚姻服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 婚姻服务', 807, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1253, 1245, '808', '殡葬服务', 3, '居民服务、修理和其他服务业 > 居民服务业 > 殡葬服务', 808, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1254, 1245, '809', '其他居民服务业', 3, '居民服务、修理和其他服务业 > 居民服务业 > 其他居民服务业', 809, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1255, 1246, '8010', '家庭服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 家庭服务', 8010, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1256, 1247, '8020', '托儿所服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 托儿所服务', 8020, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1257, 1248, '8030', '洗染服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 洗染服务', 8030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1258, 1249, '8040', '理发及美容服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 理发及美容服务', 8040, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1259, 1251, '8060', '摄影扩印服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 摄影扩印服务', 8060, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1260, 1252, '8070', '婚姻服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 婚姻服务', 8070, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1261, 1253, '8080', '殡葬服务', 4, '居民服务、修理和其他服务业 > 居民服务业 > 殡葬服务', 8080, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1262, 1254, '8090', '其他居民服务业', 4, '居民服务、修理和其他服务业 > 居民服务业 > 其他居民服务业', 8090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1263, 1244, '81', '机动车、电子产品和日用产品修理业', 2, '居民服务、修理和其他服务业 > 机动车、电子产品和日用产品修理业', 81, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1264, 1263, '811', '汽车、摩托车等修理与维护', 3, '居民服务、修理和其他服务业 > 机动车、电子产品和日用产品修理业 > 汽车、摩托车等修理与维护', 811, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1265, 1263, '812', '计算机和办公设备维修', 3, '居民服务、修理和其他服务业 > 机动车、电子产品和日用产品修理业 > 计算机和办公设备维修', 812, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1266, 1263, '813', '家用电器修理', 3, '居民服务、修理和其他服务业 > 机动车、电子产品和日用产品修理业 > 家用电器修理', 813, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1267, 1263, '819', '其他日用产品修理业', 3, '居民服务、修理和其他服务业 > 机动车、电子产品和日用产品修理业 > 其他日用产品修理业', 819, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1268, 1244, '82', '其他服务业', 2, '居民服务、修理和其他服务业 > 其他服务业', 82, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1269, 1268, '821', '清洁服务', 3, '居民服务、修理和其他服务业 > 其他服务业 > 清洁服务', 821, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1270, 1268, '822', '宠物服务', 3, '居民服务、修理和其他服务业 > 其他服务业 > 宠物服务', 822, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1271, 1268, '829', '其他未列明服务业', 3, '居民服务、修理和其他服务业 > 其他服务业 > 其他未列明服务业', 829, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1272, 1271, '8290', '其他未列明服务业', 4, '居民服务、修理和其他服务业 > 其他服务业 > 其他未列明服务业', 8290, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1273, 0, 'P', '教育', 1, '教育', 16, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1274, 1273, '83', '教育', 2, '教育 > 教育', 83, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1275, 1274, '831', '学前教育', 3, '教育 > 教育 > 学前教育', 831, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1276, 1274, '832', '初等教育', 3, '教育 > 教育 > 初等教育', 832, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1277, 1274, '833', '中等教育', 3, '教育 > 教育 > 中等教育', 833, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1278, 1274, '834', '高等教育', 3, '教育 > 教育 > 高等教育', 834, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1279, 1274, '835', '特殊教育', 3, '教育 > 教育 > 特殊教育', 835, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1280, 1274, '839', '技能培训、教育辅助及其他教育', 3, '教育 > 教育 > 技能培训、教育辅助及其他教育', 839, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1281, 1275, '8310', '学前教育', 4, '教育 > 教育 > 学前教育', 8310, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1282, 1279, '8350', '特殊教育', 4, '教育 > 教育 > 特殊教育', 8350, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1283, 0, 'Q', '卫生和社会工作', 1, '卫生和社会工作', 17, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1284, 1283, '84', '卫生', 2, '卫生和社会工作 > 卫生', 84, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1285, 1284, '841', '医院', 3, '卫生和社会工作 > 卫生 > 医院', 841, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1286, 1284, '842', '基层医疗卫生服务', 3, '卫生和社会工作 > 卫生 > 基层医疗卫生服务', 842, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1287, 1284, '843', '专业公共卫生服务', 3, '卫生和社会工作 > 卫生 > 专业公共卫生服务', 843, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1288, 1284, '849', '其他卫生活动', 3, '卫生和社会工作 > 卫生 > 其他卫生活动', 849, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1289, 1283, '85', '社会工作', 2, '卫生和社会工作 > 社会工作', 85, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1290, 1289, '851', '提供住宿社会工作', 3, '卫生和社会工作 > 社会工作 > 提供住宿社会工作', 851, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1291, 1289, '852', '不提供住宿社会工作', 3, '卫生和社会工作 > 社会工作 > 不提供住宿社会工作', 852, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1292, 0, 'R', '文化、体育和娱乐业', 1, '文化、体育和娱乐业', 18, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1293, 1292, '86', '新闻和出版业', 2, '文化、体育和娱乐业 > 新闻和出版业', 86, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1294, 1293, '861', '新闻业', 3, '文化、体育和娱乐业 > 新闻和出版业 > 新闻业', 861, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1295, 1293, '862', '出版业', 3, '文化、体育和娱乐业 > 新闻和出版业 > 出版业', 862, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1296, 1294, '8610', '新闻业', 4, '文化、体育和娱乐业 > 新闻和出版业 > 新闻业', 8610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1297, 1292, '87', '广播、电视、电影和录音制作业', 2, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业', 87, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1298, 1297, '871', '广播', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 广播', 871, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1299, 1297, '872', '电视', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电视', 872, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1300, 1297, '873', '影视节目制作', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 影视节目制作', 873, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1301, 1297, '874', '广播电视集成播控', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 广播电视集成播控', 874, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1302, 1297, '875', '电影和广播电视节目发行', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电影和广播电视节目发行', 875, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1303, 1297, '876', '电影放映', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电影放映', 876, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1304, 1297, '877', '录音制作', 3, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 录音制作', 877, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1305, 1298, '8710', '广播', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 广播', 8710, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1306, 1299, '8720', '电视', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电视', 8720, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1307, 1300, '8730', '影视节目制作', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 影视节目制作', 8730, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1308, 1301, '8740', '广播电视集成播控', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 广播电视集成播控', 8740, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1309, 1302, '8750', '电影和广播电视节目发行', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电影和广播电视节目发行', 8750, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1310, 1303, '8760', '电影放映', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 电影放映', 8760, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1311, 1304, '8770', '录音制作', 4, '文化、体育和娱乐业 > 广播、电视、电影和录音制作业 > 录音制作', 8770, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1312, 1292, '88', '文化艺术业', 2, '文化、体育和娱乐业 > 文化艺术业', 88, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1313, 1312, '881', '文艺创作与表演', 3, '文化、体育和娱乐业 > 文化艺术业 > 文艺创作与表演', 881, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1314, 1312, '882', '艺术表演场馆', 3, '文化、体育和娱乐业 > 文化艺术业 > 艺术表演场馆', 882, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1315, 1312, '883', '图书馆与档案馆', 3, '文化、体育和娱乐业 > 文化艺术业 > 图书馆与档案馆', 883, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1316, 1312, '884', '文物及非物质文化遗产保护', 3, '文化、体育和娱乐业 > 文化艺术业 > 文物及非物质文化遗产保护', 884, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1317, 1312, '885', '博物馆', 3, '文化、体育和娱乐业 > 文化艺术业 > 博物馆', 885, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1318, 1312, '886', '烈士陵园、纪念馆', 3, '文化、体育和娱乐业 > 文化艺术业 > 烈士陵园、纪念馆', 886, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1319, 1312, '887', '群众文体活动', 3, '文化、体育和娱乐业 > 文化艺术业 > 群众文体活动', 887, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1320, 1312, '889', '其他文化艺术业', 3, '文化、体育和娱乐业 > 文化艺术业 > 其他文化艺术业', 889, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1321, 1313, '8810', '文艺创作与表演', 4, '文化、体育和娱乐业 > 文化艺术业 > 文艺创作与表演', 8810, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1322, 1314, '8820', '艺术表演场馆', 4, '文化、体育和娱乐业 > 文化艺术业 > 艺术表演场馆', 8820, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1323, 1316, '8840', '文物及非物质文化遗产保护', 4, '文化、体育和娱乐业 > 文化艺术业 > 文物及非物质文化遗产保护', 8840, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1324, 1317, '8850', '博物馆', 4, '文化、体育和娱乐业 > 文化艺术业 > 博物馆', 8850, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1325, 1318, '8860', '烈士陵园、纪念馆', 4, '文化、体育和娱乐业 > 文化艺术业 > 烈士陵园、纪念馆', 8860, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1326, 1319, '8870', '群众文体活动', 4, '文化、体育和娱乐业 > 文化艺术业 > 群众文体活动', 8870, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1327, 1320, '8890', '其他文化艺术业', 4, '文化、体育和娱乐业 > 文化艺术业 > 其他文化艺术业', 8890, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1328, 1292, '89', '体育', 2, '文化、体育和娱乐业 > 体育', 89, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1329, 1328, '891', '体育组织', 3, '文化、体育和娱乐业 > 体育 > 体育组织', 891, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1330, 1328, '892', '体育场地设施管理', 3, '文化、体育和娱乐业 > 体育 > 体育场地设施管理', 892, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1331, 1328, '893', '健身休闲活动', 3, '文化、体育和娱乐业 > 体育 > 健身休闲活动', 893, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1332, 1328, '899', '其他体育', 3, '文化、体育和娱乐业 > 体育 > 其他体育', 899, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1333, 1331, '8930', '健身休闲活动', 4, '文化、体育和娱乐业 > 体育 > 健身休闲活动', 8930, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1334, 1292, '90', '娱乐业', 2, '文化、体育和娱乐业 > 娱乐业', 90, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1335, 1334, '901', '室内娱乐活动', 3, '文化、体育和娱乐业 > 娱乐业 > 室内娱乐活动', 901, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1336, 1334, '902', '游乐园', 3, '文化、体育和娱乐业 > 娱乐业 > 游乐园', 902, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1337, 1334, '903', '休闲观光活动', 3, '文化、体育和娱乐业 > 娱乐业 > 休闲观光活动', 903, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1338, 1334, '904', '彩票活动', 3, '文化、体育和娱乐业 > 娱乐业 > 彩票活动', 904, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1339, 1334, '905', '文化体育娱乐活动与经纪代理服务', 3, '文化、体育和娱乐业 > 娱乐业 > 文化体育娱乐活动与经纪代理服务', 905, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1340, 1334, '909', '其他娱乐业', 3, '文化、体育和娱乐业 > 娱乐业 > 其他娱乐业', 909, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1341, 1336, '9020', '游乐园', 4, '文化、体育和娱乐业 > 娱乐业 > 游乐园', 9020, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1342, 1337, '9030', '休闲观光活动', 4, '文化、体育和娱乐业 > 娱乐业 > 休闲观光活动', 9030, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1343, 1340, '9090', '其他娱乐业', 4, '文化、体育和娱乐业 > 娱乐业 > 其他娱乐业', 9090, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1344, 0, 'S', '公共管理、社会保障和社会组织', 1, '公共管理、社会保障和社会组织', 19, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1345, 1344, '91', '中国共产党机关', 2, '公共管理、社会保障和社会组织 > 中国共产党机关', 91, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1346, 1345, '910', '中国共产党机关', 3, '公共管理、社会保障和社会组织 > 中国共产党机关 > 中国共产党机关', 910, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1347, 1346, '9100', '中国共产党机关', 4, '公共管理、社会保障和社会组织 > 中国共产党机关 > 中国共产党机关', 9100, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1348, 1344, '92', '国家机构', 2, '公共管理、社会保障和社会组织 > 国家机构', 92, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1349, 1348, '921', '国家权力机构', 3, '公共管理、社会保障和社会组织 > 国家机构 > 国家权力机构', 921, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1350, 1348, '922', '国家行政机构', 3, '公共管理、社会保障和社会组织 > 国家机构 > 国家行政机构', 922, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1351, 1348, '923', '人民法院和人民检察院', 3, '公共管理、社会保障和社会组织 > 国家机构 > 人民法院和人民检察院', 923, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1352, 1348, '929', '其他国家机构', 3, '公共管理、社会保障和社会组织 > 国家机构 > 其他国家机构', 929, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1353, 1349, '9210', '国家权力机构', 4, '公共管理、社会保障和社会组织 > 国家机构 > 国家权力机构', 9210, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1354, 1344, '93', '人民政协、民主党派', 2, '公共管理、社会保障和社会组织 > 人民政协、民主党派', 93, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1355, 1354, '931', '人民政协', 3, '公共管理、社会保障和社会组织 > 人民政协、民主党派 > 人民政协', 931, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1356, 1354, '932', '民主党派', 3, '公共管理、社会保障和社会组织 > 人民政协、民主党派 > 民主党派', 932, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1357, 1355, '9310', '人民政协', 4, '公共管理、社会保障和社会组织 > 人民政协、民主党派 > 人民政协', 9310, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1358, 1356, '9320', '民主党派', 4, '公共管理、社会保障和社会组织 > 人民政协、民主党派 > 民主党派', 9320, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1359, 1344, '94', '社会保障', 2, '公共管理、社会保障和社会组织 > 社会保障', 94, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1360, 1359, '941', '基本保险', 3, '公共管理、社会保障和社会组织 > 社会保障 > 基本保险', 941, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1361, 1359, '942', '补充保险', 3, '公共管理、社会保障和社会组织 > 社会保障 > 补充保险', 942, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1362, 1359, '949', '其他社会保障', 3, '公共管理、社会保障和社会组织 > 社会保障 > 其他社会保障', 949, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1363, 1361, '9420', '补充保险', 4, '公共管理、社会保障和社会组织 > 社会保障 > 补充保险', 9420, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1364, 1362, '9490', '其他社会保障', 4, '公共管理、社会保障和社会组织 > 社会保障 > 其他社会保障', 9490, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1365, 1344, '95', '群众团体、社会团体和其他成员组织', 2, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织', 95, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1366, 1365, '951', '群众团体', 3, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织 > 群众团体', 951, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1367, 1365, '952', '社会团体', 3, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织 > 社会团体', 952, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1368, 1365, '953', '基金会', 3, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织 > 基金会', 953, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1369, 1365, '954', '宗教组织', 3, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织 > 宗教组织', 954, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1370, 1368, '9530', '基金会', 4, '公共管理、社会保障和社会组织 > 群众团体、社会团体和其他成员组织 > 基金会', 9530, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1371, 1344, '96', '基层群众自治组织', 2, '公共管理、社会保障和社会组织 > 基层群众自治组织', 96, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1372, 1371, '961', '社区居民自治组织', 3, '公共管理、社会保障和社会组织 > 基层群众自治组织 > 社区居民自治组织', 961, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1373, 1371, '962', '村民自治组织', 3, '公共管理、社会保障和社会组织 > 基层群众自治组织 > 村民自治组织', 962, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1374, 1372, '9610', '社区居民自治组织', 4, '公共管理、社会保障和社会组织 > 基层群众自治组织 > 社区居民自治组织', 9610, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1375, 1373, '9620', '村民自治组织', 4, '公共管理、社会保障和社会组织 > 基层群众自治组织 > 村民自治组织', 9620, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1376, 0, 'T', '国际组织', 1, '国际组织', 20, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1377, 1376, '97', '国际组织', 2, '国际组织 > 国际组织', 97, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1378, 1377, '970', '国际组织', 3, '国际组织 > 国际组织 > 国际组织', 970, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');
INSERT INTO `sys_economy_category` VALUES (1379, 1378, '9700', '国际组织', 4, '国际组织 > 国际组织 > 国际组织', 9700, 1, '2026-06-29 20:48:45', '2026-06-29 20:48:45');

-- ----------------------------
-- Table structure for sys_file_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_category`;
CREATE TABLE `sys_file_category`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级分类ID，顶级为0',
  `level` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '层级深度',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_file_category_parent_id_index`(`parent_id` ASC) USING BTREE,
  INDEX `sys_file_category_level_index`(`level` ASC) USING BTREE,
  INDEX `sys_file_category_status_index`(`status` ASC) USING BTREE,
  INDEX `sys_file_category_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file_category
-- ----------------------------
INSERT INTO `sys_file_category` VALUES (1, 3, '项目官文', 0, 2, 1, '2026-06-29 16:30:32', '2026-06-29 23:33:24', NULL);
INSERT INTO `sys_file_category` VALUES (2, 3, '美国专利来文', 1, 1, 1, '2026-06-29 16:30:34', '2026-06-29 23:33:32', NULL);
INSERT INTO `sys_file_category` VALUES (3, 1, '中国专利来文', 1, 2, 1, '2026-06-29 16:30:36', '2026-06-30 09:29:02', NULL);
INSERT INTO `sys_file_category` VALUES (4, 8, '项目非官文', 0, 1, 1, '2026-06-29 16:30:39', '2026-06-29 23:35:33', NULL);
INSERT INTO `sys_file_category` VALUES (5, 2, '2', 4, 2, 1, '2026-06-29 19:27:25', '2026-06-29 19:27:25', NULL);
INSERT INTO `sys_file_category` VALUES (6, 2, '1', 0, 1, 1, '2026-06-29 22:36:32', '2026-06-29 22:36:32', NULL);
INSERT INTO `sys_file_category` VALUES (7, 1, '1', 0, 1, 0, '2026-06-29 23:05:27', '2026-06-30 09:29:07', NULL);
INSERT INTO `sys_file_category` VALUES (8, 1, '1', 0, 1, 1, '2026-06-29 23:05:41', '2026-06-29 23:05:41', NULL);
INSERT INTO `sys_file_category` VALUES (9, 1, 'dwdw', 0, 2, 1, '2026-06-29 23:09:56', '2026-06-29 23:09:56', NULL);
INSERT INTO `sys_file_category` VALUES (10, 1, 'd\'w\'d\'q', 0, 1, 1, '2026-06-29 23:35:24', '2026-06-29 23:35:24', NULL);

-- ----------------------------
-- Table structure for sys_industrial_park
-- ----------------------------
DROP TABLE IF EXISTS `sys_industrial_park`;
CREATE TABLE `sys_industrial_park`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `park_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '园区名称',
  `park_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '园区编码',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '园区地址',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint UNSIGNED NULL DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_industrial_park_park_code_index`(`park_code` ASC) USING BTREE,
  INDEX `sys_industrial_park_status_index`(`status` ASC) USING BTREE,
  INDEX `sys_industrial_park_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_industrial_park
-- ----------------------------
INSERT INTO `sys_industrial_park` VALUES (1, 1, '中关村科技园', 'ZGC-001', '北京市海淀区中关村大街1号', '张三', '13800138000', '国家级高新技术产业园区', 1, '2026-06-29 16:32:05', '2026-06-29 16:32:05', NULL);
INSERT INTO `sys_industrial_park` VALUES (2, 1, 'z\'z', NULL, NULL, NULL, NULL, NULL, 1, '2026-06-29 23:11:29', '2026-06-29 23:11:29', NULL);
INSERT INTO `sys_industrial_park` VALUES (3, 1, 'z\'z', NULL, NULL, NULL, NULL, NULL, 1, '2026-06-29 23:11:29', '2026-06-29 23:11:29', NULL);
INSERT INTO `sys_industrial_park` VALUES (4, 1, 'z\'z', NULL, NULL, NULL, NULL, NULL, 1, '2026-06-29 23:11:30', '2026-06-29 23:11:30', NULL);
INSERT INTO `sys_industrial_park` VALUES (5, 1, '巴拉巴拉', '1232', '21242', NULL, '18981751580', '哈哈哈哈哈', 1, '2026-06-30 09:15:03', '2026-06-30 09:15:03', NULL);
INSERT INTO `sys_industrial_park` VALUES (6, 1, '巴拉巴拉', '1232', '21242', NULL, '18981751580', '哈哈哈哈哈', 1, '2026-06-30 09:15:06', '2026-06-30 09:15:06', NULL);
INSERT INTO `sys_industrial_park` VALUES (7, 1, '巴拉巴拉', '1232', '21242', NULL, '18981751580', '哈哈哈哈哈', 1, '2026-06-30 09:15:07', '2026-06-30 09:15:07', NULL);
INSERT INTO `sys_industrial_park` VALUES (8, 1, '巴拉巴拉', '1232', '21242', NULL, '18981751580', '哈哈哈哈哈', 1, '2026-06-30 09:15:07', '2026-06-30 09:15:07', NULL);
INSERT INTO `sys_industrial_park` VALUES (9, 1, '园区1', '1', '成都市', NULL, '18981751580', '园区1', 1, '2026-06-30 09:15:48', '2026-06-30 09:15:48', NULL);
INSERT INTO `sys_industrial_park` VALUES (10, 1, '园区1', '1', '成都市', NULL, '18981751580', '园区1', 1, '2026-06-30 09:15:50', '2026-06-30 09:15:50', NULL);
INSERT INTO `sys_industrial_park` VALUES (11, 1, '111', '1', '12', NULL, '11312324141', '1111', 1, '2026-06-30 09:23:54', '2026-06-30 09:23:54', NULL);
INSERT INTO `sys_industrial_park` VALUES (13, 1, 'sca', 'casca', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:29:47', '2026-06-30 09:29:47', NULL);
INSERT INTO `sys_industrial_park` VALUES (14, 1, 'sca', 'casca', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:29:48', '2026-06-30 09:29:48', NULL);
INSERT INTO `sys_industrial_park` VALUES (15, 1, 'acsa', NULL, NULL, NULL, NULL, NULL, 1, '2026-06-30 09:29:56', '2026-06-30 09:29:56', NULL);
INSERT INTO `sys_industrial_park` VALUES (16, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:18', '2026-06-30 09:30:18', NULL);
INSERT INTO `sys_industrial_park` VALUES (17, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:20', '2026-06-30 09:30:20', NULL);
INSERT INTO `sys_industrial_park` VALUES (18, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:21', '2026-06-30 09:30:21', NULL);
INSERT INTO `sys_industrial_park` VALUES (19, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:24', '2026-06-30 09:30:24', NULL);
INSERT INTO `sys_industrial_park` VALUES (20, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:27', '2026-06-30 09:30:27', NULL);
INSERT INTO `sys_industrial_park` VALUES (21, 1, '99', '99', NULL, NULL, NULL, NULL, 1, '2026-06-30 09:30:31', '2026-06-30 09:30:31', NULL);

-- ----------------------------
-- Table structure for sys_location_region
-- ----------------------------
DROP TABLE IF EXISTS `sys_location_region`;
CREATE TABLE `sys_location_region`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级区域ID，顶级为0',
  `region_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '区域名称',
  `region_type` tinyint UNSIGNED NOT NULL COMMENT '区域类型：1-省份，2-城市，3-区县，4-园区/功能区',
  `region_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '区域编码',
  `level` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '层级深度：1(省)-2(市)-3(区)-4(园区)',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-无效',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_location_region_parent_id_index`(`parent_id` ASC) USING BTREE,
  INDEX `sys_location_region_region_type_index`(`region_type` ASC) USING BTREE,
  INDEX `sys_location_region_region_code_index`(`region_code` ASC) USING BTREE,
  INDEX `sys_location_region_level_index`(`level` ASC) USING BTREE,
  INDEX `sys_location_region_status_index`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_location_region
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父菜单ID，顶级为0',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单类型：M-目录，C-菜单，F-按钮',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限标识',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '显示排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_menu_parent_id_index`(`parent_id` ASC) USING BTREE,
  INDEX `sys_menu_menu_type_index`(`menu_type` ASC) USING BTREE,
  INDEX `sys_menu_perms_index`(`perms` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '客户主菜单', 'M', NULL, NULL, NULL, 1, '2026-06-29 16:32:27', '2026-06-29 16:32:27');
INSERT INTO `sys_menu` VALUES (2, 0, '合同主菜单', 'M', NULL, NULL, NULL, 1, '2026-06-29 16:32:29', '2026-06-29 16:32:29');
INSERT INTO `sys_menu` VALUES (3, 1, '客户列表', 'C', NULL, NULL, NULL, 1, '2026-06-29 16:32:32', '2026-06-29 16:32:32');
INSERT INTO `sys_menu` VALUES (4, 1, '我的客户', 'C', NULL, NULL, NULL, 1, '2026-06-29 16:32:34', '2026-06-29 16:32:34');
INSERT INTO `sys_menu` VALUES (5, 1, '客户文件', 'C', NULL, NULL, NULL, 1, '2026-06-29 16:32:36', '2026-06-29 16:32:36');
INSERT INTO `sys_menu` VALUES (6, 1, '联系人列表', 'C', NULL, NULL, NULL, 1, '2026-06-29 16:32:39', '2026-06-29 16:32:39');
INSERT INTO `sys_menu` VALUES (7, 1, '申请人列表', 'C', NULL, NULL, NULL, 1, '2026-06-29 16:32:41', '2026-06-29 16:32:41');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色描述',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否有效：0-无效，1-有效',
  `sort_order` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '显示排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sys_role_role_key_unique`(`role_key` ASC) USING BTREE,
  INDEX `sys_role_status_index`(`status` ASC) USING BTREE,
  INDEX `sys_role_sort_order_index`(`sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '客户6644', 'customer_service', '11111111', 1, 1, '2026-06-29 16:20:47', '2026-06-29 21:38:21');
INSERT INTO `sys_role` VALUES (2, '客户', 'customer', '客户', 1, 1, '2026-06-29 16:20:50', '2026-06-29 16:20:50');
INSERT INTO `sys_role` VALUES (3, '科服人员', 'science', '科服', 1, 1, '2026-06-29 16:20:53', '2026-06-29 16:20:53');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色ID',
  `menu_id` bigint UNSIGNED NOT NULL COMMENT '菜单ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  INDEX `sys_role_menu_role_id_index`(`role_id` ASC) USING BTREE,
  INDEX `sys_role_menu_menu_id_index`(`menu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (1, 3, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (1, 4, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (1, 5, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (1, 6, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (1, 7, '2026-06-30 09:15:11', '2026-06-30 09:15:11');
INSERT INTO `sys_role_menu` VALUES (3, 1, '2026-06-29 21:50:10', '2026-06-29 21:50:10');
INSERT INTO `sys_role_menu` VALUES (3, 3, '2026-06-29 21:50:10', '2026-06-29 21:50:10');
INSERT INTO `sys_role_menu` VALUES (3, 4, '2026-06-29 21:50:10', '2026-06-29 21:50:10');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名（工号），登录账号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码，加密存储',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `gender` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `dept_id` bigint UNSIGNED NOT NULL COMMENT '所属部门ID',
  `role_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '所属角色ID',
  `job_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职位',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号',
  `professional_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业等级',
  `business_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商务等级',
  `employment_status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '离职在职状态：0-离职，1-在职',
  `account_status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '账号状态：0-禁用，1-启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sys_user_username_unique`(`username` ASC) USING BTREE,
  INDEX `sys_user_dept_id_index`(`dept_id` ASC) USING BTREE,
  INDEX `sys_user_employment_status_index`(`employment_status` ASC) USING BTREE,
  INDEX `sys_user_account_status_index`(`account_status` ASC) USING BTREE,
  INDEX `sys_user_role_id_index`(`role_id` ASC) USING BTREE,
  CONSTRAINT `sys_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'LX', '$2y$12$OcV465SSFJXZePrmAN9BBe93S//0dFwmY0gVs6ArOXp8bT3fdJFCC', 'LX', 1, 1, NULL, '开发人员', 'lx@example.com', '13800000001', 'LEVEL_A', 'LEVEL_A', 1, 1, '2026-06-29 16:03:51', '2026-06-29 16:03:51');
INSERT INTO `sys_user` VALUES (2, 'WJC', '$2y$12$YUGlgOF2fwwbLShyw4dSZe1/WXecV/WVQYh75nSolAbgPeVLGKXei', 'WJC', 1, 1, NULL, '开发人员', 'wjc@example.com', '13800000002', 'LEVEL_A', 'LEVEL_A', 1, 1, '2026-06-29 16:03:52', '2026-06-29 16:03:52');
INSERT INTO `sys_user` VALUES (3, 'Fmy', '$2y$12$HpCiNzdv2M9XAk4pRzWfyu3x9o..bpM7opmVWUCVwSw7Nvjblc8.G', 'Fmy', 2, 1, NULL, '开发人员', 'fmy@example.com', '13800000003', 'LEVEL_A', 'LEVEL_A', 1, 1, '2026-06-29 16:03:52', '2026-06-29 16:03:52');
INSERT INTO `sys_user` VALUES (4, 'Gyz', '$2y$12$wBb6Ct.H5ZybzhnG3luwZeXjLWzD5f4ykoX3bfIJ5Gq7qmuv6mhUS', 'Gyz', 1, 1, NULL, '开发人员', 'gyz@example.com', '13800000004', 'LEVEL_B', 'LEVEL_B', 1, 1, '2026-06-29 16:03:52', '2026-06-29 16:03:52');
INSERT INTO `sys_user` VALUES (5, 'U2026001', '$2y$12$zWIHQuWvRE1wjYvLfZqgL.luWis5wjkxCklfjhCjg2day0fF/2oTW', '张三', 1, 2, NULL, '前端开发', 'zhangsan@example.com', '13800138001', '中级', 'B级', 1, 1, '2026-06-29 16:19:52', '2026-06-29 16:19:52');
INSERT INTO `sys_user` VALUES (6, 'U2026002', '$2y$12$L4/hNmyT6ztIJM405QINa.0ek8dpwUr.Ol5qOuaaFsQxYANYR7FBS', '李四', 1, 2, NULL, '前端开发', 'zhangsan@example.com', '13800138001', '中级', 'B级', 1, 1, '2026-06-29 16:59:14', '2026-06-29 16:59:14');
INSERT INTO `sys_user` VALUES (7, 'U2026003', '$2y$12$CvBNgKH2hgAHXxm7LqoKxeRa5jOTq1/O/FPsREKoMXUaj4HDkuStS', '张三', 1, 2, NULL, '前端开发', 'zhangsan@example.com', '13800138001', '中级', 'B级', 1, 1, '2026-06-29 17:06:37', '2026-06-29 17:06:37');
INSERT INTO `sys_user` VALUES (8, 'U2026004', '$2y$12$ldJF7ghD3bsapS6NK17vWeX.eLAR6Gm2d1DBAX2B/eye5jjNopdfW', '王五', 1, 2, NULL, '前端开发', 'zhangsan@example.com', '13800138001', '中级', 'B级', 1, 1, '2026-06-29 17:10:51', '2026-06-29 17:10:51');

SET FOREIGN_KEY_CHECKS = 1;
