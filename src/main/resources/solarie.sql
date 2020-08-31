/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : solarie

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 31/08/2020 09:43:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for job_entity
-- ----------------------------
DROP TABLE IF EXISTS `job_entity`;
CREATE TABLE `job_entity`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类名',
  `method_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法名称',
  `params` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '传入的参数',
  `status` enum('CLOSE','OPEN') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'CLOSE' COMMENT '启用状态（OPEN开启，CLOSE关闭）',
  `work_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '工作状态（1生效中；0未生效）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `job_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactoryBean', 'Solarie1598584921073', 1598599197090, 7500);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_announcement
-- ----------------------------
DROP TABLE IF EXISTS `sys_announcement`;
CREATE TABLE `sys_announcement`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `titile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `msg_content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  `start_time` datetime(0) DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) DEFAULT NULL COMMENT '结束时间',
  `sender` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发布人',
  `priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '优先级（L低，M中，H高）',
  `msg_category` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '消息类型1:通知公告2:系统消息',
  `msg_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通告对象类型（USER:指定用户，ALL:全体用户）',
  `send_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发布状态（0未发布，1已发布，2已撤销）',
  `send_time` datetime(0) DEFAULT NULL COMMENT '发布时间',
  `cancel_time` datetime(0) DEFAULT NULL COMMENT '撤销时间',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '删除状态（0，正常，1已删除）',
  `bus_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务类型(email:邮件 bpm:流程)',
  `bus_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务id',
  `open_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '打开方式(组件：component 路由：url)',
  `open_page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '组件/路由 地址',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '指定用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统通告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_announcement
-- ----------------------------
INSERT INTO `sys_announcement` VALUES ('1b714f8ebc3cc33f8b4f906103b6a18d', '5467567', NULL, NULL, NULL, 'admin', NULL, '2', NULL, '1', '2019-03-30 12:40:38', NULL, '0', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:23:26', 'admin', '2019-02-26 17:35:10', NULL);
INSERT INTO `sys_announcement` VALUES ('3d11237ccdf62450d20bb8abdb331178', '111222', NULL, NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-03-29 17:19:47', 'admin', '2019-03-29 17:19:50', NULL);
INSERT INTO `sys_announcement` VALUES ('7ef04e95f8de030b1d5f7a9144090dc6', '111', NULL, '2019-02-06 17:28:10', '2019-03-08 17:28:11', NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:28:17', 'admin', '2019-03-26 19:59:49', NULL);
INSERT INTO `sys_announcement` VALUES ('93a9060a1c20e4bf98b3f768a02c2ff9', '111', '111', '2019-02-06 17:20:17', '2019-02-21 17:20:20', 'admin', 'M', '2', 'ALL', '1', '2019-02-26 17:24:29', NULL, '0', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:16:26', 'admin', '2019-02-26 17:19:35', NULL);
INSERT INTO `sys_announcement` VALUES ('de1dc57f31037079e1e55c8347fe6ef7', '222', '2222', '2019-02-06 17:28:26', '2019-02-23 17:28:28', 'admin', 'M', '2', 'ALL', '1', '2019-03-29 17:19:56', NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-02-26 17:28:36', 'admin', '2019-02-26 17:28:40', NULL);
INSERT INTO `sys_announcement` VALUES ('e52f3eb6215f139cb2224c52517af3bd', '334', '334', NULL, NULL, NULL, NULL, '2', NULL, '0', NULL, NULL, '1', NULL, NULL, NULL, NULL, 'admin', '2019-03-30 12:40:28', 'admin', '2019-03-30 12:40:32', NULL);

-- ----------------------------
-- Table structure for sys_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '资源名称',
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `type` tinyint(4) NOT NULL COMMENT '资源类型：1:menu 2:控制器 3:方法',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '访问url地址',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限编码',
  `props` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '不同资源类型的属性信息，使用json存储',
  `sort` int(11) DEFAULT NULL COMMENT '排序号',
  `pids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父id列表串',
  `descr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 88 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES (6, '首页', NULL, 1, '/home', 'HOME_PAGE', 'icon-shitu', 100000, NULL, '首页', 1, '2020-08-26 12:51:28');
INSERT INTO `sys_auth` VALUES (7, '项目列表', NULL, 1, '/projectList', 'HOME_PAGE', '', 100200, NULL, '项目列表', 1, '2020-08-26 12:51:27');
INSERT INTO `sys_auth` VALUES (8, '项建书', NULL, 1, '/system/users', 'HOME_PAGE', '', 100300, NULL, '项建书', 1, '2020-08-26 12:51:31');
INSERT INTO `sys_auth` VALUES (9, '工可', NULL, 1, '/system/roles', 'HOME_PAGE', '', 100400, NULL, '工可', 1, '2020-08-20 10:31:49');
INSERT INTO `sys_auth` VALUES (10, '初审合同', NULL, 1, '/system/auth', 'HOME_PAGE', '', 100500, NULL, '初审合同', 1, '2020-08-20 10:31:49');
INSERT INTO `sys_auth` VALUES (13, '投资采购', NULL, 1, NULL, 'HOME_PAGE', NULL, 100100, NULL, '投资采购', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (29, '招标审批', NULL, 1, '/Intelligence', '', NULL, 50000, NULL, '招标审批', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (30, '招标比选审批', NULL, 1, '/Intelligence/ElectronicArchives', '', NULL, 50100, NULL, '招标比选审批', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (33, '定标审批', NULL, 1, '/home', '', NULL, NULL, NULL, '定标审批', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (34, '合同审批', NULL, 1, '/companyView', NULL, NULL, 10000, NULL, '合同审批', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (35, '合同变更', NULL, 1, '/creditSupervision', NULL, NULL, 20000, NULL, '合同变更', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (36, '附件管理', NULL, 1, '/riskRegulation', NULL, NULL, 30000, NULL, '附件管理', 1, '2020-08-26 12:51:35');
INSERT INTO `sys_auth` VALUES (87, '系统管理', NULL, 1, '/', NULL, NULL, NULL, NULL, '系统管理', 1, '2020-08-20 10:31:49');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_type` int(2) DEFAULT NULL COMMENT '日志类型（1登录日志，2操作日志）',
  `log_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志内容',
  `operate_type` int(2) DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) DEFAULT NULL COMMENT '耗时',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_userid`(`userid`) USING BTREE,
  INDEX `index_logt_ype`(`log_type`) USING BTREE,
  INDEX `index_operate_type`(`operate_type`) USING BTREE,
  INDEX `index_log_type`(`log_type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('b09ccd219a1ce5c7270bb659748b8330', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 15:34:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a22ddd4b5b0b84bd7794edd24b25fc64', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1547883299809,\"email\":\"zhangdaiscott@163.com\",\"id\":\"7eac655877842eb39dc2f0469f3964ec\",\"name\":\"zhang daihao\"}]', NULL, 25, 'admin', '2019-01-19 15:34:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('07a0b3f8b4140a7a586305c2f40a2310', 2, '删除测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.delete()', NULL, '[\"7eac655877842eb39dc2f0469f3964ec\"]', NULL, 14, 'admin', '2019-01-19 15:38:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d7902eeab2c34611fad046a79bff1c1b', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1547883544104,\"email\":\"zhangdaiscott@163.com\",\"id\":\"4436302a0de50bb83025286bc414d6a9\",\"name\":\"zhang daihao\"}]', NULL, 1682, 'admin', '2019-01-19 15:39:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a68160f37cace166fedd299c4ca0be10', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 15:40:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c6c0316b6989bf1eea0a3803f593bf69', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 15:47:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4b1341863a8fffeccda8bbe413bd815f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 15:59:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ed50b1fbc80c3b953f4551081b10335e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 16:19:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dabdcb8e15ea9215a1af22f7567ff73d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 16:48:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('446724ea6dd41f4a03111c42e00d80cd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 16:56:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0e41fe3a34d5715bf4c88e220663583a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 17:04:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9f2db1ffaf89518a25cc6701da0c5858', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 17:05:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('954f1ccb8b230d2d7d4858eec3aba0a4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 17:08:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7374f3a2ccb20216cf8eecb26037ce0a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 18:08:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('130de55edac71aab730786307cc65936', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 20:22:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0bc44e2d682c9f28525d203589a90b43', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 20:31:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('122edcafd54dd06e12838f41123d9d5d', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"age\":28,\"birthday\":1546617600000,\"createBy\":\"admin\",\"createTime\":1547901234989,\"id\":\"42c08b1a2e5b2a96ffa4cc88383d4b11\",\"name\":\"秦500\",\"punchTime\":1546691611000}]', NULL, 21387, 'admin', '2019-01-19 20:34:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1a570aac0c30ac2955b59e2dc7a6204c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 20:58:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c18db091677ec01d55e913662b9028a9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:19:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('88d8b4b50bdab58c52fe25fa711fbbef', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:21:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6b876be6e384337b36ad28a4a5868be8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:22:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cb6b52fbbdd4c5698c17edaf9960e11e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:22:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fea8e1e2d229557185be0d9a10ebce17', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:55:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c1842fc83cdf0b0cc0264bf093e9c55d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 21:56:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('543970eba4d1c522e3cb597b0fd4ad13', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 22:53:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e9ce2b3f7ac1fa3f5f7fd247207ca5c0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 22:53:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0e365a21c60e4460813bdc4e3cb320a3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 23:01:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d3df1a4057b6d7fb4dab073a727ba21f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 23:14:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8f616500d666a5a67bc98e7ccd73c2e2', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1547912194199,\"id\":\"ffa9da1ad40632dfcabac51d766865bd\",\"name\":\"秦999\"}]', NULL, 386, 'admin', '2019-01-19 23:36:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('055cf35c8865761b479c7f289dc36616', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1547912238787,\"email\":\"zhangdaiscott@163.com\",\"id\":\"c2c0d49e3c01913067cf8d1fb3c971d2\",\"name\":\"zhang daihao\"}]', NULL, 16, 'admin', '2019-01-19 23:37:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69e3164d007be2b9834e4fb398186f39', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-19 23:38:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('92e514fee917a1a459c4ffdb0ca42516', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 10:20:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d3f08843a9b2b3284711e376fb785beb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 10:58:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('76bea561f662ec0ccf05bc370f1ffe35', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 11:08:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('273081678d85acebaa6615973bff31db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:02:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b26369680b41d581649cf865e88331e9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:03:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7313b43ff53015d79a58b4dc7c660721', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:03:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f99912c5ff252594f14d31b768f8ad15', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:03:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dcec1957987abbe6658f1f2c96980366', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:05:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c7b6156c4f42b70c562b507766f4546c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:14:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('52673feae24ea5bc3ca111f19c9a85d4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:16:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('507b55d3b5ddc487fb40ca1f716a1253', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:43:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7351132f4f5f65e5bf157dd7ad5344a4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:51:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('961992e05772bc7ad2ca927cf7649440', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 15:55:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3b07fda32423a5696b2097e1c23c00d4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 16:04:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8447099784da63b3b2cd2fbbc5eabcea', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 16:04:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b20ff98a10af3c25c1991741fd59ea64', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 16:07:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9acebd2d37c9078f9568125fb9696976', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 16:07:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d70c2847d8d0936a2a761f745a84aa48', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 16:39:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('279e519d647f1a4e1f85f9b90ab370b9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 17:01:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b605a83a9b5f3cdaaa1b3f4f41a5f12d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 17:04:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0a24b1f04f79a2bcb83c4cd12d077cbc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 17:34:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('661c4792f00b0814e486c3d623d7259f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 18:06:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d1746c5c937fcb650bd835ff74dabdff', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 18:06:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8ec3a287a37d155047e80a80769d5226', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 18:37:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6cbd2a9257fae1cb7ff7bc2eb264b3ab', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 19:08:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f06e8fa83b408be905b4dc7caeaf9a80', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 19:40:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f84e86c9a21149134b1f2599a424164b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-21 20:12:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('88bfc5b77b4be0d6d0f7c8661cf24853', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:25:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b9bf472a12fc25a9d4b500421b08b025', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:53:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dbbcfb7f59311637a613ec9a6c63f04a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:53:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69ea2322f72b41bcdc7f235889132703', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:54:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('62d197757e2cb40f9e8cb57fa6a207f7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:54:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ccad29843623a6c3ca59548b1d533b15', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 10:56:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4d9299e2daac1f49eac0cec75a90c32e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 11:28:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('43848099c1e70910ba1572868ee40415', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 11:28:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6fb7db45b11bc22347b234fda07700c8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 12:00:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e8cde8dcd6253b249d67a05aaf10f968', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 12:30:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6a4231540c73ad67128d5a24e6a877ff', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 12:54:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2b3be3da6ba9d1ee49f378d729d69c50', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 13:24:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('78f519b618f82a39adad391fbf6b9c7a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 13:49:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1487d69ff97888f3a899e2ababb5ae48', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 14:21:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cc7fa5567e7833a3475b29b7441a2976', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 14:21:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('52e36d72cd04bea2604747e006b038ec', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 19:47:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('523a54948d5edaf421566014b66f9465', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 19:50:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('48e4e10ac7e583050fd85734f0676a7c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 19:58:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dee4d42c439b51b228ab5db5d0723fc0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-22 20:02:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('965c74ffe09d8a06bb817efa6d62254b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 10:01:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('059bac84373e9dae94363ea18802d70f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 10:06:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9ef3f1ed07003e3abec3445920b062f1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 11:17:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0169622dcd4e89b177a0917778ac7f9c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 11:17:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f8960d64e93606fa52220cc9c4ae35a2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 11:21:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4261867172d0fd5c04c993638661ac0b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 11:24:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('32464c6f7f772ddda0a963b19ad2fd70', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 11:30:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d29cf7aae44523bf2f3d187e91356fe8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 12:20:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0e9c0d0d26ddc652a7277912e0784d11', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 12:27:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('25f8b1b345b1c8a070fe81d715540c85', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-23 15:39:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8327cced60486bad4009276e14403502', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 09:56:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('515c28df59f07478339b61ca5b1b54a8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 10:34:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fa0612372b332b6c3ce787d9ca6dd2cc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 11:48:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8300e85a2c2f16c2358d31e8b364edf7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 11:55:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3d9874f248a984608ca98c36c21c5a7a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 13:05:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cc8ab347f332c55570830c5fc39bbf9f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 13:08:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8742a458bf166fd5f134ac65fa8903f9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-24 13:09:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bbe2e637bafa0d7f465dc9e1266cff3d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 11:16:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b3474fc5aad9ec2f36ccbbf7bf864a69', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 11:17:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('260bb025d91b59d0135d635ef85eeb82', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 11:40:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1a5b71c9458c17f9bcb19a5747fd47dd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 11:56:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e720278084b0d4316448ec59d4e3399d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 15:52:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f6646950c8465da1d1219b7a7a209fc2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 19:14:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('36358cacfc5eb3ba7e85cfe156218b71', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 19:14:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ee2bb63c47c868d59a45503b3d2f34ea', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 19:16:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b0d11dfec52e02f504c63e2f8224b00d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-25 19:27:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4acfbc327681d89dab861c77401f8992', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 10:54:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('96ada57ac17c4477f4e4c8d596d4cc1a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 10:54:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e4e40e21437b23b74324e0402cceb71a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 11:34:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d92d9e003666c6b020f079eaee721f9f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 12:08:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('68f7394ca53c59438b2b41e7bb9f3094', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 14:09:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a9b34565c6460dc9cede00ad150393f9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 14:17:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fa427f74dc6bd9cca3db478b5842f7f7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 14:19:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8b66ec251e3107765768dbd0590eeb29', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 14:25:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e42a38382fce916909d6d09f66147006', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-28 14:28:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ed0bbe9047a7471ae1cdc1c2941eccb1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-29 17:52:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('36fd54ce8bc1ee4aac9e3ea4bfdcd5a8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-29 18:49:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('40b3a9bee45b23548250936310b273f4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 14:42:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c9be887c9292153e39861c91243b7432', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 15:12:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e40823376fa8c0e74a4e760de695e824', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 15:36:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('993010965223b8e3a7a784409f7e377e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 15:50:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aa47c8cf2a4f2de16f415b9d9d3dbf05', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 16:14:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4a0020835a71fc6dcaefd01968d21f81', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-30 18:46:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fa9cebbb6af23d2830584b3aacd51e46', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-31 13:59:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('60a975067f02cf05e74fa7b71e8e862a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-31 14:31:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fbb8834e9736bdd4b6d3baee895c4ca4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-01-31 18:05:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('623e4bc7c098f368abcc368227235caf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-01 09:48:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9f31eedbe3f3c5c431b490d5fec0094c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-01 09:56:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b945fe8b63e0fc26d02c85466f36ebd9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-01 09:57:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('968d434c45aae64c9ad0e86d18238065', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-01 10:02:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('732a1015057fde25d81ee12a7fbf66b2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-01 10:05:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d9a0bb9fe6d2c675aa84f9441c0bd8bb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 10:56:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9c64406daa2b6e7ad1f6776789d61e43', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 10:56:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1912a44dd4a6ffa1636d2dde9c2f1ab7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 11:01:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d19b6e77ab1b6d6aa58996a93918754c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 11:33:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('81f7a606359aff9f97f95c15ce8e7c69', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 11:33:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7da063020a42db99e0f3bb9500498828', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 13:45:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b6ee157afd006ceddc8c7558c251192e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-11 14:20:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('65ace1ae98891f48ab4121d9258e4f1e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 10:45:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e2af7674bb716a7c0b703c7c7e20b906', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 11:38:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('60d4f59974170c67826e64480533d793', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 13:25:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('775e987a2ca37edc4f21e022b265a84a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 13:36:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dd6fbb9b6224c927c0923c16b9285525', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 13:37:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f3d371d6f71409ea2fe52405b725db4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 13:38:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c33b4e0bbf998330e44fad65e9d0029e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 15:54:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('189842bf681338dc99dfa66d366a0e6f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 15:55:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e14cd21cf5eaad9ea3689730a824a50c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 16:12:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5cf2431447eab30fd3623e831033eea0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-12 19:17:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9bfe7312f2951503082a28c2cc966ce4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 10:24:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('da9a15efcf4e1e4f24647db7e2143238', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 11:19:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8317a81bce60a10afeb44af6ef6c807a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 11:27:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0a6eb1fa998b749012216542a2447ae7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 11:29:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e5a9b045449136719d4c19c429c2dd56', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 13:08:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aaf10eab9c2b6ed6af1d7a9ce844d146', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 13:08:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b4ccdfc1280e73439eb1ad183076675b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 14:10:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('018fe8d3f049a32fb8b541c893058713', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 15:17:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f3aab8f9dff7bf705aa29c6dcce49011', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 15:18:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('efa591832b375b4609a5890b0c6f3250', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:00:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c6822927334eb0810b71465fd9c4945', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:02:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7289cf420ac87ea0538bde81435b1aaa', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:03:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('db8adca4aa7972fdc283be96d877efe0', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:04:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c5e541648bab341230c93377b4d4e262', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:05:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e261674e2640fe6d0a3cd86df631537d', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:05:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('406e79995e3340d052d85a74a5d40d1b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:23:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4de1ed55165f7086f1a425a26a2f56ec', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 16:26:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d8eed69045aae6cedbff402b4e35f495', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-13 18:22:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bbf4fb593d6918cc767bb50c9b6c16c5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 10:44:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('506ce2d73a038b6e491a35a6c74a7343', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 13:44:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4303dbb3e502f11a3c4078f899bb3070', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 17:28:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2de252a92b59ebfbf16860cc563e3865', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 22:04:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e4c330b381e2fbfde49f1d4dd43e68b7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 22:22:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('22735c059b01949a87cb918f5ef3be76', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 22:41:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c5954beca75d6a0c014e2de3b621275a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-14 22:41:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('db8c89112bf4706fb558664dd741aa46', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 09:33:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fa0ce422c12a565461eca56006052891', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 10:13:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a34ed4c6fef2b9f07a20e54ef4501b99', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 10:48:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b55cc05e8dd4279c0fa145833db19ba8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 11:37:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5c675eeb69795180eee2c1069efc114b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 12:59:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5dee273feb8dd12989b40c2c92ce8c4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 13:42:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('994efef0ebca19292e14a39b385b0e21', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 16:22:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fc22aaf9660e66558689a58dfa443074', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 16:30:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c6ede513b83fbc23aaedb89dbfa868a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 18:03:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('13c1e763e9d624a69727a38b85411352', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 18:39:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fadb32d678346ee4bab02997988ff3bc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-15 22:55:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0aa792eadeae39a1ed2a98ea5d2f6d27', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-16 09:11:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0aa9272c0581e1d7f62b1293375b4574', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-16 17:26:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('81c9056ac38e6f881d60f3d41df1845e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-17 11:44:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eb4536aa50a58985baf0a763a1ce2ebf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-17 19:48:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f9062582881b42f6b139c313d8ab0463', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-17 20:47:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('22d8a2fbd53eafb21f6f62ae073c0fc1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-17 22:28:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7bc7b1ff923dbb19fb0ecd800cd690bd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-18 09:34:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('faea0dbfb7f86b571fed0dd270623831', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-18 14:12:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('063baad688535096d2ed906ae6f3a128', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-18 22:09:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('528baecc596a66eaadc8887bff911f55', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 10:08:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e540ca989819c54baefffbc3d05e8b58', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 10:10:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0643f3ad4394de9fb3c491080c6a7a03', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 10:18:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eb0b8a7cdf77df133566d7bd5a5f1fc0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 11:02:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0913bb0e92715892c470cf538726dfbc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 16:17:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5034aec34f0b79da510e66008dbf2fcc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 16:18:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e4afd66ac249dde9c3bd9da50f9c2469', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 17:41:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('07132c1228b1c165f62ea35f4ff1cbe9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 18:15:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4f7f587bec68ed5bf9f68b0ccd76d62b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-19 21:01:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('12709e62742056aa4a57fa8c2c82d84a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 09:13:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('680b3e6e4768d80d6ea0ce8ba71bdd0e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 09:14:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a6e323785535592ee208aa7e53554644', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 09:15:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3a4a0e27d77aa8b624180e5fd5e4004e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 09:51:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b98b7ac9e890657aa86a900763afbe2a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 11:49:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d1eb2a8ebed28d34199c5fc4a1579c4c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 12:55:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('85949de2d54078e6b8f3df0a3c79c43d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:08:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('77579d78a903635cc4942882f568e9e5', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:13:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('679e12ba247575749e03aa8f67347ac6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:14:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5c35117cbeb39428fcc2ddd90ce96a2b', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:18:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7225200c3cec4789af4f1da2c46b129d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:19:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('22ad9f87788506456c774801389d6a01', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 17:20:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('81c95e1c8805fa191753fc99ba54c3e9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:01:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7285730e2644f49def0937dc99bfbe3d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:07:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4922f2f1173a1edc11dfd11cb2a100ae', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:08:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e37cce529d0c98c47b4977d7ddf963c0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:17:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('66493cd0347eeb6ee2ef5ee923604683', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:29:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f04910792a74c563d057c4fcb345f963', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:30:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('210a01dcb34302eaed0d1e95820655d0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:30:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('48929ec94226d9ccff9fae4ff48e95e3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:32:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d2ac19a709ea08f7259286df28efd635', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:35:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d8fd478e6ceb03a575719e1a54342333', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:43:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a35a476c303983701045507c9af3fa03', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-20 18:44:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7e41208e29d412d586fc39375628b0d0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-21 15:34:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1f33d11e1833ae497e3ef65a3f02dd5b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-21 19:51:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dae0658783324c81fa6909b6e4a25a65', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 11:46:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a77d29673cfe97c9e03cfb879b934f62', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 12:41:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('baaf37e5937f938ac92856bc74cc2b86', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 13:48:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3f47afcdce94596494746ac34eebf13b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 13:59:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b99fc7c53d4e3edc0c618edc11d3a073', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 15:58:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('024a4c5ba78538d05373dac650b227d1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 15:59:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('873f425879ef9ca7ced982acda19ea58', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 16:35:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1b05434820cbcb038028da9f5cda31bb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 17:45:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5f314fc45492d7f90b74d1ca74d1d392', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 17:45:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('20751803c1e5b2d758b981ba22f61fcd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 18:11:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('50e8de3e6b45f8625b8fd5590c9fd834', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 18:23:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6737424e01b38f2273e9728bf39f3e37', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-22 19:43:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0473dedf4aa653b253b008dacff2937c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 13:04:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a95192071de908f37f4998af4c269bcb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 14:26:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3569ada5c43a4022d3d13ac801aff40e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 14:50:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('562092eb81561ee0f63be5dd9367d298', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:20:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('131ccd390401b6e3894a37e4d1d195d3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:26:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c12e3d7655a5a8b192bb9964a2a66946', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:35:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6bc98b7dc91a3924f794202867367aca', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:50:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('002b7112a147edeb6149a891494577d0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:52:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('202344b08b69ad70754e6adaa777eae0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:54:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eeb1f2e2c1b480e0bb62533848cbb176', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:55:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('94fe4465d779e0438cfe6f0cb1a1aa7e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:57:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d03aaee882d13b796db860cb95f27724', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 22:59:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1db82f78233c120c6ec7648ca1177986', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 23:07:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7dc448f04edf4b9655362ad1a1c58753', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 23:10:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fce1553149aea9bfd93e089f387199c8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 23:11:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e713a89e753cbecf1e10247b2112c3f8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-24 23:14:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0a634ed086442afa7a5fc9aa000b898a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:10:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bfa0766f53dbd3a0fe4043f57bd9bbee', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:35:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e3b531fa12e47ac19a2ab0c883dee595', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:40:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('18eafaeec588403245269a41732d1a74', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:45:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('99357d793f2507cfb7b270677b4fe56c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:46:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b38f42f4e15ee72e494bdf6f6feb0ae7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:49:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bfe758860662ae07a15598396a12cfaa', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:50:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69a7a5b960d6aedda5c4bd8b877be0a8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:50:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4084f184160940a96e47d7be1fab4ea3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1241cf8e9fd0e28478a07bf755f528c5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e0da357be27d66de1c9e9b8ecb22f9f9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9f4960f89a10d7fdcf22d1ea46143fff', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ab8a71b7565d356d12e12c6730b0ceb0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('35fdedc363d9fe514b44095da40f170b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:51:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7126b35521cd0dba932e6f04b0dac88f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:52:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9bd6e11c5a2f0bb70215cfa097a4b29c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 10:57:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7e2edea80050d2e46aa2e8faef8e29ce', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:01:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('190eb7b4d493eb01b13c5b97916eeb13', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:09:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ea268ad02db29012b2f1bd3d4aea1419', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:10:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7dc498b45fbf25c59686d9dda0d3eb66', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:12:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('583d3aa445d408f4ecd19ee0a85514af', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:18:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9cea908c7a78dc77fdaed975819983bd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:20:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d70329497664391dabc25effe7406c50', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:25:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0b9940fc5487026a3f16cade73efead5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:28:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f21f9f700bf4f5bd9edda7a16ed338f8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:30:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f5c08b45885d248c422a5d406cd5f223', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:41:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e9a31bfc128b3f5ae01656916c605ddb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:44:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6baccd034e970c6f109791cff43bc327', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:46:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d2b516c5d834bd0fca91cda416fe499e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:46:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f9abb524e0dc3571571dc6e50ec6db75', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:47:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d1111594fef195980370c5f91ccf9212', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:48:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9174fe77fe8ba69243f72d5577b391d3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:48:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2ab9cf95ac35fdbb8fe976e13c404c41', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:49:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9be945480d69038865279f02df5cee45', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:49:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c2bfe3b92e6bfb7016cc82e95419a602', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 11:54:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7c310b99a84411798a2aaf4074a28e7e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:42:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b23293288a84ba965509f466ed0e7e2f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:43:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cf590576a5f6a42b347e6b5bf5ebf5bd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:43:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b5df1807f08af5db640da11affec24d3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:49:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2746af3dd0309cdeeff7d27999fbcda1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:52:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2a383edf5445dc8493f5240144ca72f5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 12:56:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d2910961a0ff046cc3ef6cf8d33a8094', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 15:38:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('00f763e007e5a6bddf4cb8e562a53005', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 15:41:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8ab131214232450ca202103ef81f0a2d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 15:46:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('606cb4f81f9bb412e2b2bdaa0f3e5dda', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 16:27:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7b85fba62bc001773fff1a54e1609aef', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 16:28:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b3127e34f395e1f1790450da5689a4a1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 16:28:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fb2871cda1421b766f8e68cb36a22bf3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:35:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('29fb5d4297748af3cd1c7f2611b7a2d6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:38:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('580256f7c7ea658786dba919009451b6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:39:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8802209912ca66d56f2ea241ffd0cc13', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:52:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4778fe2992fd5efd65f86cb0e00e338e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:53:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d68957c067fb27e80a23babebdb1591f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:55:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('472c34745b8f86a46efa28f408465a63', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 17:56:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('26975f09c66025d1c8d87a6894a3c262', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 18:29:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e4a166fcd0fc4037cb26e35cc1fb87b2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 18:32:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('286af82485388bfcd3bb9821ff1a4727', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 18:34:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eaf74cd1489b02d39c470eed131fc918', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 18:37:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e48a6bd82c92a8005c80c5ef36746117', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 19:32:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('10922e0d030960e6b026c67c6179247b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-25 20:07:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b53c9e8ce1e129a09a3cda8c01fe644c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:38:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('65be8e015c9f2c493bd0a4e405dd8221', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:40:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8ff27392165c8c707ee10ec0010c7bb8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:44:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('337b647a4085e48f61c7832e6527517d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:45:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('caee69e55ec929f7ba904280cac971e6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:49:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bdeae62057ae9858b6a546c1bdb6efc7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:49:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ea66ed22fde49640cee5d73c6ef69718', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:50:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('47c5a5b799e10255c96ccd65286541ef', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:50:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cfba34db2d7fbb15a2971212f09b59ec', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 11:51:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('faad055dd212ed9506b444f8f1a920b9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:00:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ef7219725c4b84cc71f56f97a8eab01a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:08:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2811e224e4e8d70f2946c815988b9b7c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:08:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7feae2fb5001ca0095c05a8b08270317', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:17:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b4c3c7af9899b9af3f42f730cfabc9b2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:17:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('28e8a7ed786eaced3182c70f68c7ea78', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:18:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3a76114e431912ff9a19a4b6eb795112', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:19:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('557b3c346d9bc8f7a83fac9f5b12dc1b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:20:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e92544c6102243e7908e0cbb217f5198', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 12:48:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('61445cc950f5d04d91339089b18edef9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:13:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('776c2e546c9ab0375d97590b048b8a9d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:13:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ef7669ac0350730d198f59b8411b19d1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:28:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b3cceb535fa5577cc21b12502535ad29', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:29:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('18a51a5f04eeaad6530665f6b0883f0c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:34:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8a13971104d70e35111d10dd99de392e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:34:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6d93d5667245ef8e5d6eafdbc9113f51', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:34:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7ba3df5d2612ac3dd724e07a55411386', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:35:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7148b3d58f121ef04bcbea5dd2e5fe3b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:35:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('709b0f2bf8cb8f785f883509e54ace28', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:37:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4114145795da30b34545e9e39b7822d9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:39:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f543c25bdd741055aeb4f77c5b5acf58', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:40:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bc594b8921a0bcdb26d4a93916316092', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 14:42:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('11f511eeeb2e91af86b9d5e05132fc89', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 15:13:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('810deb9fd39fa2f0a8e30e3db42f7c2b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 18:51:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d5b9e5d9bfbbd8e6d651087ead76d9f7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 20:17:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('016510fc662d9bb24d0186c5478df268', 1, '用户名: admin,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-02-26 20:27:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eb6f5196de91dd2e8316696bddd61345', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 22:26:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d762a1cba3dc23068f352323d98909e0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-02-26 22:26:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69fc2407b46abad64fa44482c0dca59f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-01 12:04:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0d6cd835072c83f46d1d2a3cf13225d3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-01 12:04:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e78f8832d61c1603c17767ee2b78ef07', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-01 19:50:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0475b4445d5f58f29212258c1644f339', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-01 20:20:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2b5a76869a7d1900487cd220de378dba', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-05 16:32:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('21b8493a05050584d9bb06cfc2a05a6b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-05 17:29:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a61d9db83888d42b0d24621de48a880d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-05 22:49:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('097be3e8fdf77a245f5c85884e97b88c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-05 22:52:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7b2b322a47e1ce131d71c50b46d7d29e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-06 15:55:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cedf399271592c27dcb6f6ce3312e77d', 2, '删除测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.delete()', NULL, '[\"7501\"]', NULL, 24, 'admin', '2019-03-06 16:03:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('efe77038e00cfff98d6931c3e7a4c3d6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-06 16:20:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ffac84fff3c65bb17aa1bda3a0d2029e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-06 20:10:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('45819fe1b96af820575a12e9f973014e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 09:19:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('87885bc889d23c7c208614da8e021fb0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 10:23:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('54c2bad38dafd9e636ce992aa93b26af', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 11:57:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d3c4f120d8a23b62ec9e24b431a58496', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 14:17:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d01d658731dac4b580a879d986b03456', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 15:00:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ab550d09101a88bc999ea57cbb05aa5a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 17:59:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aeb738ab880c262772453d35fc98f2f2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 18:50:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('375aadb2833e57a0d5a2ce0546a65ca4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 20:38:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('96d7fe922f46123e0497e22dedf89328', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-07 23:10:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('636d37d423199e15b4030f35c60859fe', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 10:07:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a7d1f4a774eb8644e2b1d37ca5f93641', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 10:16:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('017e9596f489951f1cc7d978085adc00', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 10:58:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0b42292a532c796495a34d8d9c633afa', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 12:58:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b428718441be738cf8b5ce92109068c3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 16:21:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('89d2bc84e056f327291c53821d421034', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 16:57:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e09bb0a74c268a9aaf1f94edcc2eb65a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-08 18:26:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0dc22e52c9173e4e880728bc7734ff65', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 11:14:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5358b182eab53a79eec236a9cee1e0fc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 13:01:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('23176e4b29c3d2f3abadd99ebeffa347', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 16:37:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('703fbcb7e198e8e64978ec0518971420', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 17:53:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9e9d01c430b72703ce3a94589be54bbe', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 18:26:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ef54197116da89bf091c0ed58321eea4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 19:22:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('111156480d4d18ebf40427083f25830f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 19:48:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a9bd713f975bfbff87638432a104b715', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:04:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('06fbb85b34f518cd211b948552de72f8', 1, '登录失败，用户名:null不存在！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:08:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9b568a868e57f24c5ba146848061613f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:09:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('02026841bf8a9204db2c500c86a4a9be', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:44:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c1a68605bee6b3d1264390c1cfe7a9fa', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:49:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cbd720f20fc090c7350a98be0738816a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 20:55:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2676be4ffc66f83221fd95e23d494827', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 21:31:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e9d3202c14f7f2812346fb4c2b781c67', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 21:38:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d9e0150666b69cced93eb4defb19788b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 23:11:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1f0b36f7e021aa5d059ffb0a74ef6de4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-09 23:11:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('326b2df4ab05a8dbb03a0a0087e82a25', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-10 11:53:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7ae9cad197aee3d50e93bc3a242d68ec', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-10 13:12:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('78caf9e97aedfb8c7feef0fc8fdb4fb5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-10 17:04:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d00964eee24c6f9a8609a42eeebef957', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-10 17:04:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('04f97d7f906c1e97384a94f3728606a4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 12:08:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2b433e88db411bef115bc9357ba6a78b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.105', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 12:09:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('63ccf8dda5d9bf825ecdbfb9ff9f456c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.105', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 12:14:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('404d5fb6cce1001c3553a69089a618c8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 12:29:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9ed114408a130e69c0de4c91b2d6bf7e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 13:03:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2eb964935df6f3a4d2f3af6ac5f2ded1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.200', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 13:27:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e864c0007983211026d6987bd0cd4dc8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.114', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 13:37:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8b2ad448021fbb5509ea04c9a780b165', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 14:35:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69a9dfb2fb02e4537b86c9c5c05184ae', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.104', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 15:22:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('98b7fc431e4654f403e27ec9af845c7b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 17:31:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('42bf42af90d4df949ad0a6cd1b39805e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.200', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 17:39:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e234abc35a52f0dd2512b0ce2ea0e4f2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-11 20:05:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69baa4f883fe881f401ea063ddfd0079', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-12 20:51:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a867c282a8d97f7758235f881804bb48', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-13 18:28:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1aa593c64062f0137c0691eabac07521', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 10:45:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('de978382f59685babf3684d1c090d136', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 12:55:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('75c7fa1a7d3639be1b112e263561e43a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 17:07:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7a9d307d22fb2301d6a9396094afc82f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 18:45:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('28dbc8d16f98fb4b1f481462fcaba48b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 20:56:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f1186792c6584729a0f6da4432d951f9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-14 21:45:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4f31f3ebaf5d1a159d2bb11dd9984909', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-15 11:14:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9a5c1fbf3543880af6461182e24b75db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-15 13:51:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b86958d773b2c2bd79baa2e8c3c84050', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-15 16:49:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a052befb699ee69b3197b139fd9263f0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-15 17:34:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6836a652dc96246c028577e510695c6f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-15 20:47:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8fe913a5b037943c6667ee4908f88bea', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-16 11:18:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9410b7974fbc9df415867095b210e572', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-16 11:18:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('98d4b573769af6d9c10cd5c509bfb7af', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-16 11:21:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('18b16a451fec0fe7bf491ab348c65e30', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-16 11:55:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0d85728028ed67da696137c0e82ab2f6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-16 12:58:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4aa770f37a7de0039ba0f720c5246486', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:26:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2fecb508d344c5b3a40f471d7b110f14', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:36:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('61aac4cfe67ec6437cd901f95fbd6f45', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:40:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('62e208389a400e37250cfa51c204bdc8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:44:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eb9a522fd947c7a706c5a106ca32b8c9', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:50:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bd9167a87aee4574a30d67825acaad0a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:51:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('49f1ec54eb16af2001ff6809a089e940', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:59:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bdfd95b4d4c271d7d8d38f89f4a55da9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:59:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('95063e0bdfa5c9817cc0f66e96baad93', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 17:59:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('30da94dd068a5a57f3cece2ca5ac1a25', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 18:01:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8fde5f89e8ad30cf3811b8683a9a77b1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 18:02:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2ebe7f0432f01788d69d39bc6df04a1a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 18:05:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('beb9ef68b586f05bd7cf43058e01ad4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-17 22:29:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('befbcf5a27ef8d2ca8e6234077f9413d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 16:01:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('378b44af9c1042c1438450b11c707fcf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 16:07:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0571e5730ee624d0dd1b095ad7101738', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 16:10:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3ec2023daa4a7d6a542bf28b11acf586', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 16:18:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('64c00f27ddc93fda22f91b38d2b828b5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 17:34:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('21bad1470a40da8336294ca7330f443d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 17:35:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('72ee87d0637fb3365fdff9ccbf286c4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 17:36:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d8c43edd685431ab3ef7b867efc29214', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 17:37:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0ad51ba59da2c8763a4e6ed6e0a292b2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 17:37:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d916bd1d956418e569549ee1c7220576', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 19:18:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('917dbb5db85d1a6f142135827e259bbf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 20:21:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('db2b518e7086a0561f936d327a0ab522', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 22:39:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('61d2d2fd3e9e23f67c23b893a1ae1e72', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 22:44:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('671a44fd91bf267549d407e0c2a680ee', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 22:45:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('586e8244eff6d6761077ef15ab9a82d9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-18 23:03:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2b4d33d9be98e1e4cdd408a55f731050', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 10:32:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3267222d9387284b864792531b450bfe', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 10:33:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a28de45f52c027a3348a557efab6f430', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 10:34:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9db7e7d214dbe9fe8fff5ff20634e282', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 11:19:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('74209dfc97285eb7919868545fc2c649', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 11:23:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('49d48fda33126595f6936a5d64e47af0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 13:17:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fe0dc06eaef69047131f39052fcce5c4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 13:56:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f540eff3f6e86c1e0beccd300efd357f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 15:15:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3fd0d771bbdd34fae8b48690ddd57799', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 17:17:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('27e8812c9a16889f14935eecacf188eb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 18:52:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('88bab180edf685549c7344ec8db7d954', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 19:07:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ed9b4ffc8afab10732aac2d0f84c567b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-19 19:10:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ad97829fe7fefcd38c80d1eb1328e40f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 09:28:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3d25a4cdd75b9c4c137394ce68e67154', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 09:59:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5c7e834e089ef86555d8c2627b1b29b5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:25:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b3adf055f54878657611ef430f85803e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:33:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8d105ea6c89691bc8ee7d4fd568aa690', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:39:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('445436e800d306ec1d7763c0fe28ad38', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:43:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7f9c3d539030049a39756208670be394', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:44:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('feaf7c377abc5824c1757d280dd3c164', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 11:58:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c72bb25acd132303788699834ae039b4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:06:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e4c06405615399d6b1ebea45c8112b4d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:07:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f95d517f43ba2229c80c14c1883a4ee9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:11:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d18bff297a5c2fa54d708f25a7d790d6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:13:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b5f6636c6e24e559ddf1feb3e1a77fd5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:14:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aeca30df24ce26f008a7e2101f7c513c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:27:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cd7a7c49e02ca9613b6879fda4e563cf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 12:29:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a7ee4b4c236bc0e8f56db5fdf1e5ac38', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 13:21:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6d45672f99bbfd01d6385153e9c3ad91', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 13:49:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('905d2cf4308f70a3a2121a3476e38ed0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 14:00:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('27d23027dc320175d22391d06f50082f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 15:50:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('52fde989fb8bb78d03fb9c14242f5613', 1, '用户名: admin,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-20 17:04:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('952947331f8f3379494c4742be797fc3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-20 18:42:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('39caf3d5d308001aeb0a18e15ae480b9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 10:31:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('772f238d46531a75fff31bae5841057c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 11:31:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f79af48e6aeb150432640483f3bb7f2a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:09:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('20fc3263762c80ab9268ddd3d4b06500', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:36:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e8b37ad67ef15925352a4ac3342cef07', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:38:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d6aaf0f8e2428bf3c957becbf4bcedb4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:38:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3bc73699a9fd3245b87336787422729b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:41:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('862aa0e6e101a794715174eef96f7847', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:41:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a6209166e1e9b224cca09de1e9ea1ed7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:41:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b954f7c34dfbe9f6a1fc12244e0a7d59', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:41:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('64711edfb8c4eb24517d86baca005c96', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:41:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0efc9df0d52c65ec318e7b46db21655f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:42:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c03985d6e038b5d8ebdeec27fce249ba', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:43:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('69e6fd7891d4b42b0cccdc0874a43752', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:45:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9b23981621d5265a55681883ec19fa91', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:46:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('37ca8ff7098b9d118adb0a586bdc0d13', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:46:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ea5f9191b0f593a1d6cb585538caa815', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:46:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8e03def9e0283005161d062d4c0a5a80', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:46:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f78e24f5e841acac2a720f46f6c554bc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:47:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f93279c6899dc5e6cec975906f8bf811', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:47:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cd5af66a87bb40026c72a748155b47e8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:47:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5902fb4ba61ccf7ff4d2dd97072b7e5b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:48:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e1d1fc464cf48ec26b7412585bdded1a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 13:49:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5ea258e1f478d27e0879e2f4bcb89ecd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 14:01:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2e44c368eda5a7f7a23305b61d82cddb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 18:14:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('34a6b86424857a63159f0e8254e238c2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 18:22:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ffc6178ffa099bb90b9a4d0a64dae42b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 18:28:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3612f8d40add5a7754ea3d54de0b5f20', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 19:59:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7a511b225189342b778647db3db385cd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 20:50:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b7085f003b4336af4d4ba18147f8e5ae', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 22:29:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c66e22782dd3916d1361c76b0cc4ec8a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-21 22:44:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c6cbe54fcb194d025a081e5f91a7e3f0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 10:26:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1ab7c74d217152081f4fa59e4a56cc7b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 12:03:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5f00b5514a11cd2fe240c131e9ddd136', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 16:30:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('82cee1c403025fc1db514c60fc7d8d29', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 16:41:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('af5869701738a6f4c2c58fe8dfe02726', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 16:42:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('233e39d8b7aa90459ebef23587c25448', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 17:38:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b0cebd174565a88bb850a2475ce14625', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 18:19:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('26529d5753ceebbd0d774542ec83a43e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 20:17:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f3e1f7fb81004ccd64df12d94ef1e695', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 21:30:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a2e0435673b17f4fb848eecdf8ecacd6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 21:32:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5323f848cddbb80ba4f0d19c0580eba9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 22:58:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5858f2f8436460a94a517904c0bfcacb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-22 23:42:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8d9ce65020320d46882be43b22b12a62', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 10:56:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('11802c7a3644af411bc4e085553cfd4f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 14:46:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fc69a1640a4772c8edf2548d053fa6de', 1, '用户名: admin,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-23 14:55:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e3031f999984909f9048d8ec15543ad0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 18:43:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f43e38800d779422c75075448af738d1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 18:47:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dcfe23b155d5c6fa9a302c063b19451e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 18:47:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('802cec0efbe9d862b7cea29fefc5448b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 18:58:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f58e160e97d13a851f59b70bf54e0d06', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 20:11:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b8bd2a9de3fb917dfb6b435e58389901', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 20:13:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e01ed1516e8ae3a2180acbd4e4508fa5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 20:28:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b7f33b5a514045878447fc64636ac3e6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 22:00:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d0ce9bfc790a573d48d49d3bbbf1a1cb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 22:09:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('74c991568d8bcb2049a0dbff53f72875', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 22:12:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0251bbee51c28f83459f4a57eeb61777', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 22:14:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a5848ab4e8d0fb6ecf71ee1d99165468', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 22:14:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('79a1737fcc199c8262f344e48afb000d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-23 23:25:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6cfeaf6a6be5bb993b9578667999c354', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-24 11:43:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c5d4597b38275dcb890c6568a7c113f2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-24 12:18:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0f173ec7e8819358819aa14aafc724c0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:15:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ce9893f4d0dd163e900fcd537f2c292d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:55:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('90711ddb861e28bd8774631c98f3edb9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:57:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fb73d58bf6503270025972f99e50335d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:57:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3a290289b4b30a1caaac2d03ad3161cd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:58:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('716f9f5f066a6f75a58b7b05f2f7f861', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:59:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('151a9f1b01e4e749124d274313cd138c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 11:59:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0ef3e7ae8c073a7e3bdd736068f86c84', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:02:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d7e7cb4c21372e48b8e0ec7e679466e3', 1, '用户名: null,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:02:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('15b9599cb02b49a62fb4a1a71ccebc18', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:02:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ecfee5b948602a274093b8890e5e7f3f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:05:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cbf83d11486a8d57814ae38c9822b022', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:05:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f2ce8024e62740f63c134c3cfb3cae23', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:07:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c665d704539483630cc9ed5715ed57a8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:10:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e93f1a170e3cd33f90dd132540c7a39b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:12:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fded8eb5d78d13791baec769019fee54', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:15:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('03ec66b6b6d17c007ec2f918efe5b898', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:16:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5e8bac7831de49146d568c9a8477ddad', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:16:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cd064a2f6cb6c640cb97a74aaa6041d7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:17:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a521d9f2a0087daa37923fa704dea85b', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:45:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4816854636129e31c2a5f9d38af842ef', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:45:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('90b4bad7939233a1e0d7935f079ea0fa', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:45:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aec0817ecc0063bde76c1f6b6889d117', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:47:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e169938510c9320cb1495ddb9aabb9d1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:47:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b7478d917ab6f663e03d458f0bb022a3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:50:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('642e48f2e5ac8fe64f1bfacf4d234dc8', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:51:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ed2740de487c684be9fa3cf72113ae30', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:51:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b1e9797721dbfcc51bbe7182142cbdcd', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:52:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6a67bf2ff924548dee04aa97e1d64d38', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:52:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a56661bbc72b8586778513c71f4764f5', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:53:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ae61be664d2f30d4f2248347c5998a45', 1, '用户名: jeecg,退出成功！', NULL, 'jeecg', 'jeecg', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-03-25 12:53:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4ab79469ba556fa890258a532623d1dc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:54:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3a0330033a8d3b51ffbfb2e0a7db9bba', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:54:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b972484d206b36420efac466fae1c53f', 1, '用户名: jeecg,退出成功！', NULL, 'jeecg', 'jeecg', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-03-25 12:54:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7e92abdc0c1f54596df499a5a2d11683', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 12:59:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('fa9b4d7d42bc9d1ba058455b4afedbfb', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 12:59:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1d970c0e396ffc869e3a723d51f88b46', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 13:01:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('88d7136ed5c7630057451816dbaff183', 1, '用户名: jeecg,退出成功！', NULL, 'jeecg', 'jeecg', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-03-25 13:01:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('48eac0dd1c11fe8f0cb49f1bd14529c2', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 13:01:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a8c7ba2d11315b171940def2cbeb0e8f', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-25 13:01:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('20fea778f4e1ac5c01b5a5a58e3805be', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 19:01:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('48e5faf2d21ead650422dc2eaf1bb6c5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 22:08:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f74f759b43afa639fd1c4f215c984ae0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-25 22:08:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d82b170459d99fc05eb8aa1774e1a1c9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-26 18:45:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e088a2607864d3e6aadf239874d51756', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-26 18:46:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('95d906e6f048c3e71ddbcc0c9448cf49', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-26 19:23:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3767186b722b7fefd465e147d3170ad1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-26 21:57:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f21e30d73c337ea913849ed65808525c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 10:23:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('189e3428e35e27dfe92ece2848b10ba8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 15:52:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e2b6d0e751f130d35c0c3b8c6bd2a77e', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-27 16:18:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('586002e1fb4e60902735070bab48afe3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 16:18:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('611fa74c70bd5a7a8af376464a2133e8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 17:48:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('90555a39c0b02180df74752e4d33f253', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 18:26:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('217aa2f713b0903e6be699136e374012', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-27 20:07:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5554869b3475770046602061775e0e57', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 14:38:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bfec8c8c88868391041667d924e3af7f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 14:38:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('675153568c479d8b7c6fe63327066c9f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 15:29:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4930e32672465979adbc592e116226a6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 16:53:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9a1456ef58a2b1fb63cdc54b723f2539', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 17:26:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('484cdb8db40e3f76ef686552f57d8099', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 18:14:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('02d4447c9d97ac4fc1c3a9a4c789c2a8', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-28 18:24:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('59558082e1b1d754fa3def125ed4db3c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 18:24:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c434dc5172dc993ee7cd96187ca58653', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-28 19:46:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a6261bbbf8e964324935722ea1384a5d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 19:46:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f0748a25728348591c7b73a66f273457', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-28 19:46:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('14f447d9b60725cc86b3100a5cb20b75', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 19:46:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7c88e9cf6018a1b97b420b8cb6122815', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-28 19:46:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cb7c6178101ef049d3f1820ee41df539', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 19:59:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('21fed0f2d080e04cf0901436721a77a6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-28 21:53:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4ba055970859a6f1afcc01227cb82a2d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 09:43:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3ba1e54aa9aa760b59dfe1d1259459bc', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 09:44:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7b44138c1b80b67da13b89db756a22b0', 2, '添加测试DEMO', NULL, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"jeecg-boot\",\"createTime\":1553824172062,\"id\":\"5fce01cb7f0457746c97d8ca05628f81\",\"name\":\"1212\"}]', NULL, 25, 'jeecg-boot', '2019-03-29 09:49:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d7e8a7f14967c70d68f5569cb4d11d0a', 2, '删除测试DEMO', NULL, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.delete()', NULL, '[\"5fce01cb7f0457746c97d8ca05628f81\"]', NULL, 9, 'jeecg-boot', '2019-03-29 09:49:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e7f2b0a7493e7858c5db1f1595fa54b1', 2, '添加测试DEMO', NULL, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"jeecg-boot\",\"createTime\":1553824376817,\"id\":\"e771211b77cd3b326d3e61edfd9a5a19\",\"keyWord\":\"222\",\"name\":\"222\"}]', NULL, 7, 'jeecg-boot', '2019-03-29 09:52:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('997bb4cb1ad24439b6f7656222af0710', 2, '添加测试DEMO', NULL, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"jeecg-boot\",\"createTime\":1553824768819,\"id\":\"ee84471f0dff5ae88c45e852bfa0280f\",\"keyWord\":\"22\",\"name\":\"222\"}]', NULL, 5, 'jeecg-boot', '2019-03-29 09:59:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a6c3b28530416dace21371abe8cae00b', 2, '删除测试DEMO', NULL, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.delete()', NULL, '[\"ee84471f0dff5ae88c45e852bfa0280f\"]', NULL, 9, 'jeecg-boot', '2019-03-29 09:59:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d2fe98d661f1651b639bf74499f124db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 10:16:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2186244ae450e83d1487aa01fbeae664', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 14:47:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a5daa58b078cb8b3653af869aeecebd0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 17:14:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f29f3b7b7e14b1389a0c53d263c0b26b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 17:44:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2659c59136fb1a284ab0642361b10cdd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-29 18:40:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a42e5cd05566ea226c2e2fc201860f2c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 11:15:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f06048c147c5bcdbed672e32b2c86b1c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 14:07:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('13c83c56a0de8a702aeb2aa0c330e42c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 14:53:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ab1d707bbfdf44aa17307d30ca872403', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 15:50:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5d8ed15778aa7d99224ee62c606589fb', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-30 15:51:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('42aef93749cc6222d5debe3fb31ba41b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 15:51:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5c04e3d9429e3bcff4d55f6205c4aa83', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 18:14:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('af8fe96a9f0b325e4833fc0d9c4721bf', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-30 18:14:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('21910e350c9083e107d39ff4278f51d6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 18:14:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('636309eec5e750bc94ce06fb98526fb2', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-03-30 18:15:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9d0416e09fae7aeeeefc8511a61650c2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 18:15:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2e63fd1b3b6a6145bc04b2a1df18d2f5', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 19:01:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2966ed2bdf67c9f3306b058d13bef301', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 21:25:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3683743d1936d06f3aaa03d6470e5178', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-30 22:40:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0ba24c5f61ff53f93134cf932dd486db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-31 21:06:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bbd3e1f27e025502a67cf54945b0b269', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-03-31 22:13:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1f8f46118336b2cacf854c1abf8ae144', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 11:02:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ac8cf22c2f10a38c7a631fc590551c40', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 12:04:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7d11535270734de80bd52ec0daa4fc1f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.1.105', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 12:20:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6b4cdd499885ccba43b40f10abf64a78', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 13:04:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('77a329e5eb85754075165b06b7d877fd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 13:25:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0e754ee377033067f7b2f10b56b8784c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 17:17:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9b7a830914668881335da1b0ce2274b1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 17:19:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a1b870eee811cfa4960f577b667b0973', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 18:23:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('85b3106d757d136b48172a9ab1f35bb6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 18:34:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7f31435ca2f5a4ef998a4152b2433dec', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 18:36:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f20cf3fe228ba6196a48015b98d0d354', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 19:25:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('65771bce3f5786dfb4d84570df61a47a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 22:07:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c98a6367b152cf5311d0eec98fab390c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 22:13:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('93b4d26f60d7fb45a60524760bf053e4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 22:20:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3087ac4988a961fa1ec0b4713615c719', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-01 22:54:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a69f4ff4e48754de96ae6fa4fabc1579', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:18:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a63147887c6ca54ce31f6c9e6279a714', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:19:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a2950ae3b86f786a6a6c1ce996823b53', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 09:47:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('615625178b01fc20c60184cd28e64a70', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:47:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('89fbc93e77defb34c609c84a7fe83039', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 09:47:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('432067d777447423f1ce3db11a273f6f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:47:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7d8539ff876aad698fba235a1c467fb8', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 09:47:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('689b8f2110f99c52e18268cbaf05bbb6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:58:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2919d2f18db064978a619707bde4d613', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 09:58:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0dc6d04b99e76ad400eef1ded2d3d97c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 09:59:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('45f0309632984f5f7c70b3d40dbafe8b', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 09:59:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d869534109332e770c70fad65ef37998', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:02:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c21422fa08f8480a53367fda7ddddf12', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 10:02:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1e4533a02fb9c739a3555fa7be6e7899', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:04:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('03c0ab177bd7d840b778713b37daf86f', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 10:04:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('60886d5de8a18935824faf8b0bed489e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:11:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4218b30015501ee966548c139c14f43f', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 10:11:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('de938485a45097d1bf3fa311d0216ed4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:15:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e1d0b1fd3be59e465b740e32346e85b0', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 10:16:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4234117751af62ac87343cbf8a6f1e0f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:17:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('845f732f6a0f0d575debc4103e92bea2', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 10:17:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('cc39057ae0a8a996fb0b3a8ad5b8f341', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 10:20:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('155d2991204d541388d837d1457e56ab', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 11:32:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2312c2693d6b50ca06799fee0ad2554a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 12:11:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d98115c02c0ac478a16d6c35de35053d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 12:50:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('55e906361eeabb6ec16d66c7196a06f0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 12:50:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3836dc3f91d072e838092bc8d3143906', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 12:50:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('add13f513772a63f8ca8bf85634bb72c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 13:09:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a6971e63e3d9158020e0186cda81467d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 14:59:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2eb75cb6ca5bc60241e01fa7471c0ccf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 18:34:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3e69108be63179550afe424330a8a9e4', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-02 18:38:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6c558d70dc5794f9f473d8826485727a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 18:38:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('687810e7fea7e480962c58db515a5e1c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 18:42:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d23e6766cecf911fb2e593eeee354e18', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 18:42:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0819ea9729ddf70f64ace59370a62cf1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 18:59:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('939b3ff4733247a47efe1352157b1f27', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 19:01:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6cf638853ef5384bf81ed84572a6445d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-02 19:25:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bc28d4275c7c7fcd067e1aef40ec1dd4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 10:53:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('43536edd8aa99f9b120872e2c768206c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 10:53:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7268539fbe77c5cc572fb46d71d838f1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 13:22:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f0409312093beb563ac4016f2b2c6dfd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 13:24:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a710ed2de7e31fd72b1efb1b54ba5a87', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 15:30:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b01c3f89bcfd263de7cb1a9b0210a7af', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 17:53:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e1fa52ecbcc0970622cc5a0c06de9317', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-03 18:33:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('790b722fa99a8f3a0bc38f61e13c1cf4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 18:34:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('20e5887d0c9c7981159fe91a51961141', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 20:12:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ce6aa822166b97a78b0bbea62366f8e0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 20:14:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3e6116220fa8d4808175738c6de51b12', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 21:04:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('10a434c326e39b1d046defddc8c57f4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 21:18:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('317e3ae1b6ccdfb5db6940789e12d300', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-03 21:44:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2b801129457c05d23653ecaca88f1711', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-03 21:44:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7a99cf653439ca82ac3b0d189ddaad4a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 10:41:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('68e90e08a866de748e9901e923406959', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 12:37:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2942a12521ac8e3d441429e6c4b04207', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 14:12:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dfacaa7c01ccf0bade680044cced3f11', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 15:25:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f3cafb545e5693e446f641fa0b5ac8cd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 17:07:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('060d541a9571ca2b0d24790a98d170a6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 19:28:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9df97c1b3213aa64eda81c6bf818b02b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 22:42:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('43079866b75ee6a031835795bb681e16', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-04 22:44:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('55d649432efa7eaecd750b4b6b883f83', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 22:44:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ca737885d9034f71f70c4ae7986fafa8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 22:47:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1534f0c50e67c5682e91af5160a67a80', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 22:47:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('93bb98ba996dacebfb4f61503067352e', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 22:47:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5c48703e3a2d4f81ee5227f0e2245990', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-04 23:12:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('70849167f54fd50d8906647176d90fdf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 23:12:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('310bb368795f4985ed4eada030a435a0', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-04 23:22:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('477592ab95cd219a2ccad79de2f69f51', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-05 10:38:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e39f051ba6fdb7447f975421f3b090a7', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-05 12:49:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('4d1be4b4991a5c2d4d17d0275e4209cf', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-05 20:47:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9eb3fb6d9d45e3847a88f65ed47da935', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '192.168.3.22', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-05 20:52:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6664dc299f547f6702f93e2358810cc1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '192.168.3.22', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-05 21:04:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9c32ec437d8f8d407b1bd1165fc0305d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-08 15:01:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('68df65639e82cc6a889282fbef53afbb', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-08 15:01:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('79e76353faffd0beb0544c0aede8564f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-08 17:28:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('da3fda67aea2e565574ec2bcfab5b750', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-08 22:36:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('de37620b6921abcfe642606a0358d30f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-09 15:42:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b0e6b3a0ec5d8c73166fb8129d21a834', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-09 16:56:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('01075aa535274735e0df0a8bc44f62f9', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-09 16:56:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('01ebe1cbeae916a9228770f63130fdac', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-09 16:56:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('baa53d6a534e669f6150ea47565fa5b9', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-09 17:27:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e232f89df26cc9e5eced10476c4e4a2b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 10:05:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('335956cbad23d1974138752199bf1d84', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 10:05:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('bd6d7d720b9dd803f8ad26e2d40870f3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 11:04:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff3f7dbda20cd2734b1238fa5ba17fcf', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-10 11:26:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('672b527c49dc349689288ebf2c43ed4d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 11:26:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('21510ebaa4eca640852420ed6f6cbe01', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 11:41:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3e2574b7b723fbc9c712b8e200ea0c84', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 14:24:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('0d4582c6b7719b0bfc0260939d97274f', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 21:48:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('3e64011b4bea7cdb76953bfbf57135ce', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-10 23:09:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('a83e37b55a07fe48272b0005a193dee6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 09:17:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('30ec2dc50347240f131c1004ee9b3a40', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 10:19:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('7ce1934fb542a406e92867aec5b7254d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 14:53:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5ee6d5fe1e6adcc4ad441b230fae802d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 15:56:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d4ef00700436645680657f72445d38db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 18:05:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('aa49341b29865b45588ad2f9b89c47ea', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-11 19:42:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('d3b54be0510db6a6da27bf30becb5335', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 19:42:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dd4e1ab492e59719173d8ae0f5dbc9a2', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-04-11 19:47:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('056dd4466f4ed51de26c535fd9864828', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-11 19:47:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('89bfd8b9d6fa57a8e7017a2345ec1534', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-12 09:27:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('51aeabed335ab4e238640a4d17dd51a3', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg-boot', '2019-04-12 10:12:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('67181c36b55b06047a16a031fd1262c1', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-17 13:55:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2d5af41d2df82b316ba31fcdf6168d6a', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-17 14:43:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('e2f703771f64b1bcd709204669ae3d93', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-05-17 14:48:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('8143ce0b35bfe6e7b8113e1ecc066acd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-17 14:48:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2bca2d6666c1f6630225252c7b31326c', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-05-17 18:30:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('11695a9dcf44859cda97a4226bebe21b', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-17 18:30:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('40209016cadff6b571a8150c6218cfa8', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-18 11:33:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('23a314588249752842447e4f98783be4', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-19 18:28:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5f0a5e85efbe9c79645ffc0c15fcee1a', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1558261833637,\"id\":\"94f78b1c9753dfb1202d731f540666e1\",\"keyWord\":\"1\",\"name\":\"1\",\"sysOrgCode\":\"A01\"}]', NULL, 30, 'admin', '2019-05-19 18:30:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('57264fff74c4f857bddf5d766951f3c9', 2, '添加测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.add()', NULL, '[{\"createBy\":\"admin\",\"createTime\":1558262155067,\"id\":\"dcb45a2fc661e5cdc341b806e5914873\",\"name\":\"111\",\"sysOrgCode\":\"A01\"}]', NULL, 5, 'admin', '2019-05-19 18:35:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('eef5b90eea8e7394193443cfd7476529', 2, '删除测试DEMO', NULL, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.demo.test.controller.JeecgDemoController.delete()', NULL, '[\"dcb45a2fc661e5cdc341b806e5914873\"]', NULL, 9, 'admin', '2019-05-19 18:36:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('488fc8f3d040fa75c6802898ea88f7d6', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-20 11:38:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6c99cfe2774c15ad030b83723f81d70d', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-20 14:07:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1bf5c5603b79f749d4ee75965b3698db', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-20 14:54:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('5bca377b50c362009738d612cac82006', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-20 14:54:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('2255d6f5e2a3d0839b8b9cfc67816c5c', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-05-20 15:01:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('c7384ed6a6b09ff6704a6b1c1e378cee', 1, '用户名: 管理员,退出成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-07-05 14:45:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('63c998d68b4d0d1529d86b4c0628e072', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-07-05 14:45:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b096a9e76395f1a52d8c260c4eb811fd', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 18:51:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('da7d2236f6f9e0f61897e5ea9b968d4d', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 20:02:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('6ee846271a3d4b9e576b5a0749c49d12', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 20:02:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('f6b0f562257bf02c983b9e3998ff864e', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 22:43:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('9e1da5d8758f2681543971ee43ee14e2', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 22:43:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('dd9b2cfffb798a22d90dada4fdbbbc61', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 23:39:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('b99f5b6975350d86db4c5dd91de9f608', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-08-23 23:40:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185035214331654145', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-18 11:29:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185035238713143298', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-18 11:29:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185035239463923713', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-18 11:29:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185037047527714817', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-18 11:37:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185037216109375490', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 133, 'admin', '2019-10-18 11:37:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185037734533738497', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 24, 'admin', '2019-10-18 11:39:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185037756142792705', 2, '编辑用户，id： e9ca23d68d884d4ebb19d07889727dae', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-10-18 11:39:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185037829144653825', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 12, 'admin', '2019-10-18 11:40:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185039907581669377', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 6, 'admin', '2019-10-18 11:48:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185039947956039681', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 5, 'admin', '2019-10-18 11:48:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185040064834514945', 2, '职务表-添加', 2, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.add()', NULL, '[{\"code\":\"devleader\",\"createBy\":\"admin\",\"createTime\":1571370543072,\"id\":\"1185040064792571906\",\"name\":\"研发部经理\",\"rank\":\"3\",\"sysOrgCode\":\"A01\"}]', NULL, 22, 'admin', '2019-10-18 11:49:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185040066562568193', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 26, 'admin', '2019-10-18 11:49:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185129808478158850', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-18 17:45:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185452151318528001', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-19 15:06:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1185452231589117953', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-10-19 15:06:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197430985244905474', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:26:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197431068325679105', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:26:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197431850395602945', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 41, 'admin', '2019-11-21 16:29:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197431872520556545', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 65, 'admin', '2019-11-21 16:29:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197431893076840450', 2, '职务表-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.edit()', NULL, '[{\"code\":\"devleader\",\"createBy\":\"admin\",\"createTime\":1571370543000,\"id\":\"1185040064792571906\",\"name\":\"研发部经理\",\"postRank\":\"2\",\"sysOrgCode\":\"A01\",\"updateBy\":\"admin\",\"updateTime\":1574324985161}]', NULL, 19, 'admin', '2019-11-21 16:29:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197431893756317697', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 42, 'admin', '2019-11-21 16:29:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197433172830294018', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 22, 'admin', '2019-11-21 16:34:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197433546278539266', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 16, 'admin', '2019-11-21 16:36:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197433566151151618', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:36:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434320656130049', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:39:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434360204222466', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 240, 'admin', '2019-11-21 16:39:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434364826345474', 2, '编辑用户，id： e9ca23d68d884d4ebb19d07889727dae', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2019-11-21 16:39:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434403829178369', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:39:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434443708620802', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 16:39:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434470036267009', 2, '职务表-分页列表查询', 1, 'jeecg', 'jeecg', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 45, 'jeecg', '2019-11-21 16:40:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197434579583098881', 2, '职务表-分页列表查询', 1, 'jeecg', 'jeecg', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 46, 'jeecg', '2019-11-21 16:40:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197448449475338242', 1, '用户名: jeecg,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 17:35:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197448475219976193', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-21 17:35:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197448491221245953', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 98, 'admin', '2019-11-21 17:35:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197449269478547458', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 43, 'admin', '2019-11-21 17:38:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197450304582443009', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 27, 'admin', '2019-11-21 17:42:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197453216322797569', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 526, 'admin', '2019-11-21 17:54:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197454357987155969', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 329, 'admin', '2019-11-21 17:59:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197792320302452738', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-22 16:21:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197792369866543106', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'jeecg', '2019-11-22 16:22:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1197793164787802113', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 381, 'admin', '2019-11-22 16:25:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209402348671193089', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-24 17:16:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209402408473579521', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-24 17:16:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209402471128092673', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 472, 'admin', '2019-12-24 17:16:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209417003212853250', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 42, 'admin', '2019-12-24 18:14:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209646296664756226', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-25 09:25:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209646643298816001', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-25 09:26:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648067323744257', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 28, 'admin', '2019-12-25 09:32:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648217823760385', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 21, 'admin', '2019-12-25 09:33:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648344894394369', 2, '填值规则-批量删除', 4, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.deleteBatch()', NULL, '[\"1192350056519323649,1192349918153428994,\"]', NULL, 23, 'admin', '2019-12-25 09:33:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648345854889985', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 17, 'admin', '2019-12-25 09:33:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648456588709890', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 122, 'admin', '2019-12-25 09:34:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209648997351936002', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 24, 'admin', '2019-12-25 09:36:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209649005795069954', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 25, 'admin', '2019-12-25 09:36:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209649012203966466', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 17, 'admin', '2019-12-25 09:36:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209653324963500034', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 19, 'admin', '2019-12-25 09:53:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209653453917376513', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 15, 'admin', '2019-12-25 09:53:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209660332378755073', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 126, 'admin', '2019-12-25 10:21:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209660342411530241', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 26, 'admin', '2019-12-25 10:21:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209672160353783810', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 170, 'admin', '2019-12-25 11:08:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209672431796555778', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 42, 'admin', '2019-12-25 11:09:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1209847153045913602', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-25 22:43:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231582569151074306', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 22:12:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231582603032662018', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 22:12:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231582605322752002', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 22:12:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231586195961556994', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 22:26:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231586370448797697', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 540, 'admin', '2020-02-23 22:27:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231589034586804226', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 37, 'admin', '2020-02-23 22:38:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231589059643576321', 2, '编辑用户，id： e9ca23d68d884d4ebb19d07889727dae', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2020-02-23 22:38:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590342991548417', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 26, 'admin', '2020-02-23 22:43:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590348280565761', 2, '编码校验规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysCheckRuleController.queryPageList()', NULL, NULL, NULL, 27, 'admin', '2020-02-23 22:43:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590455747022850', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 6, 'admin', '2020-02-23 22:43:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590510293946370', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 15, 'admin', '2020-02-23 22:43:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590533404561410', 2, '编辑用户，id： e9ca23d68d884d4ebb19d07889727dae', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2020-02-23 22:44:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590588148617218', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 45, 'admin', '2020-02-23 22:44:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590598588239874', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 8, 'admin', '2020-02-23 22:44:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590600106577921', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 11, 'admin', '2020-02-23 22:44:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231590978101448705', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 17, 'admin', '2020-02-23 22:45:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231591017582432257', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 41, 'admin', '2020-02-23 22:45:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231593459988566017', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 22, 'admin', '2020-02-23 22:55:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231593466594594817', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 13, 'admin', '2020-02-23 22:55:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231593479697600513', 2, '职务表-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.edit()', NULL, '[{\"code\":\"devleader\",\"createBy\":\"admin\",\"createTime\":1571370543000,\"id\":\"1185040064792571906\",\"name\":\"研发部经理\",\"postRank\":\"2\",\"sysOrgCode\":\"A01\",\"updateBy\":\"admin\",\"updateTime\":1582469742105}]', NULL, 16, 'admin', '2020-02-23 22:55:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231593480725204994', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 16, 'admin', '2020-02-23 22:55:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596465543032834', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:07:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596468936224769', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:07:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596595327381506', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:08:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596596799582209', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:08:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596742199324674', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:08:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231596743692496897', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:08:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231597287962157057', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:10:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231597290327744513', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:10:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231598580457857025', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-23 23:15:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231599446049009666', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 62, 'admin', '2020-02-23 23:19:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231599453611339778', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 17, 'admin', '2020-02-23 23:19:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231599534171336706', 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPositionController.queryPageList()', NULL, NULL, NULL, 25, 'admin', '2020-02-23 23:19:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231599542991958018', 2, '部门角色-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDepartRoleController.queryPageList()', NULL, NULL, NULL, 23, 'admin', '2020-02-23 23:19:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231615277050998786', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-24 00:22:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1231615300820119553', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-02-24 00:22:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249514596631527426', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-13 09:47:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249529903269974018', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-13 10:48:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249536509894365185', 2, '填值规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysFillRuleController.queryPageList()', NULL, NULL, NULL, 33, 'admin', '2020-04-13 11:14:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249536517200842754', 2, '编码校验规则-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysCheckRuleController.queryPageList()', NULL, NULL, NULL, 42, 'admin', '2020-04-13 11:14:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249536526512197633', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 56, 'admin', '2020-04-13 11:14:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249537377049939970', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 29, 'admin', '2020-04-13 11:18:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249538009576148993', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 21, 'admin', '2020-04-13 11:20:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249538062176915458', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 18, 'admin', '2020-04-13 11:21:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249538298790187010', 2, '多数据源管理-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysDataSourceController.queryPageList()', NULL, NULL, NULL, 16, 'admin', '2020-04-13 11:22:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249564271321452546', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-13 13:05:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249577584461778945', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-13 13:58:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1249578759240192001', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-13 14:02:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1270590312324141057', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-10 00:35:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272770114749607938', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 00:56:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272770499283398658', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 00:58:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272772104300933122', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:04:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272772138094440449', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:04:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272773633128935426', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:10:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272773974369120258', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:12:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272774782624083970', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:15:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272780739898912769', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:39:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272780788431204354', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:39:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272784457998413825', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 01:53:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272786611307950082', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 02:02:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1272787100921638914', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-16 02:04:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1273484667296845826', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-18 00:16:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285752998947147778', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-21 20:46:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285753914962169857', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-21 20:49:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285753915004112897', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-21 20:49:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285773939253092353', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-21 22:09:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285805010166390786', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 00:12:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285813174739836929', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 00:45:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285813234387034114', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 00:45:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285866214079504385', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 04:16:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285866654733082625', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 04:17:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1285868419788533762', 1, '用户名: jeecg,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 04:24:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1287979769629192193', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-28 13:14:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288298062403497985', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:19:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288298233149419522', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:20:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299173348798465', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:23:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299249257312257', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:24:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299258828713985', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:24:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299297483419650', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:24:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299634231504897', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:25:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288299850552733697', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:26:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288301264448417793', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:32:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288301413908246529', 1, '用户名: zyw,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:32:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288302943658995713', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:38:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288302975275659266', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:38:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288303481570095105', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:41:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288303570392870914', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 10:41:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288309231977656321', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 11:03:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288348398661046274', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 13:39:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288362061497274369', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 14:33:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288366301481439234', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-29 14:50:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1288387108156903425', 2, '部门权限表-分页列表查询', 1, 'chenye', '陈烨', '0:0:0:0:0:0:0:1', 'com.siti.system.controller.SysDepartPermissionController.queryPageList()', NULL, NULL, NULL, 13, NULL, '2020-07-29 16:13:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290143867125002242', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 12:34:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290145461354819586', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 12:40:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290162941179654146', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 13:49:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290162985039491073', 2, '部门权限表-分页列表查询', 1, 'chenye', '陈烨', '0:0:0:0:0:0:0:1', 'com.siti.system.controller.SysDepartPermissionController.queryPageList()', NULL, NULL, NULL, 28, NULL, '2020-08-03 13:50:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290185227580411905', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 15:18:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290186566146379778', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 15:23:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290189413273489410', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 15:35:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290189813066158081', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 15:36:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290490382244007938', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 11:30:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290493307045457921', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 11:42:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290520343877148674', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 13:30:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290521155684687874', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 13:33:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290521542550544386', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 13:34:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290525581602398209', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 13:50:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290526935125245954', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 13:56:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290546448726147074', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 15:13:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290546842358079490', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 15:15:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290577159986233346', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 17:15:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290577856102305794', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 17:18:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290579537821102082', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-04 17:25:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290916796680335361', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 15:45:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290916934295449602', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 15:45:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290918460648812546', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 15:52:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1290922199405232129', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 16:06:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291192031374376961', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 09:59:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291201783370342402', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 10:37:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291203998742994945', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 10:46:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291207970098663425', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 11:02:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291208735194238977', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 11:05:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291208777040809986', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 11:05:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291259088895881217', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:25:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291259194491678721', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:25:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291260061894717441', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:29:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291264031451160578', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:45:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291267172594786306', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:57:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291268706078490625', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:03:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291268781051674625', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:04:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291270589958488066', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:11:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291283177706512386', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 16:01:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291555714348756994', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 10:04:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291556042846646273', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 10:05:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291567147656572930', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 10:49:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291568575993249793', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 10:55:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291569225057615873', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 10:57:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291569928874409985', 2, '添加项目信息', 2, 'test', '系统管理员', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"constructionCode\":\"TEST111111\",\"constructionInvest\":0.0,\"constructionName\":\"智慧交投\",\"status\":0,\"type\":0}]', NULL, 115, NULL, '2020-08-07 11:00:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291571093569720322', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:05:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291571982955077633', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:08:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291573344837271554', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:14:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291576271941312514', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:25:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291576592147021825', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:27:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291576895802081281', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:28:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291577301164797954', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:29:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291632562957107202', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 15:09:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291639765097160705', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 15:38:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1291647473741377537', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 16:08:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292658182541516802', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 11:05:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292669322336116737', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 11:49:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292701366483132418', 1, '用户名: chenye,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 13:56:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292702082278858754', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 13:59:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292736358047158274', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:15:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292736708267368449', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:17:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292738494160089089', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:24:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292739197121232897', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:26:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292740612774301698', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:32:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292747450609745922', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 16:59:45', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1292748203374129153', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 17:02:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293003367687311361', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 09:56:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293005523941261314', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 10:05:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293009846788063233', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 10:22:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293016350345834498', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 10:48:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293073578658557954', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:35:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293074801302392833', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:40:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293075680629858306', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:44:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293078185514270721', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:53:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293078652805894145', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:55:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293441303805423618', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 14:56:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293442392168591362', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 15:01:12', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293810610712256514', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:24:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293810701527326721', 2, '生成某个项目的年度计划', 1, 'zhuzhengjun', '诸正君', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"12313993431ZHJT-123842\"]', NULL, 19, NULL, '2020-08-13 15:24:44', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293811249915797506', 2, '生成某个项目的年度计划', 1, 'zhuzhengjun', '诸正君', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"12313993431ZHJT-123842\"]', NULL, 99384, NULL, '2020-08-13 15:26:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293812408764325889', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:31:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293812450963218433', 2, '生成某个项目的年度计划', 1, 'zhuzhengjun', '诸正君', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"12313993431ZHJT-123842\"]', NULL, 751, NULL, '2020-08-13 15:31:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293812784271896578', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:33:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293812852492251137', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:33:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293812900198264834', 2, '生成某个项目的年度计划', 1, 'zhuzhengjun', '诸正君', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"12313993431ZHJT-123842\"]', NULL, 1253, NULL, '2020-08-13 15:33:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293815449160663042', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:43:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1293815962367295490', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 15:45:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294153267268739074', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:05:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294153366908624897', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:06:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294153507291979778', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:06:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294153515579924481', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:06:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294154237415448578', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:09:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1294154326527631361', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 14:10:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295265780486852609', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:46:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295266955290431489', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:51:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295267256240132098', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:52:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295267565934956545', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:53:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295267596683399170', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:53:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295268893868326913', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:59:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295269305195343874', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:00:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295270303422926849', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:04:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295271000105234434', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:07:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295271859090255874', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:10:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295272126468743170', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:11:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295273896674729985', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:18:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295280084623777794', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:43:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295280802826973185', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 16:46:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295609945519190018', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 14:34:17', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295619230328360961', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 15:11:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1295911420476702722', 1, '用户名: zhuzhengjun,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-19 10:32:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296259970068070402', 1, '用户登录失败，用户不存在！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:37:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296260578242150401', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:39:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296260688866918402', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:40:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296261155407740929', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:41:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296261204242022402', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:42:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296263957370585090', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:53:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296264109548322818', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:53:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296264789155594242', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:56:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296264797187686401', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:56:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296264816254992386', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:56:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296264954432143362', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:57:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296265041187127297', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:57:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296265210058194945', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:58:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296265455647277058', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 09:59:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296265978941227010', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:01:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296266623123406849', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:03:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296266777964527618', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:04:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296266787854696450', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:04:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296266898865340418', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:04:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296266941655629825', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:04:57', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296267056898326530', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:05:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296267489842774018', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:07:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296267500399837185', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:07:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296267566955053057', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:07:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296267880940650498', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:08:41', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296268688532914177', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:11:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296268923699150850', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:12:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296269110437953538', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:13:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296269195519410178', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:13:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296269359713828866', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:14:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296269449841033218', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:14:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296269746902614017', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:16:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296270588770729985', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:19:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296272253074751489', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:26:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296272947055902722', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:28:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296273058779578370', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:29:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296273975646044161', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:32:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296274755706896386', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:36:00', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296274923751686146', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:36:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296276149268594689', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:41:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296278905886818306', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:52:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296279460159897601', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:54:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296279681480736769', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:55:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296280200609742849', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:57:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296280429400637441', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 10:58:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296280818602688513', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:00:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296280926245306369', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:00:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296283645710385154', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:11:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296284694038921217', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:15:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296285206897442817', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:17:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296285370022313985', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:18:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296286276159750146', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:21:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296286728720957441', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:23:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296286877102850049', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:24:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296287163276017666', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:25:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296287303776813058', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:25:52', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296287455891636226', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:26:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296287648217251842', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:27:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296288224619479042', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:29:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296288993213104129', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:32:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296289074117033986', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:32:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296289392951246850', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:34:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296289514216964097', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:34:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296290082851340290', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:36:54', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296290354344443906', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:37:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296290457058754561', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 11:38:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296299702915383297', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:15:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296300156718104578', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:16:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296300920836407297', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:19:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296301039736537089', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:20:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296301639790444546', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:22:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296302568317075458', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:26:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296302696465645569', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 12:27:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296314283834425346', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:13:04', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296314979984031745', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:15:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296315891246907393', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:19:28', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296316541334667266', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:22:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296317341800808450', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:25:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296318273645133826', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:28:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296318321170792450', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:29:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296318898026004481', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:31:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296318934738747394', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:31:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296318970230947842', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:31:42', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296320585348366338', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 13:38:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296326929382891521', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 14:03:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296326964141088769', 2, '添加项目信息', 2, 'admin', '系统', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"constructionCode\":\"1597903407PDJT-539042\",\"constructionInvest\":0.0,\"constructionName\":\"智慧交投2\",\"finalTime\":1623569046000,\"initialTime\":1577863438000,\"status\":0,\"type\":\"0\"}]', NULL, 146, NULL, '2020-08-20 14:03:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296342581859733505', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 15:05:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296361538033475586', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"维权群\",\"buildUnit\":\"问非人防\",\"constructionCode\":\"1597911650PDJT-305547\",\"constructionInvest\":12121.0,\"constructionName\":\"的大多数多所\",\"constructionScale\":\"二维\",\"constructionUnit\":\"吃饭\",\"enginPm\":\"二维\",\"finalTime\":\"2020-08-14 12-00-00\",\"financeUnit\":\"2deed\",\"fourRange\":\"却热\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"2的人\",\"status\":0,\"superviseUnit\":\"非日4人\",\"type\":\"时代大厦\"}]', NULL, 43, NULL, '2020-08-20 16:20:50', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296365681821278210', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"323\",\"buildUnit\":\"2323\",\"constructionCode\":\"1597912638PDJT-608547\",\"constructionInvest\":2323.0,\"constructionName\":\"2323\",\"constructionScale\":\"2323\",\"constructionUnit\":\"2323\",\"enginPm\":\"2332\",\"finalTime\":\"2020-08-14 12-00-00\",\"financeUnit\":\"2323\",\"fourRange\":\"23233\",\"initialTime\":\"2020-08-04 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"2323\",\"status\":0,\"superviseUnit\":\"2323\",\"type\":\"555\"}]', NULL, 130, NULL, '2020-08-20 16:37:19', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296369359126978562', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"1212122\",\"buildUnit\":\"1212\",\"constructionCode\":\"1597913515PDJT-252338\",\"constructionInvest\":12112.0,\"constructionName\":\"热热\",\"constructionScale\":\"方法\",\"constructionUnit\":\"121212\",\"enginPm\":\"热热\",\"finalTime\":\"2020-08-15 12-00-00\",\"financeUnit\":\"1212\",\"fourRange\":\"1212\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"热热热\",\"status\":0,\"superviseUnit\":\"122\",\"type\":\"热热\"}]', NULL, 115, NULL, '2020-08-20 16:51:55', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296370460970639361', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"额\",\"buildUnit\":\"让人\",\"constructionCode\":\"1597913777PDJT-254479\",\"constructionInvest\":21212.0,\"constructionName\":\"测试\",\"constructionScale\":\"让人\",\"constructionUnit\":\"吧吃饭\",\"enginPm\":\"让人\",\"finalTime\":\"2020-09-22 12-00-00\",\"financeUnit\":\"热热热\",\"fourRange\":\"3氛围\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"让人\",\"status\":0,\"superviseUnit\":\"让人\",\"type\":\"33\"}]', NULL, 127, NULL, '2020-08-20 16:56:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296370474237222914', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"额\",\"buildUnit\":\"让人\",\"constructionCode\":\"1597913780PDJT-755311\",\"constructionInvest\":21212.0,\"constructionName\":\"测试\",\"constructionScale\":\"让人\",\"constructionUnit\":\"吧吃饭\",\"enginPm\":\"让人\",\"finalTime\":\"2020-09-22 12-00-00\",\"financeUnit\":\"热热热\",\"fourRange\":\"3氛围\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"让人\",\"status\":0,\"superviseUnit\":\"让人\",\"type\":\"33\"}]', NULL, 123, NULL, '2020-08-20 16:56:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296370477622026241', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"额\",\"buildUnit\":\"让人\",\"constructionCode\":\"1597913781PDJT-969666\",\"constructionInvest\":21212.0,\"constructionName\":\"测试\",\"constructionScale\":\"让人\",\"constructionUnit\":\"吧吃饭\",\"enginPm\":\"让人\",\"finalTime\":\"2020-09-22 12-00-00\",\"financeUnit\":\"热热热\",\"fourRange\":\"3氛围\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"让人\",\"status\":0,\"superviseUnit\":\"让人\",\"type\":\"33\"}]', NULL, 118, NULL, '2020-08-20 16:56:22', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296370482495807490', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"额\",\"buildUnit\":\"让人\",\"constructionCode\":\"1597913782PDJT-661478\",\"constructionInvest\":21212.0,\"constructionName\":\"测试\",\"constructionScale\":\"让人\",\"constructionUnit\":\"吧吃饭\",\"enginPm\":\"让人\",\"finalTime\":\"2020-09-22 12-00-00\",\"financeUnit\":\"热热热\",\"fourRange\":\"3氛围\",\"initialTime\":\"2020-08-11 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"让人\",\"status\":0,\"superviseUnit\":\"让人\",\"type\":\"33\"}]', NULL, 122, NULL, '2020-08-20 16:56:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296373767457923073', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 17:09:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296373921791533058', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 17:10:03', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296383082935803906', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 17:46:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296386222678532098', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 17:58:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296386987480510465', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 18:01:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296387021215297538', 2, '编辑项目信息', 3, 'admin', '系统', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.ConstructionController.edit()', NULL, '[{\"constructionInvest\":0.0,\"constructionName\":\"智慧交投2\",\"finalTime\":\"2021-06-13 15:24:06\",\"initialTime\":\"2020-01-01 15:23:58\",\"status\":0,\"type\":\"0\"}]', NULL, 56, NULL, '2020-08-20 18:02:06', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296387139427561473', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-20 18:02:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296388913760759809', 2, '编辑项目信息', 3, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.edit()', NULL, '[{\"buildContent\":\"额\",\"buildUnit\":\"让人\",\"constructionCode\":\"1597913780PDJT-755311\",\"constructionInvest\":21212.0,\"constructionName\":\"测试\",\"constructionScale\":\"让人\",\"constructionUnit\":\"吧吃饭\",\"createTime\":1597913862000,\"enginPm\":\"让人\",\"finalTime\":\"2020-09-22 12:00:00\",\"financeUnit\":\"热热热\",\"fourRange\":\"3氛围\",\"initialTime\":\"2020-08-11 12:00:00\",\"manageDepart\":\"shanghai\",\"pm\":\"让人\",\"status\":0,\"superviseUnit\":\"让人\",\"type\":\"33\",\"updateTime\":1597913885000}]', NULL, 116, NULL, '2020-08-20 18:09:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296617115015901185', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-21 09:16:25', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296618629616824321', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-21 09:22:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296702521464053761', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-21 14:55:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296702728608145409', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-21 14:56:37', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1296702809809870850', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-21 14:56:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297785125994946562', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 14:37:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297796621902692354', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 15:23:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297800434176995330', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 15:38:30', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297804126284394497', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"问问\",\"buildUnit\":\"的风范\",\"constructionCode\":\"1598255589PDJT-141546\",\"constructionInvest\":1212.0,\"constructionName\":\"测试项目进度的仙姑\",\"constructionScale\":\"鹅鹅鹅\",\"constructionUnit\":\"1212\",\"enginPm\":\"测试\",\"finalTime\":\"2020-09-30 12-00-00\",\"financeUnit\":\"鹅鹅鹅我\",\"fourRange\":\"嗯嗯\",\"initialTime\":\"2020-08-17 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"鹅鹅鹅\",\"status\":0,\"superviseUnit\":\"饿的\",\"type\":\"20200728GCHT0001\"}]', NULL, 312, NULL, '2020-08-24 15:53:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297805974303051777', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 16:00:31', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297806238779084801', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 16:01:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297806630199922690', 2, '编辑项目信息', 3, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.edit()', NULL, '[{\"buildContent\":\"维权群\",\"buildUnit\":\"问非人防\",\"constructionCode\":\"1597911650PDJT-305547\",\"constructionInvest\":12121.0,\"constructionName\":\"的大多数多所\",\"constructionScale\":\"二维\",\"constructionUnit\":\"吃饭\",\"createTime\":1597913862000,\"enginPm\":\"二维\",\"finalTime\":\"2020-08-14 12:00:00\",\"financeUnit\":\"2deed\",\"fourRange\":\"却热\",\"initialTime\":\"2020-08-11 12:00:00\",\"manageDepart\":\"shanghai\",\"pm\":\"2的人\",\"status\":0,\"superviseUnit\":\"非日4人\",\"type\":\"20200728GCHT0001\",\"updateTime\":1597913885000}]', NULL, 148, NULL, '2020-08-24 16:03:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297807056659976193', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.57', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"3333333\",\"buildUnit\":\"3333\",\"constructionCode\":\"1598256288PDJT-874194\",\"constructionInvest\":22323.0,\"constructionName\":\"测试的仙姑\",\"constructionScale\":\"22\",\"constructionUnit\":\"3333\",\"enginPm\":\"222\",\"finalTime\":\"2020-09-23 12-00-00\",\"financeUnit\":\"3333333\",\"fourRange\":\"3333\",\"initialTime\":\"2020-08-10 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"22\",\"status\":0,\"superviseUnit\":\"33333\",\"type\":\"20200728GCHT0001\"}]', NULL, 344, NULL, '2020-08-24 16:04:49', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297807717048946690', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 16:07:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297808467992940546', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 16:10:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297808496929443842', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 16:10:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297810142916939777', 2, '添加项目信息', 2, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"问问\",\"buildUnit\":\"的风范\",\"constructionCode\":\"1598257024PDJT-806652\",\"constructionInvest\":1212.0,\"constructionName\":\"测试项目进度的仙姑\",\"constructionScale\":\"鹅鹅鹅\",\"constructionUnit\":\"1212\",\"createTime\":1598255590000,\"enginPm\":\"测试\",\"finalTime\":\"2020-09-30 12:00:00\",\"financeUnit\":\"鹅鹅鹅我\",\"fourRange\":\"嗯嗯\",\"initialTime\":\"2020-08-17 12:00:00\",\"manageDepart\":\"shanghai\",\"pm\":\"鹅鹅鹅\",\"status\":0,\"superviseUnit\":\"饿的\",\"type\":\"20200728GCHT0001\",\"updateTime\":1598255590000}]', NULL, 276, NULL, '2020-08-24 16:17:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297811426545913858', 2, '添加项目信息', 2, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"问问\",\"buildUnit\":\"的风范\",\"constructionCode\":\"1598257330PDJT-428175\",\"constructionInvest\":1212.0,\"constructionName\":\"测试项目进度的仙姑\",\"constructionScale\":\"鹅鹅鹅\",\"constructionUnit\":\"1212\",\"createTime\":1598255590000,\"enginPm\":\"测试\",\"finalTime\":\"2020-09-30 12:00:00\",\"financeUnit\":\"鹅鹅鹅我\",\"fourRange\":\"嗯嗯\",\"initialTime\":\"2020-08-17 12:00:00\",\"manageDepart\":\"shanghai\",\"pm\":\"鹅鹅鹅\",\"status\":0,\"superviseUnit\":\"饿的\",\"type\":\"20200728GCHT0001\",\"updateTime\":1598255590000}]', NULL, 353, NULL, '2020-08-24 16:22:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297821237568311297', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.138', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 17:01:10', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297821502006595585', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"312312312\",\"buildUnit\":\"小弟弟\",\"constructionCode\":\"1598259732PDJT-920453\",\"constructionInvest\":1234.0,\"constructionName\":\"zhuyiwen\",\"constructionScale\":\"zhugge\",\"constructionUnit\":\"小老弟\",\"enginPm\":\"xiaogg\",\"finalTime\":\"2020-09-21 12-00-00\",\"financeUnit\":\"789\",\"fourRange\":\"123122131312312\",\"initialTime\":\"2020-08-14 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"123\",\"status\":0,\"superviseUnit\":\"123\",\"type\":\"20200728GCHT0001\"}]', NULL, 555, NULL, '2020-08-24 17:02:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297822303156408321', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"1232131\",\"buildUnit\":\"1231\",\"constructionCode\":\"1598259913PDJT-120389\",\"constructionInvest\":123123.0,\"constructionName\":\"zyw1\",\"constructionScale\":\"4\",\"constructionUnit\":\"123132\",\"enginPm\":\"123\",\"finalTime\":\"2020-09-28 12-00-00\",\"financeUnit\":\"123123\",\"fourRange\":\"123123\",\"initialTime\":\"2020-09-13 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"123\",\"status\":0,\"superviseUnit\":\"213213\",\"type\":\"20200728GCHT0001\"}]', NULL, 10692, NULL, '2020-08-24 17:05:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297828138137915394', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"231231\",\"buildUnit\":\"123213\",\"constructionCode\":\"1598261307PDJT-327881\",\"constructionInvest\":23121.0,\"constructionName\":\"112\",\"constructionScale\":\"1231231\",\"constructionUnit\":\"123123\",\"enginPm\":\"123123\",\"finalTime\":\"2020-09-30 12-00-00\",\"financeUnit\":\"1231231\",\"fourRange\":\"1232131\",\"initialTime\":\"2020-09-23 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"123123\",\"status\":0,\"superviseUnit\":\"123123\",\"type\":\"20200728GCHT0001\"}]', NULL, 7720, NULL, '2020-08-24 17:28:35', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297828277267173377', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"231231\",\"buildUnit\":\"123213\",\"constructionCode\":\"1598261342PDJT-762265\",\"constructionInvest\":23121.0,\"constructionName\":\"112\",\"constructionScale\":\"1231231\",\"constructionUnit\":\"123123\",\"enginPm\":\"123123\",\"finalTime\":\"2020-09-30 12-00-00\",\"financeUnit\":\"1231231\",\"fourRange\":\"1232131\",\"initialTime\":\"2020-09-23 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"123123\",\"status\":0,\"superviseUnit\":\"123123\",\"type\":\"20200728GCHT0001\"}]', NULL, 5795, NULL, '2020-08-24 17:29:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297828857633017858', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-24 17:31:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297828857876287489', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"231231\",\"buildUnit\":\"123213\",\"constructionCode\":\"1598261383PDJT-240050\",\"constructionInvest\":23121.0,\"constructionName\":\"112\",\"constructionScale\":\"1231231\",\"constructionUnit\":\"123123\",\"enginPm\":\"123123\",\"finalTime\":\"2020-09-30 12-00-00\",\"financeUnit\":\"1231231\",\"fourRange\":\"1232131\",\"initialTime\":\"2020-09-23 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"123123\",\"status\":0,\"superviseUnit\":\"123123\",\"type\":\"20200728GCHT0001\"}]', NULL, 102929, NULL, '2020-08-24 17:31:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297829613253660674', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"12321321\",\"buildUnit\":\"1231231\",\"constructionCode\":\"1598261651PDJT-813307\",\"constructionInvest\":1231.0,\"constructionName\":\"11\",\"constructionScale\":\"231231\",\"constructionUnit\":\"123213\",\"enginPm\":\"111\",\"finalTime\":\"2020-09-22 12-00-00\",\"financeUnit\":\"23123123\",\"fourRange\":\"123213\",\"initialTime\":\"2020-08-15 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"31231\",\"status\":0,\"superviseUnit\":\"231231\",\"type\":\"20200728GCHT0001\"}]', NULL, 15664, NULL, '2020-08-24 17:34:27', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1297831264546910209', 2, '添加项目信息', 2, 'test', 'test', '10.1.4.138', 'com.siti.construction.controller.ConstructionController.add()', NULL, '[{\"buildContent\":\"1231\",\"buildUnit\":\"1231\",\"constructionCode\":\"1598262052PDJT-915958\",\"constructionInvest\":-3126.0,\"constructionName\":\"123123123\",\"constructionScale\":\"31231\",\"constructionUnit\":\"1231232\",\"enginPm\":\"123123\",\"finalTime\":\"2020-08-15 12-00-00\",\"financeUnit\":\"2312\",\"fourRange\":\"123123\",\"initialTime\":\"2020-08-08 12-00-00\",\"manageDepart\":\"shanghai\",\"pm\":\"12312\",\"status\":0,\"superviseUnit\":\"231231\",\"type\":\"20200728GCHT0001\"}]', NULL, 8106, NULL, '2020-08-24 17:41:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298074934393950209', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 09:49:16', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298083889388179457', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 10:24:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298088900033761281', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.104', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 10:44:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298091505988390913', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 10:55:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298091505996779522', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 10:55:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298091506009362434', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 10:55:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298092371348803586', 2, '编辑项目信息', 3, 'test', 'test', '172.16.0.104', 'com.siti.construction.controller.ConstructionController.edit()', NULL, '[{\"buildContent\":\"1231\",\"buildUnit\":\"朱逸文\",\"constructionCode\":\"1598262052PDJT-915958\",\"constructionInvest\":-3126.0,\"constructionName\":\"123123123\",\"constructionScale\":\"31231\",\"constructionUnit\":\"1231232\",\"createTime\":1598262060000,\"enginPm\":\"123123\",\"finalTime\":\"2020-08-15 12:00:00\",\"financeUnit\":\"2312\",\"fourRange\":\"123123\",\"initialTime\":\"2020-08-08 12:00:00\",\"manageDepart\":\"shanghai\",\"pm\":\"12312\",\"status\":0,\"superviseUnit\":\"231231\",\"type\":\"20200728GCHT0001\",\"updateTime\":1598262060000}]', NULL, 283, NULL, '2020-08-25 10:58:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298128223445626881', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 13:21:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298130935000223745', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 527, NULL, '2020-08-25 13:31:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298131360583667713', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 1017, NULL, '2020-08-25 13:33:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298138422147436545', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 46457, NULL, '2020-08-25 14:01:32', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298139379958697985', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 38351, NULL, '2020-08-25 14:05:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298140911324254210', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 14:11:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298140911466860546', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 14:11:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298140911647215618', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 351693, NULL, '2020-08-25 14:11:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298141003284369409', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-25 14:11:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298142925424840706', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 4926, NULL, '2020-08-25 14:19:26', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298143992011210753', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 949, NULL, '2020-08-25 14:23:40', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298144125880811522', 2, '生成某个项目的年度计划', 1, 'test', 'test', '0:0:0:0:0:0:0:1', 'com.siti.construction.controller.InvestPlanController.createInvestPlan()', NULL, '[\"1598262052PDJT-915958\"]', NULL, 2100, NULL, '2020-08-25 14:24:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298436552814403586', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 09:46:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298436837213380609', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.104', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 09:47:20', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298460099783860226', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 11:19:47', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298483565677408258', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 12:53:01', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298507272324026370', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 14:27:13', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298508928474329089', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '172.16.0.148', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-26 14:33:48', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298803095839899649', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 10:02:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298803538468995074', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 10:04:29', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298805567996231682', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 10:12:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298809366366318593', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 10:27:38', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298812253507100674', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.172', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 10:39:07', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298820180225728514', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 11:10:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298820524741664769', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 11:11:59', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298822078236368898', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 11:18:09', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298823108525203458', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.139', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 11:22:15', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1298850627865452546', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '10.1.4.172', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-27 13:11:36', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1299186369242259457', 1, '用户名: test,登录成功！', NULL, NULL, NULL, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-28 11:25:43', NULL, NULL);

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '组织名称',
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pid` int(11) DEFAULT NULL COMMENT '父组织ID',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '节点路径',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `type_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (10, '浦东投资发展有限公司', NULL, NULL, NULL, NULL, '2020-08-06 11:05:52', NULL);
INSERT INTO `sys_org` VALUES (37, '综合办', NULL, 10, NULL, NULL, '2020-08-06 11:06:09', NULL);
INSERT INTO `sys_org` VALUES (38, '财管部', NULL, 10, NULL, NULL, '2020-08-06 11:06:09', NULL);
INSERT INTO `sys_org` VALUES (39, '计合部', NULL, 10, NULL, NULL, '2020-08-06 11:06:09', NULL);
INSERT INTO `sys_org` VALUES (42, '规发部', NULL, 10, NULL, NULL, '2020-08-06 11:06:09', NULL);
INSERT INTO `sys_org` VALUES (43, '交工部', NULL, 10, NULL, NULL, '2020-08-06 11:06:09', NULL);
INSERT INTO `sys_org` VALUES (44, '社工部', NULL, 10, NULL, NULL, '2020-08-06 11:05:11', NULL);
INSERT INTO `sys_org` VALUES (45, '开运部', NULL, 10, NULL, NULL, '2020-08-06 11:05:11', NULL);
INSERT INTO `sys_org` VALUES (46, '公交部', NULL, 10, NULL, NULL, '2020-08-06 11:05:11', NULL);

-- ----------------------------
-- Table structure for sys_rlat_role_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_rlat_role_auth`;
CREATE TABLE `sys_rlat_role_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色主键',
  `auth_id` int(11) NOT NULL COMMENT '权限主键',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 354 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_rlat_role_auth
-- ----------------------------
INSERT INTO `sys_rlat_role_auth` VALUES (1, 40, 6, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (2, 40, 7, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (3, 40, 8, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (4, 40, 9, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (5, 40, 10, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (6, 40, 13, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (7, 40, 29, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (8, 40, 30, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (9, 40, 33, NULL, '2020-08-20 09:55:22');
INSERT INTO `sys_rlat_role_auth` VALUES (10, 40, 34, NULL, '2020-08-20 09:55:23');
INSERT INTO `sys_rlat_role_auth` VALUES (13, 40, 35, NULL, '2020-08-20 09:55:23');
INSERT INTO `sys_rlat_role_auth` VALUES (15, 40, 36, NULL, '2020-08-20 09:55:28');
INSERT INTO `sys_rlat_role_auth` VALUES (16, 40, 87, NULL, '2020-08-20 09:55:28');
INSERT INTO `sys_rlat_role_auth` VALUES (17, 20, 6, NULL, '2020-08-20 09:56:02');
INSERT INTO `sys_rlat_role_auth` VALUES (18, 20, 7, NULL, '2020-08-20 09:56:02');
INSERT INTO `sys_rlat_role_auth` VALUES (21, 1, 6, NULL, '2020-01-08 16:52:44');
INSERT INTO `sys_rlat_role_auth` VALUES (22, 1, 7, NULL, '2020-01-08 16:52:44');
INSERT INTO `sys_rlat_role_auth` VALUES (23, 1, 8, NULL, '2020-01-08 16:52:44');
INSERT INTO `sys_rlat_role_auth` VALUES (24, 1, 9, NULL, '2020-01-08 16:52:44');
INSERT INTO `sys_rlat_role_auth` VALUES (25, 1, 10, NULL, '2020-01-08 16:52:44');
INSERT INTO `sys_rlat_role_auth` VALUES (28, 1, 6, NULL, '2020-08-20 09:55:38');
INSERT INTO `sys_rlat_role_auth` VALUES (30, 1, 7, NULL, '2020-08-20 09:55:38');
INSERT INTO `sys_rlat_role_auth` VALUES (31, 1, 8, NULL, '2020-08-20 09:55:38');
INSERT INTO `sys_rlat_role_auth` VALUES (32, 1, 9, NULL, '2020-08-20 09:55:38');
INSERT INTO `sys_rlat_role_auth` VALUES (33, 16, 10, NULL, '2020-01-08 16:53:08');
INSERT INTO `sys_rlat_role_auth` VALUES (36, 13, 6, NULL, '2020-01-08 16:53:28');
INSERT INTO `sys_rlat_role_auth` VALUES (37, 13, 7, NULL, '2020-01-08 16:53:28');
INSERT INTO `sys_rlat_role_auth` VALUES (38, 13, 8, NULL, '2020-01-08 16:53:28');
INSERT INTO `sys_rlat_role_auth` VALUES (39, 13, 9, NULL, '2020-01-08 16:53:28');
INSERT INTO `sys_rlat_role_auth` VALUES (40, 13, 10, NULL, '2020-01-08 16:53:28');
INSERT INTO `sys_rlat_role_auth` VALUES (43, 15, 6, NULL, '2020-01-08 16:53:42');
INSERT INTO `sys_rlat_role_auth` VALUES (44, 15, 7, NULL, '2020-01-08 16:53:42');
INSERT INTO `sys_rlat_role_auth` VALUES (45, 15, 8, NULL, '2020-01-08 16:53:42');
INSERT INTO `sys_rlat_role_auth` VALUES (46, 15, 9, NULL, '2020-01-08 16:53:42');
INSERT INTO `sys_rlat_role_auth` VALUES (47, 15, 10, NULL, '2020-01-08 16:53:42');
INSERT INTO `sys_rlat_role_auth` VALUES (50, 1, 6, NULL, '2020-01-08 16:53:57');
INSERT INTO `sys_rlat_role_auth` VALUES (52, 1, 7, NULL, '2020-01-08 16:53:57');
INSERT INTO `sys_rlat_role_auth` VALUES (53, 1, 8, NULL, '2020-01-08 16:53:57');
INSERT INTO `sys_rlat_role_auth` VALUES (54, 1, 9, NULL, '2020-01-08 16:53:57');
INSERT INTO `sys_rlat_role_auth` VALUES (55, 1, 10, NULL, '2020-01-08 16:53:57');
INSERT INTO `sys_rlat_role_auth` VALUES (58, 17, 6, NULL, '2020-01-08 16:54:10');
INSERT INTO `sys_rlat_role_auth` VALUES (60, 17, 7, NULL, '2020-01-08 16:54:10');
INSERT INTO `sys_rlat_role_auth` VALUES (61, 17, 8, NULL, '2020-01-08 16:54:10');
INSERT INTO `sys_rlat_role_auth` VALUES (62, 17, 9, NULL, '2020-01-08 16:54:10');
INSERT INTO `sys_rlat_role_auth` VALUES (63, 17, 10, NULL, '2020-01-08 16:54:10');
INSERT INTO `sys_rlat_role_auth` VALUES (65, 13, 29, NULL, '2020-01-14 16:57:22');
INSERT INTO `sys_rlat_role_auth` VALUES (66, 13, 30, NULL, '2020-01-14 16:57:22');
INSERT INTO `sys_rlat_role_auth` VALUES (70, 1, 29, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (71, 1, 30, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (74, 1, 6, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (75, 1, 7, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (76, 1, 8, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (77, 1, 9, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (78, 1, 10, NULL, '2020-01-15 09:37:37');
INSERT INTO `sys_rlat_role_auth` VALUES (88, 18, 29, NULL, '2020-01-15 09:44:33');
INSERT INTO `sys_rlat_role_auth` VALUES (89, 18, 30, NULL, '2020-01-15 09:44:37');
INSERT INTO `sys_rlat_role_auth` VALUES (93, 18, 34, NULL, '2020-01-16 19:14:10');
INSERT INTO `sys_rlat_role_auth` VALUES (94, 18, 35, NULL, '2020-01-16 19:14:17');
INSERT INTO `sys_rlat_role_auth` VALUES (95, 18, 36, NULL, '2020-01-16 19:14:23');
INSERT INTO `sys_rlat_role_auth` VALUES (96, 18, 37, NULL, '2020-01-16 19:14:28');
INSERT INTO `sys_rlat_role_auth` VALUES (97, 18, 38, NULL, '2020-01-16 19:14:35');
INSERT INTO `sys_rlat_role_auth` VALUES (98, 18, 39, NULL, '2020-01-16 19:37:05');
INSERT INTO `sys_rlat_role_auth` VALUES (110, 18, 53, NULL, '2020-03-31 14:40:06');
INSERT INTO `sys_rlat_role_auth` VALUES (111, 18, 55, NULL, '2020-04-15 14:06:40');
INSERT INTO `sys_rlat_role_auth` VALUES (115, 18, 59, NULL, '2020-04-28 15:07:11');
INSERT INTO `sys_rlat_role_auth` VALUES (116, 18, 60, NULL, '2020-04-28 15:08:04');
INSERT INTO `sys_rlat_role_auth` VALUES (117, 18, 61, NULL, '2020-04-29 14:00:33');
INSERT INTO `sys_rlat_role_auth` VALUES (118, 18, 62, NULL, '2020-05-15 15:22:50');
INSERT INTO `sys_rlat_role_auth` VALUES (119, 18, 63, NULL, '2020-05-18 16:51:12');
INSERT INTO `sys_rlat_role_auth` VALUES (121, 20, 34, NULL, '2020-05-21 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (122, 20, 35, NULL, '2020-05-21 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (123, 20, 39, NULL, '2020-05-21 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (126, 20, 36, NULL, '2020-05-21 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (127, 20, 62, NULL, '2020-05-21 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (131, 20, 37, NULL, '2020-05-21 14:40:36');
INSERT INTO `sys_rlat_role_auth` VALUES (132, 20, 63, NULL, '2020-05-21 14:40:36');
INSERT INTO `sys_rlat_role_auth` VALUES (133, 21, 33, NULL, '2020-05-21 14:48:29');
INSERT INTO `sys_rlat_role_auth` VALUES (135, 21, 34, NULL, '2020-05-21 14:48:29');
INSERT INTO `sys_rlat_role_auth` VALUES (136, 21, 35, NULL, '2020-05-21 14:48:29');
INSERT INTO `sys_rlat_role_auth` VALUES (137, 21, 39, NULL, '2020-05-21 14:48:29');
INSERT INTO `sys_rlat_role_auth` VALUES (146, 20, 34, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (149, 20, 35, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (150, 20, 39, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (153, 20, 36, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (154, 20, 62, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (158, 20, 37, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (159, 20, 63, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (160, 20, 29, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (161, 20, 30, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (162, 20, 53, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (163, 20, 55, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (164, 20, 61, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (167, 20, 59, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (168, 20, 60, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (169, 20, 38, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (171, 20, 6, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (172, 20, 7, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (173, 20, 8, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (174, 20, 9, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (175, 20, 10, NULL, '2020-05-28 13:27:40');
INSERT INTO `sys_rlat_role_auth` VALUES (178, 21, 33, NULL, '2020-05-28 14:47:17');
INSERT INTO `sys_rlat_role_auth` VALUES (179, 18, 74, NULL, '2020-05-28 16:00:13');
INSERT INTO `sys_rlat_role_auth` VALUES (180, 18, 75, NULL, '2020-05-28 16:00:13');
INSERT INTO `sys_rlat_role_auth` VALUES (181, 18, 77, NULL, '2020-05-28 16:00:13');
INSERT INTO `sys_rlat_role_auth` VALUES (183, 18, 78, NULL, '2020-05-28 16:02:31');
INSERT INTO `sys_rlat_role_auth` VALUES (184, 18, 79, NULL, '2020-06-03 14:40:24');
INSERT INTO `sys_rlat_role_auth` VALUES (185, 21, 70, NULL, '2020-06-05 15:21:28');
INSERT INTO `sys_rlat_role_auth` VALUES (186, 21, 72, NULL, '2020-06-05 15:21:28');
INSERT INTO `sys_rlat_role_auth` VALUES (187, 22, 33, NULL, '2020-06-05 16:03:13');
INSERT INTO `sys_rlat_role_auth` VALUES (188, 23, 33, NULL, '2020-06-05 16:06:31');
INSERT INTO `sys_rlat_role_auth` VALUES (189, 24, 33, NULL, '2020-06-05 16:10:30');
INSERT INTO `sys_rlat_role_auth` VALUES (190, 24, 34, NULL, '2020-06-05 16:10:30');
INSERT INTO `sys_rlat_role_auth` VALUES (191, 25, 33, NULL, '2020-06-05 16:10:58');
INSERT INTO `sys_rlat_role_auth` VALUES (192, 25, 34, NULL, '2020-06-05 16:10:58');
INSERT INTO `sys_rlat_role_auth` VALUES (193, 25, 70, NULL, '2020-06-05 16:10:58');
INSERT INTO `sys_rlat_role_auth` VALUES (194, 25, 72, NULL, '2020-06-05 16:10:59');
INSERT INTO `sys_rlat_role_auth` VALUES (195, 18, 83, NULL, '2020-06-08 11:18:02');
INSERT INTO `sys_rlat_role_auth` VALUES (196, 21, 75, NULL, '2020-06-10 15:46:18');
INSERT INTO `sys_rlat_role_auth` VALUES (197, 18, 36, NULL, '2020-06-19 10:43:30');
INSERT INTO `sys_rlat_role_auth` VALUES (198, 21, 77, NULL, '2020-06-10 15:46:18');
INSERT INTO `sys_rlat_role_auth` VALUES (199, 18, 84, NULL, '2020-06-19 10:43:43');
INSERT INTO `sys_rlat_role_auth` VALUES (200, 19, 84, NULL, '2020-06-19 10:43:51');
INSERT INTO `sys_rlat_role_auth` VALUES (201, 20, 84, NULL, '2020-06-19 10:43:55');
INSERT INTO `sys_rlat_role_auth` VALUES (202, 26, 33, NULL, '2020-06-23 09:54:58');
INSERT INTO `sys_rlat_role_auth` VALUES (203, 26, 34, NULL, '2020-06-23 09:54:58');
INSERT INTO `sys_rlat_role_auth` VALUES (204, 27, 33, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (205, 27, 35, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (206, 27, 39, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (207, 27, 74, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (208, 27, 75, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (209, 27, 73, NULL, '2020-06-23 09:55:34');
INSERT INTO `sys_rlat_role_auth` VALUES (210, 27, 36, NULL, '2020-06-23 09:55:51');
INSERT INTO `sys_rlat_role_auth` VALUES (211, 27, 62, NULL, '2020-06-23 09:55:51');
INSERT INTO `sys_rlat_role_auth` VALUES (212, 27, 78, NULL, '2020-06-23 09:55:51');
INSERT INTO `sys_rlat_role_auth` VALUES (213, 27, 77, NULL, '2020-06-23 09:55:51');
INSERT INTO `sys_rlat_role_auth` VALUES (214, 28, 33, NULL, '2020-06-23 10:38:59');
INSERT INTO `sys_rlat_role_auth` VALUES (215, 28, 34, NULL, '2020-06-23 10:38:59');
INSERT INTO `sys_rlat_role_auth` VALUES (216, 28, 35, NULL, '2020-06-23 10:39:05');
INSERT INTO `sys_rlat_role_auth` VALUES (217, 28, 39, NULL, '2020-06-23 10:39:05');
INSERT INTO `sys_rlat_role_auth` VALUES (218, 28, 74, NULL, '2020-06-23 10:39:05');
INSERT INTO `sys_rlat_role_auth` VALUES (219, 28, 75, NULL, '2020-06-23 10:39:05');
INSERT INTO `sys_rlat_role_auth` VALUES (220, 28, 73, NULL, '2020-06-23 10:39:05');
INSERT INTO `sys_rlat_role_auth` VALUES (221, 29, 33, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (222, 29, 34, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (223, 29, 35, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (224, 29, 39, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (225, 29, 74, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (226, 29, 75, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (227, 29, 73, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (228, 29, 36, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (229, 29, 62, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (230, 29, 78, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (231, 29, 77, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (232, 29, 37, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (233, 29, 63, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (234, 29, 79, NULL, '2020-06-23 11:22:47');
INSERT INTO `sys_rlat_role_auth` VALUES (236, 30, 34, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (237, 30, 35, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (238, 30, 75, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (239, 30, 73, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (240, 30, 36, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (241, 30, 62, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (242, 30, 78, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (243, 30, 77, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (244, 30, 37, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (245, 30, 63, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (246, 30, 79, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (247, 30, 29, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (248, 30, 30, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (249, 30, 53, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (250, 30, 55, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (251, 30, 61, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (252, 30, 83, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (255, 30, 59, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (256, 30, 60, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (257, 30, 84, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (258, 30, 38, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (261, 30, 6, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (262, 30, 7, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (263, 30, 8, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (264, 30, 9, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (265, 30, 10, NULL, '2020-07-06 09:23:01');
INSERT INTO `sys_rlat_role_auth` VALUES (267, 31, 33, NULL, '2020-07-06 09:26:53');
INSERT INTO `sys_rlat_role_auth` VALUES (280, 19, 29, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (281, 19, 30, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (282, 19, 53, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (283, 19, 55, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (284, 19, 61, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (285, 19, 83, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (288, 19, 59, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (289, 19, 60, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (290, 19, 38, NULL, '2020-07-07 14:26:52');
INSERT INTO `sys_rlat_role_auth` VALUES (292, 20, 74, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (293, 20, 75, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (294, 20, 73, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (295, 20, 78, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (296, 20, 77, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (297, 20, 83, NULL, '2020-07-07 16:34:55');
INSERT INTO `sys_rlat_role_auth` VALUES (302, 18, 85, NULL, '2020-07-23 12:54:56');
INSERT INTO `sys_rlat_role_auth` VALUES (303, 19, 34, NULL, '2020-07-23 14:11:00');
INSERT INTO `sys_rlat_role_auth` VALUES (309, 32, 33, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (310, 32, 34, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (311, 32, 35, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (312, 32, 39, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (313, 32, 74, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (314, 32, 75, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (315, 32, 73, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (316, 32, 36, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (317, 32, 62, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (318, 32, 78, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (319, 32, 77, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (320, 32, 37, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (321, 32, 63, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (322, 32, 79, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (323, 32, 29, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (324, 32, 30, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (325, 32, 53, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (326, 32, 55, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (327, 32, 61, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (328, 32, 83, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (329, 32, 85, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (330, 32, 57, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (331, 32, 58, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (332, 32, 59, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (333, 32, 60, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (334, 32, 84, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (335, 32, 38, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (336, 32, 70, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (337, 32, 72, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (338, 32, 6, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (339, 32, 7, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (340, 32, 8, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (341, 32, 9, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (342, 32, 10, NULL, '2020-07-23 14:12:15');
INSERT INTO `sys_rlat_role_auth` VALUES (343, 30, 39, NULL, '2020-07-24 10:24:26');
INSERT INTO `sys_rlat_role_auth` VALUES (344, 30, 74, NULL, '2020-07-24 10:24:26');
INSERT INTO `sys_rlat_role_auth` VALUES (345, 20, 79, NULL, '2020-07-28 17:56:38');
INSERT INTO `sys_rlat_role_auth` VALUES (346, 18, 33, NULL, '2020-07-28 17:58:18');
INSERT INTO `sys_rlat_role_auth` VALUES (347, 19, 33, NULL, '2020-07-28 17:58:23');
INSERT INTO `sys_rlat_role_auth` VALUES (349, 30, 33, NULL, '2020-07-28 17:58:31');
INSERT INTO `sys_rlat_role_auth` VALUES (350, 33, 36, NULL, '2020-08-04 10:23:51');
INSERT INTO `sys_rlat_role_auth` VALUES (351, 33, 62, NULL, '2020-08-04 10:23:51');
INSERT INTO `sys_rlat_role_auth` VALUES (352, 33, 78, NULL, '2020-08-04 10:23:51');
INSERT INTO `sys_rlat_role_auth` VALUES (353, 33, 77, NULL, '2020-08-04 10:23:51');

-- ----------------------------
-- Table structure for sys_rlat_user_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_rlat_user_org`;
CREATE TABLE `sys_rlat_user_org`  (
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `org_id` int(11) NOT NULL DEFAULT 0 COMMENT '组织ID',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`user_id`, `org_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_rlat_user_org
-- ----------------------------
INSERT INTO `sys_rlat_user_org` VALUES (1, 10, 1, '2020-08-20 09:42:56');
INSERT INTO `sys_rlat_user_org` VALUES (2, 10, 1, '2020-08-20 09:43:06');
INSERT INTO `sys_rlat_user_org` VALUES (1000, 10, 1, '2020-08-20 09:43:01');
INSERT INTO `sys_rlat_user_org` VALUES (1014, 10, 1, '2020-08-20 09:43:02');

-- ----------------------------
-- Table structure for sys_rlat_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_rlat_user_role`;
CREATE TABLE `sys_rlat_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_rlat_user_role
-- ----------------------------
INSERT INTO `sys_rlat_user_role` VALUES (1, 1014, 20, 1000, '2020-08-06 11:06:31');
INSERT INTO `sys_rlat_user_role` VALUES (2, 1000, 40, 1, '2020-08-18 15:11:05');
INSERT INTO `sys_rlat_user_role` VALUES (3, 1, 40, 1, '2020-08-20 09:42:43');
INSERT INTO `sys_rlat_user_role` VALUES (4, 2, 40, 1, '2020-08-20 09:42:49');
INSERT INTO `sys_rlat_user_role` VALUES (5, 1023, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (6, 1024, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (7, 1025, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (8, 1026, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (9, 1027, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (10, 1028, 10, 1, '2020-08-27 10:56:04');
INSERT INTO `sys_rlat_user_role` VALUES (11, 1029, 60, NULL, '2020-08-27 10:56:58');
INSERT INTO `sys_rlat_user_role` VALUES (12, 1030, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (13, 1031, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (14, 1032, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (15, 1033, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (16, 1034, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (17, 1035, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (18, 1036, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (19, 1037, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (20, 1038, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (21, 1039, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (22, 1040, 60, NULL, '2020-08-27 10:56:59');
INSERT INTO `sys_rlat_user_role` VALUES (23, 1041, 60, NULL, '2020-08-27 10:56:59');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色编码',
  `descr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `update_by` int(11) DEFAULT NULL COMMENT '操作用户ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (10, '项目经理', 'project', '项目经理', 1, '2020-08-06 11:14:05');
INSERT INTO `sys_role` VALUES (20, '部门经理', 'depart', '部门经理', 1, '2020-08-06 11:14:05');
INSERT INTO `sys_role` VALUES (30, '分管领导', 'general_manager', '分管领导', 1, '2020-08-06 11:14:05');
INSERT INTO `sys_role` VALUES (40, '总经理', 'manager', '总经理', 1, '2020-08-06 11:14:06');
INSERT INTO `sys_role` VALUES (50, '投资计划专员', 'invest', '投资计划专员,投资计划清单全部查看', 1, '2020-08-06 11:14:27');
INSERT INTO `sys_role` VALUES (60, '工程部项目经理', 'eng_project', '工程部项目经理', 1, '2020-08-27 10:53:57');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `birthday` datetime(0) DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) DEFAULT NULL COMMENT '性别(1-正常,2-冻结)',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `activiti_sync` tinyint(1) DEFAULT NULL COMMENT '同步工作流引擎(1-同步,0-不同步)',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `identity` tinyint(1) DEFAULT NULL COMMENT '身份（1普通成员 2上级）',
  `depart_ids` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '负责部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_user_name`(`username`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no`) USING BTREE,
  INDEX `index_user_status`(`status`) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '系统', 'd41ccd3642c15f5e', 'AbzqG0qJ', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18121105875', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1000', 'zhuzhengjun', '诸正君', '3d748aba9595f05bfc170638e68cb564', 'sddCMBUC', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916860600', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1001', 'liuxueqing', '刘学庆', '01f889dbf91dc09a5ee43888b884f61a', '036RJNmb', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13701973933', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1002', 'xuwenyi', '徐文一', 'f33f3c7ff13c847e', 'ao8XGxkb', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13901865492', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1003', 'shihairong', '施海熔', '316bec3cec1fd4185b4614cf05de22aa', 'fbjfZyZf', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916245949', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1004', 'duchuanbao', '杜传宝', '7c1d77c36d97e2f8755ba174aaf04e6f', 'R6ZhAVf0', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13391048428', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1005', 'sunyinan', '孙一楠', '649064aa9989c345df388b931f4de117', '65m6djIb', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13818966269', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1006', 'dinglijian', '丁黎健', '3a09548cdcb6ad5d263c47a4818af6bf', '9UXRnzeS', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13661646701', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1007', 'kongshanshan', '孔珊珊', '5a65dd68e3fe63632c51a80f2ed02fb9', 'XY9jTxrb', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15921071005', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1008', 'donglujie', '董璐洁', 'd6df531b46b632efaa291844d0ff7062', 'Mh13A15o', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13764662157', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1009', 'huangran', '黄然', '461e4daa3ce65b5ecb641db20d9f394b', 'JDJd7QiZ', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13816372749', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1010', 'taoguoqing', '陶国庆', '2bfd54afea10df78047d10827de4388b', 'd9I53AuM', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916763436', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1011', 'wangzhenghai', '王郑海', '4a870e3db597aeef5a3b3370caff54d8', 'sJg4V4pe', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916566379', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1012', 'chenjing', '陈靖', '6e752999ebcea6de2871fed37caa981a', 'PqNpwCfQ', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13816566559', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1013', 'jinyundi', '金云弟', '909c9b749f249f907d8a905656fcd00f', 'uTDbB8rD', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916409311', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1014', 'chenxuejiao', '陈雪娇', '50c8efadfa6cb70ffcf4d5f663702f84', 'hbqCvLoa', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18019191399', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1015', 'zhangliqin', '张莉琴', '6e62fa88b9264da28c01c3a99d0b3868', '1V84ovId', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13661649376', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1016', 'huang　qing', '黄　青', '31e464dec6efbe3ce5d39ed0f162e475', '9OGa4iXX', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18019120585', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1017', 'fanwanzhang', '范宛璋', '0d9d9d6d5631a1eaadb569fe73c88234', 'Y31laaaX', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13818236100', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1018', 'guoming', '郭明', '5699022e3a9e5652', 'NsV9FtOm', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15921995499', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1019', 'jiangchenyan', '江晨燕', 'ab58dcdd63471fa237c797decd6b0436', 'd05NNAnU', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13818593946', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1020', 'qian　zheng', '钱　铮', '74b5ac211add4dc81c03136ed15c193f', 'U26LHZHj', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13816515772', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1021', 'panxiaolei', '潘晓蕾', 'e30053ccdc82be3271155264b2cc658f', 'gkbCBz6a', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13761037072', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1022', 'liweijian', '李纬健', 'ab7ed5c3715bc3e84117c26590f150d5', 'ql8vm6F4', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13681793462', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1023', 'liyuan', '李媛', '9aac06268343d3c9', 'n1L9XRn1', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13918761671', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1024', 'lilongmei', '李龙梅', '8e8f8950c9569b6ad269182c1a879659', '7aWKn63T', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18616081982', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1025', 'luyi', '陆怡', 'b31c46917507db9d', 'pKXgtEnh', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13916637826', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1026', 'wangjiuxiao', '王九霄', '5dd2fd8a28d208ffc512dce6dce3801b', 'VicE1i3t', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13788902516', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1027', 'fangqiuyue', '方秋月', '03e0ba3080cfa9d59305a1b7c20f35d2', 'SKS04rxe', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18817826135', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1028', 'chenliwen', '陈立文', 'c5ad2c41f8d7c0533e79cb68cb803c37', 'AzANTTuT', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15216707367', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1029', 'huangzhenqing', '黄臻清', 'e1b060cea6390a977e0edc038282e933', 'l1gflP2T', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13701978273', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1030', 'hushenghui', '胡升辉', '4a3f74dc53a94ed5e91e5cea2d9c4166', 'FIq4K1Zi', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15000017771', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1031', 'wangyingjiong', '王应炯', '3d9efc6469de6558bffa44b66eb45161', 'dqx1O5ZT', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18616808209', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1032', 'panfengyan', '潘峰燕', 'b172738b9429d985f8a970c5ab4e1b76', '8JM2M39k', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13661666876', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1033', 'yeshengbin', '叶圣斌', '7df43f18b3683405446ad2ed3965dbbd', 'Qa4c6bic', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13764181419', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1034', 'ruanzhiyong', '阮治勇', 'cff01f168122eb700f00a4e89c779afa', 'fH9ILTGc', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15000176229', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1035', 'qijiayu', '齐珈誉', '4768cab1e2efc355', '4XYJiWKA', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13167210420', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1036', 'zhangwei', '张伟', 'd3adbfc166f17f7b493dd612bf71917a', 'GysedWan', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15821759798', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1037', 'maoyin', '毛寅', '3cc9b979497d1e5e', 'McNBpF4V', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18918192124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1038', 'wuxinrui', '吴欣睿', 'eafe1d0f9e3d4332d458d90b0c50e4d8', 'QlIGlbtE', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13564039792', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1039', 'lutianyu', '陆天宇', 'fc9b4f7de6d703a9377549d3fd0a02e1', 'kOPQEOaq', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '17317804665', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1040', 'caoxiaoxin', '曹晓鑫', '00aa5733855bc9233c6e234923cc1b6c', '9jPtMFZ0', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13651852557', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1041', 'wangjie', '汪洁', 'e3ca850ee5e62f33', 'YxfWWsRz', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18516290761', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1042', 'chenlei', '陈雷', '6f61c9752db1a1c8', 'Fduw7nWN', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18616691313', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1043', 'gaoyuwen', '高玉文', 'cf4a22ea04eac0e75801754434f7131f', 'mStf4qcR', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13127674784', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1044', 'qiaohua', '乔华', 'a401b989829152e2', 'ag0XiK2O', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13661969996', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1045', 'zhulimin', '朱立民', 'b9c0a528cfb2edffd64950680822dd80', 'z32SgSCx', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13671556943', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1046', 'dushaonan', '杜少楠', '104918839f166c832c66e69f6e3947c1', 'Dg4t9jeb', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '15618599945', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1047', 'xuxindi', '徐欣迪', 'd54e054ba8ad5e6d', 'b3EOdCrM', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18017269561', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1048', 'xiyafang', '奚亚芳', '19e35a2f7aa0381935bb49afc47e86fc', 'f7hp8l74', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13661557154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1049', 'zhangni', '张妮', 'ffebcfc2ffec69a9', 'mSrp6wwE', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13816270418', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1050', 'chenye', '陈烨', '254cb83d3aef914a', 'GCTGbX2g', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13671646593', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1051', 'liqian', '李倩', '335080295156029a', 'TR44d8av', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '18301979223', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1052', 'yingyichu', '应一初', 'c042090e28af85b21469732130377f72', 'Uwd6qeRn', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '17301848163', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1053', 'xuyihong', '徐依虹', '7574c523c49914745decc79d1306962e', 'q1ApG8XM', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13816553022', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1054', 'zhaoxiaoying', '赵筱英', '57d693b422fa8157e6c0e7a8c2f215f8', 'r2ORxjck', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13651780006', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1055', 'jiangxinhua', '蒋心华', '1580ae21d441c105703b5b6936d09131', 'peAwL75D', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13761189740', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1056', 'fanmingyue', '范明月', '2fb09a505ff9c26230d59e17d2ec88d7', 'KC9k9q5B', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '17802103536', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('1057', 'jinliming', '金黎明', '092e0dc30663ae7c262e2613513e6d48', 'ZWnB3SRx', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13120503719', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('2', 'test', 'test', 'c7859f37bf717e74', 'QOfOc5JU', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, '13849104232', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
