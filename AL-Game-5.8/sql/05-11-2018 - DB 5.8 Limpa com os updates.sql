/*
MySQL Backup
Source Server Version: 5.6.21
Source Database: al_server_gs
Date: 05/11/2018 15:49:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `abyss_landing`
-- ----------------------------
DROP TABLE IF EXISTS `abyss_landing`;
CREATE TABLE `abyss_landing` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `points` int(10) NOT NULL DEFAULT '0',
  `siege` int(10) NOT NULL DEFAULT '0',
  `commander` int(10) NOT NULL DEFAULT '0',
  `artefact` int(10) NOT NULL DEFAULT '0',
  `base` int(10) NOT NULL DEFAULT '0',
  `monuments` int(10) NOT NULL DEFAULT '0',
  `quest` int(10) NOT NULL DEFAULT '0',
  `facility` int(10) NOT NULL DEFAULT '0',
  `race` enum('ELYOS','ASMODIANS') NOT NULL,
  `level_up_date` timestamp NOT NULL DEFAULT '2015-01-01 01:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `abyss_rank`
-- ----------------------------
DROP TABLE IF EXISTS `abyss_rank`;
CREATE TABLE `abyss_rank` (
  `player_id` int(11) NOT NULL,
  `daily_ap` int(11) NOT NULL,
  `daily_gp` int(11) NOT NULL,
  `weekly_ap` int(11) NOT NULL,
  `weekly_gp` int(11) NOT NULL,
  `ap` int(11) NOT NULL,
  `gp` int(11) NOT NULL,
  `rank` int(2) NOT NULL DEFAULT '1',
  `top_ranking` int(4) NOT NULL,
  `daily_kill` int(5) NOT NULL,
  `weekly_kill` int(5) NOT NULL,
  `all_kill` int(4) NOT NULL DEFAULT '0',
  `max_rank` int(2) NOT NULL DEFAULT '1',
  `last_kill` int(5) NOT NULL,
  `last_ap` int(11) NOT NULL,
  `last_gp` int(11) NOT NULL,
  `last_update` decimal(20,0) NOT NULL,
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `rank_ap` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `abyss_rank_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `announcements`
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `announce` text NOT NULL,
  `faction` enum('ALL','ASMODIANS','ELYOS') NOT NULL DEFAULT 'ALL',
  `type` enum('SHOUT','ORANGE','YELLOW','WHITE','SYSTEM') NOT NULL DEFAULT 'SYSTEM',
  `delay` int(4) NOT NULL DEFAULT '1800',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `banned_hdd`
-- ----------------------------
DROP TABLE IF EXISTS `banned_hdd`;
CREATE TABLE `banned_hdd` (
  `uniId` int(10) NOT NULL AUTO_INCREMENT,
  `hdd_serial` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`uniId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `base_location`
-- ----------------------------
DROP TABLE IF EXISTS `base_location`;
CREATE TABLE `base_location` (
  `id` int(11) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','NPC') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `blocks`
-- ----------------------------
DROP TABLE IF EXISTS `blocks`;
CREATE TABLE `blocks` (
  `player` int(11) NOT NULL,
  `blocked_player` int(11) NOT NULL,
  `reason` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`player`,`blocked_player`),
  KEY `blocked_player` (`blocked_player`),
  CONSTRAINT `blocks_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `blocks_ibfk_2` FOREIGN KEY (`blocked_player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `bookmark`
-- ----------------------------
DROP TABLE IF EXISTS `bookmark`;
CREATE TABLE `bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `char_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `world_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `broker`
-- ----------------------------
DROP TABLE IF EXISTS `broker`;
CREATE TABLE `broker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_pointer` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL,
  `item_creator` varchar(50) DEFAULT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `price` bigint(20) NOT NULL DEFAULT '0',
  `broker_race` enum('ELYOS','ASMODIAN') NOT NULL,
  `expire_time` timestamp NOT NULL DEFAULT '2010-01-01 02:00:00',
  `settle_time` timestamp NOT NULL DEFAULT '2010-01-01 02:00:00',
  `seller_id` int(11) NOT NULL,
  `is_sold` tinyint(1) NOT NULL,
  `is_settled` tinyint(1) NOT NULL,
  `is_partsale` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `broker_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `challenge_tasks`
-- ----------------------------
DROP TABLE IF EXISTS `challenge_tasks`;
CREATE TABLE `challenge_tasks` (
  `task_id` int(11) NOT NULL,
  `quest_id` int(10) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` enum('LEGION','TOWN') NOT NULL,
  `complete_count` int(3) unsigned NOT NULL DEFAULT '0',
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`task_id`,`quest_id`,`owner_id`,`owner_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_cooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `craft_cooldowns`;
CREATE TABLE `craft_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) unsigned NOT NULL,
  `reuse_time` bigint(13) unsigned NOT NULL,
  PRIMARY KEY (`player_id`,`delay_id`),
  CONSTRAINT `craft_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `event_items`
-- ----------------------------
DROP TABLE IF EXISTS `event_items`;
CREATE TABLE `event_items` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `counts` int(10) unsigned NOT NULL,
  PRIMARY KEY (`player_id`,`item_id`),
  CONSTRAINT `event_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `f2paccount`
-- ----------------------------
DROP TABLE IF EXISTS `f2paccount`;
CREATE TABLE `f2paccount` (
  `account_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `friends`
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `player` int(11) NOT NULL,
  `friend` int(11) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`player`,`friend`),
  KEY `friend` (`friend`),
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `guides`
-- ----------------------------
DROP TABLE IF EXISTS `guides`;
CREATE TABLE `guides` (
  `guide_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  PRIMARY KEY (`guide_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `guides_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `guild_quests`
-- ----------------------------
DROP TABLE IF EXISTS `guild_quests`;
CREATE TABLE `guild_quests` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(2) NOT NULL DEFAULT '0',
  `recently_taken_quest` int(6) NOT NULL DEFAULT '0',
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `currently_started_quest` int(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `guild_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `houses`
-- ----------------------------
DROP TABLE IF EXISTS `houses`;
CREATE TABLE `houses` (
  `id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL DEFAULT '0',
  `building_id` int(10) NOT NULL,
  `address` int(10) NOT NULL,
  `acquire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `settings` int(11) NOT NULL DEFAULT '0',
  `status` enum('ACTIVE','SELL_WAIT','INACTIVE','NOSALE') NOT NULL DEFAULT 'ACTIVE',
  `fee_paid` tinyint(1) NOT NULL DEFAULT '1',
  `next_pay` timestamp NULL DEFAULT NULL,
  `sell_started` timestamp NULL DEFAULT NULL,
  `sign_notice` text CHARACTER SET utf16le NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_2` (`address`),
  KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `house_bids`
-- ----------------------------
DROP TABLE IF EXISTS `house_bids`;
CREATE TABLE `house_bids` (
  `player_id` int(10) NOT NULL,
  `house_id` int(10) NOT NULL,
  `bid` bigint(20) NOT NULL,
  `bid_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`player_id`,`house_id`,`bid`),
  KEY `house_id_ibfk_1` (`house_id`),
  CONSTRAINT `house_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `house_object_cooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `house_object_cooldowns`;
CREATE TABLE `house_object_cooldowns` (
  `player_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `reuse_time` bigint(20) NOT NULL,
  PRIMARY KEY (`player_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `house_scripts`
-- ----------------------------
DROP TABLE IF EXISTS `house_scripts`;
CREATE TABLE `house_scripts` (
  `house_id` int(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  `script` mediumtext,
  PRIMARY KEY (`house_id`,`index`),
  CONSTRAINT `houses_id_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=16;

-- ----------------------------
--  Table structure for `inventory`
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` bigint(20) NOT NULL DEFAULT '0',
  `item_color` int(11) NOT NULL DEFAULT '0',
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `item_creator` varchar(50) DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `activation_count` int(11) NOT NULL DEFAULT '0',
  `item_owner` int(11) NOT NULL,
  `is_equiped` tinyint(1) NOT NULL DEFAULT '0',
  `is_soul_bound` tinyint(1) NOT NULL DEFAULT '0',
  `slot` bigint(20) NOT NULL DEFAULT '0',
  `item_location` tinyint(1) DEFAULT '0',
  `enchant` tinyint(1) DEFAULT '0',
  `item_skin` int(11) NOT NULL DEFAULT '0',
  `fusioned_item` int(11) NOT NULL DEFAULT '0',
  `optional_socket` int(1) NOT NULL DEFAULT '0',
  `optional_fusion_socket` int(1) NOT NULL DEFAULT '0',
  `charge` mediumint(9) NOT NULL DEFAULT '0',
  `rnd_bonus` smallint(6) DEFAULT NULL,
  `rnd_count` smallint(6) NOT NULL DEFAULT '0',
  `pack_count` smallint(6) NOT NULL DEFAULT '0',
  `authorize` int(11) NOT NULL DEFAULT '0',
  `is_packed` tinyint(1) NOT NULL DEFAULT '0',
  `is_amplified` tinyint(1) NOT NULL DEFAULT '0',
  `buff_skill` int(11) NOT NULL DEFAULT '0',
  `reduction_level` int(11) NOT NULL,
  `luna_reskin` tinyint(1) NOT NULL DEFAULT '0',
  `isEnhance` tinyint(1) NOT NULL DEFAULT '0',
  `enhanceSkillId` int(11) NOT NULL DEFAULT '0',
  `enhanceSkillEnchant` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_unique_id`),
  KEY `item_location` (`item_location`) USING HASH,
  KEY `index3` (`item_owner`,`item_location`,`is_equiped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `item_cooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `item_cooldowns`;
CREATE TABLE `item_cooldowns` (
  `player_id` int(11) NOT NULL,
  `delay_id` int(11) NOT NULL,
  `use_delay` int(10) unsigned NOT NULL,
  `reuse_time` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`delay_id`),
  CONSTRAINT `item_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `item_stones`
-- ----------------------------
DROP TABLE IF EXISTS `item_stones`;
CREATE TABLE `item_stones` (
  `item_unique_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` int(2) NOT NULL,
  `category` int(2) NOT NULL DEFAULT '0',
  `polishNumber` int(11) NOT NULL DEFAULT '0',
  `polishCharge` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_unique_id`,`slot`,`category`),
  CONSTRAINT `item_stones_ibfk_1` FOREIGN KEY (`item_unique_id`) REFERENCES `inventory` (`item_unique_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legions`
-- ----------------------------
DROP TABLE IF EXISTS `legions`;
CREATE TABLE `legions` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `level` int(1) NOT NULL DEFAULT '1',
  `contribution_points` bigint(20) NOT NULL DEFAULT '0',
  `deputy_permission` int(11) NOT NULL DEFAULT '7692',
  `centurion_permission` int(11) NOT NULL DEFAULT '7176',
  `legionary_permission` int(11) NOT NULL DEFAULT '6144',
  `volunteer_permission` int(11) NOT NULL DEFAULT '2048',
  `disband_time` int(11) NOT NULL DEFAULT '0',
  `rank_cp` int(11) NOT NULL DEFAULT '0',
  `rank_pos` int(11) NOT NULL DEFAULT '0',
  `old_rank_pos` int(11) NOT NULL DEFAULT '0',
  `world_owner` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `joinType` int(1) NOT NULL DEFAULT '0',
  `minJoinLevel` int(3) NOT NULL DEFAULT '0',
  `territory` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legion_announcement_list`
-- ----------------------------
DROP TABLE IF EXISTS `legion_announcement_list`;
CREATE TABLE `legion_announcement_list` (
  `legion_id` int(11) NOT NULL,
  `announcement` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_announcement_list_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legion_emblems`
-- ----------------------------
DROP TABLE IF EXISTS `legion_emblems`;
CREATE TABLE `legion_emblems` (
  `legion_id` int(11) NOT NULL,
  `emblem_id` int(1) NOT NULL DEFAULT '0',
  `color_r` int(3) NOT NULL DEFAULT '0',
  `color_g` int(3) NOT NULL DEFAULT '0',
  `color_b` int(3) NOT NULL DEFAULT '0',
  `emblem_type` enum('DEFAULT','CUSTOM') NOT NULL DEFAULT 'DEFAULT',
  `emblem_data` longblob,
  PRIMARY KEY (`legion_id`),
  CONSTRAINT `legion_emblems_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legion_history`
-- ----------------------------
DROP TABLE IF EXISTS `legion_history`;
CREATE TABLE `legion_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `legion_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `history_type` enum('CREATE','JOIN','KICK','APPOINTED','EMBLEM_REGISTER','EMBLEM_MODIFIED','ITEM_DEPOSIT','ITEM_WITHDRAW','KINAH_DEPOSIT','KINAH_WITHDRAW','LEVEL_UP') NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `tab_id` smallint(3) NOT NULL DEFAULT '0',
  `description` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_history_ibfk_1` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legion_join_requests`
-- ----------------------------
DROP TABLE IF EXISTS `legion_join_requests`;
CREATE TABLE `legion_join_requests` (
  `legionId` int(11) NOT NULL DEFAULT '0',
  `playerId` int(11) NOT NULL DEFAULT '0',
  `playerName` varchar(64) NOT NULL DEFAULT '',
  `playerClassId` int(2) NOT NULL DEFAULT '0',
  `playerRaceId` int(2) NOT NULL DEFAULT '0',
  `playerLevel` int(4) NOT NULL DEFAULT '0',
  `playerGenderId` int(2) NOT NULL DEFAULT '0',
  `joinRequestMsg` varchar(40) NOT NULL DEFAULT '',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`legionId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `legion_members`
-- ----------------------------
DROP TABLE IF EXISTS `legion_members`;
CREATE TABLE `legion_members` (
  `legion_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `nickname` varchar(10) NOT NULL DEFAULT '',
  `rank` enum('BRIGADE_GENERAL','CENTURION','LEGIONARY','DEPUTY','VOLUNTEER') NOT NULL DEFAULT 'VOLUNTEER',
  `selfintro` varchar(32) DEFAULT '',
  `challenge_score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  KEY `player_id` (`player_id`),
  KEY `legion_id` (`legion_id`),
  CONSTRAINT `legion_members_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `legion_members_ibfk_2` FOREIGN KEY (`legion_id`) REFERENCES `legions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `mail`
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `mail_unique_id` int(11) NOT NULL,
  `mail_recipient_id` int(11) NOT NULL,
  `sender_name` varchar(26) NOT NULL,
  `mail_title` varchar(32) NOT NULL,
  `mail_message` varchar(1000) NOT NULL,
  `unread` tinyint(4) NOT NULL DEFAULT '1',
  `attached_item_id` int(11) NOT NULL,
  `attached_kinah_count` bigint(20) NOT NULL,
  `express` tinyint(4) NOT NULL DEFAULT '0',
  `recieved_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mail_unique_id`),
  KEY `mail_recipient_id` (`mail_recipient_id`),
  CONSTRAINT `FK_mail` FOREIGN KEY (`mail_recipient_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `network_ban`
-- ----------------------------
DROP TABLE IF EXISTS `network_ban`;
CREATE TABLE `network_ban` (
  `uniId` int(10) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `details` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`uniId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `old_names`
-- ----------------------------
DROP TABLE IF EXISTS `old_names`;
CREATE TABLE `old_names` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `old_name` varchar(50) NOT NULL,
  `new_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `petitions`
-- ----------------------------
DROP TABLE IF EXISTS `petitions`;
CREATE TABLE `petitions` (
  `id` bigint(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `add_data` varchar(255) DEFAULT NULL,
  `time` bigint(11) NOT NULL DEFAULT '0',
  `status` enum('PENDING','IN_PROGRESS','REPLIED') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `players`
-- ----------------------------
DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `account_id` int(11) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `exp` bigint(20) NOT NULL DEFAULT '0',
  `recoverexp` bigint(20) NOT NULL DEFAULT '0',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `world_owner` int(11) NOT NULL DEFAULT '0',
  `gender` enum('MALE','FEMALE') NOT NULL,
  `race` enum('ASMODIANS','ELYOS') NOT NULL,
  `player_class` enum('WARRIOR','GLADIATOR','TEMPLAR','SCOUT','ASSASSIN','RANGER','MAGE','SORCERER','SPIRIT_MASTER','PRIEST','CLERIC','CHANTER','ENGINEER','GUNNER','ARTIST','BARD','RIDER','ALL') NOT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  `last_online` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `cube_expands` tinyint(1) NOT NULL DEFAULT '0',
  `advanced_stigma_slot_size` tinyint(1) NOT NULL DEFAULT '0',
  `warehouse_size` tinyint(1) NOT NULL DEFAULT '0',
  `mailbox_letters` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `title_id` int(3) NOT NULL DEFAULT '-1',
  `bonus_title_id` int(3) NOT NULL DEFAULT '-1',
  `dp` int(3) NOT NULL DEFAULT '0',
  `soul_sickness` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reposte_energy` bigint(20) NOT NULL DEFAULT '0',
  `goldenstar_energy` bigint(20) NOT NULL DEFAULT '0',
  `growth_energy` bigint(20) NOT NULL DEFAULT '0',
  `bg_points` int(11) NOT NULL DEFAULT '0',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `note` text,
  `mentor_flag_time` int(11) NOT NULL DEFAULT '0',
  `initial_gamestats` int(11) NOT NULL DEFAULT '0',
  `last_transfer_time` decimal(20,0) NOT NULL DEFAULT '0',
  `fatigue` int(11) NOT NULL DEFAULT '0',
  `fatigueRecover` int(11) NOT NULL DEFAULT '0',
  `fatigueReset` int(11) NOT NULL DEFAULT '0',
  `stamps` int(11) NOT NULL DEFAULT '0',
  `last_stamp` timestamp NULL DEFAULT NULL,
  `rewarded_pass` int(1) NOT NULL DEFAULT '0',
  `joinRequestLegionId` int(11) NOT NULL DEFAULT '0',
  `joinRequestState` enum('NONE','DENIED','ACCEPTED') NOT NULL DEFAULT 'NONE',
  `frenzy_points` int(4) NOT NULL DEFAULT '0' COMMENT 'Upgrade Arcade FrenzyPoints',
  `frenzy_count` int(1) NOT NULL DEFAULT '0',
  `show_inventory` int(1) NOT NULL DEFAULT '1',
  `bonus_buff_time` timestamp NULL DEFAULT NULL,
  `bonus_type` enum('RETURN','NEW','NORMAL') NOT NULL DEFAULT 'NORMAL',
  `wardrobe_size` int(4) NOT NULL,
  `is_highdaeva` tinyint(1) NOT NULL DEFAULT '0',
  `creativity_point` int(11) NOT NULL DEFAULT '0',
  `creativity_step` int(11) NOT NULL DEFAULT '0',
  `wardrobe_slot` int(11) NOT NULL DEFAULT '2',
  `luna_consume_count` int(11) NOT NULL DEFAULT '0',
  `muni_keys` int(11) NOT NULL DEFAULT '0',
  `luna_consume` int(11) NOT NULL DEFAULT '0',
  `toc_floor` int(11) NOT NULL DEFAULT '0',
  `minion_skill_points` int(5) NOT NULL DEFAULT '0',
  `minion_function_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_appearance`
-- ----------------------------
DROP TABLE IF EXISTS `player_appearance`;
CREATE TABLE `player_appearance` (
  `player_id` int(11) NOT NULL,
  `voice` int(11) DEFAULT NULL,
  `skin_rgb` int(11) DEFAULT NULL,
  `hair_rgb` int(11) DEFAULT NULL,
  `eye_rgb` int(11) DEFAULT NULL,
  `lip_rgb` int(11) DEFAULT NULL,
  `face` int(11) NOT NULL,
  `hair` int(11) NOT NULL,
  `deco` int(11) NOT NULL,
  `tattoo` int(11) NOT NULL,
  `face_contour` int(11) NOT NULL,
  `expression` int(11) NOT NULL,
  `pupil_shape` int(11) NOT NULL,
  `remove_mane` int(11) NOT NULL,
  `right_eye_rgb` int(11) NOT NULL,
  `eye_lash_shape` int(11) NOT NULL,
  `jaw_line` int(11) NOT NULL,
  `forehead` int(11) NOT NULL,
  `eye_height` int(11) NOT NULL,
  `eye_space` int(11) NOT NULL,
  `eye_width` int(11) NOT NULL,
  `eye_size` int(11) NOT NULL,
  `eye_shape` int(11) NOT NULL,
  `eye_angle` int(11) NOT NULL,
  `brow_height` int(11) NOT NULL,
  `brow_angle` int(11) NOT NULL,
  `brow_shape` int(11) NOT NULL,
  `nose` int(11) NOT NULL,
  `nose_bridge` int(11) NOT NULL,
  `nose_width` int(11) NOT NULL,
  `nose_tip` int(11) NOT NULL,
  `cheek` int(11) NOT NULL,
  `lip_height` int(11) NOT NULL,
  `mouth_size` int(11) NOT NULL,
  `lip_size` int(11) NOT NULL,
  `smile` int(11) NOT NULL,
  `lip_shape` int(11) NOT NULL,
  `jaw_height` int(11) NOT NULL,
  `chin_jut` int(11) NOT NULL,
  `ear_shape` int(11) NOT NULL,
  `head_size` int(11) NOT NULL,
  `neck` int(11) NOT NULL,
  `neck_length` int(11) NOT NULL,
  `shoulder_size` int(11) NOT NULL,
  `torso` int(11) NOT NULL,
  `chest` int(11) NOT NULL,
  `waist` int(11) NOT NULL,
  `hips` int(11) NOT NULL,
  `arm_thickness` int(11) NOT NULL,
  `hand_size` int(11) NOT NULL,
  `leg_thickness` int(11) NOT NULL,
  `facial_rate` int(11) NOT NULL,
  `foot_size` int(11) NOT NULL,
  `arm_length` int(11) NOT NULL,
  `leg_length` int(11) NOT NULL,
  `shoulders` int(11) NOT NULL,
  `face_shape` int(11) NOT NULL,
  `pupil_size` int(11) NOT NULL,
  `upper_torso` int(11) NOT NULL,
  `fore_arm_thickness` int(11) NOT NULL,
  `hand_span` int(11) NOT NULL,
  `calf_thickness` int(11) NOT NULL,
  `height` float NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_bind_point`
-- ----------------------------
DROP TABLE IF EXISTS `player_bind_point`;
CREATE TABLE `player_bind_point` (
  `player_id` int(11) NOT NULL,
  `map_id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` int(3) NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_bind_point_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_cooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `player_cooldowns`;
CREATE TABLE `player_cooldowns` (
  `player_id` int(11) NOT NULL,
  `cooldown_id` int(6) NOT NULL,
  `reuse_delay` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`cooldown_id`),
  CONSTRAINT `player_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_cp`
-- ----------------------------
DROP TABLE IF EXISTS `player_cp`;
CREATE TABLE `player_cp` (
  `player_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `point` int(3) NOT NULL,
  PRIMARY KEY (`player_id`,`slot`),
  CONSTRAINT `player_cp_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_effects`
-- ----------------------------
DROP TABLE IF EXISTS `player_effects`;
CREATE TABLE `player_effects` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_lvl` tinyint(4) NOT NULL,
  `current_time` int(11) NOT NULL,
  `end_time` bigint(13) NOT NULL,
  PRIMARY KEY (`player_id`,`skill_id`),
  CONSTRAINT `player_effects_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_emotions`
-- ----------------------------
DROP TABLE IF EXISTS `player_emotions`;
CREATE TABLE `player_emotions` (
  `player_id` int(11) NOT NULL,
  `emotion` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`emotion`),
  CONSTRAINT `player_emotions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_equipment_setting`
-- ----------------------------
DROP TABLE IF EXISTS `player_equipment_setting`;
CREATE TABLE `player_equipment_setting` (
  `player_id` int(11) NOT NULL,
  `slot` int(255) NOT NULL,
  `display` tinyint(2) NOT NULL DEFAULT '0',
  `m_hand` int(21) NOT NULL DEFAULT '0',
  `s_hand` int(21) NOT NULL DEFAULT '0',
  `helmet` int(21) NOT NULL DEFAULT '0',
  `torso` int(21) NOT NULL DEFAULT '0',
  `glove` int(21) NOT NULL DEFAULT '0',
  `boots` int(21) NOT NULL DEFAULT '0',
  `earrings_left` int(21) NOT NULL DEFAULT '0',
  `earrings_right` int(21) NOT NULL DEFAULT '0',
  `ring_left` int(21) NOT NULL DEFAULT '0',
  `ring_right` int(21) NOT NULL DEFAULT '0',
  `necklace` int(21) NOT NULL DEFAULT '0',
  `shoulder` int(21) NOT NULL DEFAULT '0',
  `pants` int(21) NOT NULL DEFAULT '0',
  `powershard_left` int(21) NOT NULL DEFAULT '0',
  `powershard_right` int(21) NOT NULL DEFAULT '0',
  `wings` int(21) NOT NULL DEFAULT '0',
  `waist` int(21) NOT NULL DEFAULT '0',
  `m_off_hand` int(21) NOT NULL DEFAULT '0',
  `s_off_hand` int(21) NOT NULL DEFAULT '0',
  `plume` int(21) NOT NULL DEFAULT '0',
  `bracelet` int(21) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_events_window`
-- ----------------------------
DROP TABLE IF EXISTS `player_events_window`;
CREATE TABLE `player_events_window` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL DEFAULT '0',
  `last_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `elapsed` int(11) NOT NULL DEFAULT '0',
  `reward_recived_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_game_stats`
-- ----------------------------
DROP TABLE IF EXISTS `player_game_stats`;
CREATE TABLE `player_game_stats` (
  `player_id` int(11) NOT NULL,
  `defense_physic` int(11) NOT NULL DEFAULT '1',
  `block` int(11) NOT NULL DEFAULT '1',
  `parry` int(11) NOT NULL DEFAULT '1',
  `magical_critical` int(11) NOT NULL DEFAULT '1',
  `evasion` int(11) NOT NULL DEFAULT '1',
  `precision` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  `magical_precision` int(11) NOT NULL DEFAULT '1',
  `attack_speed` int(11) NOT NULL DEFAULT '1',
  `magical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_attack` int(11) NOT NULL DEFAULT '1',
  `main_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `off_hand_magical_attack` int(11) NOT NULL DEFAULT '1',
  `physical_critical` int(11) NOT NULL DEFAULT '1',
  `attack_range` int(11) NOT NULL DEFAULT '1',
  `magical_defense` int(11) NOT NULL DEFAULT '1',
  `agility` int(11) NOT NULL DEFAULT '1',
  `knowledge` int(11) NOT NULL DEFAULT '1',
  `will` int(11) NOT NULL DEFAULT '1',
  `magical_boost` int(11) NOT NULL DEFAULT '1',
  `magical_boost_resist` int(11) NOT NULL DEFAULT '1',
  `physical_critical_resist` int(11) NOT NULL DEFAULT '1',
  `magical_critical_resist` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_game_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_life_stats`
-- ----------------------------
DROP TABLE IF EXISTS `player_life_stats`;
CREATE TABLE `player_life_stats` (
  `player_id` int(11) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '1',
  `mp` int(11) NOT NULL DEFAULT '1',
  `fp` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `FK_player_life_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_luna_shop`
-- ----------------------------
DROP TABLE IF EXISTS `player_luna_shop`;
CREATE TABLE `player_luna_shop` (
  `player_id` int(10) NOT NULL,
  `free_under` tinyint(1) NOT NULL,
  `free_munition` tinyint(1) NOT NULL,
  `free_chest` tinyint(1) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_macrosses`
-- ----------------------------
DROP TABLE IF EXISTS `player_macrosses`;
CREATE TABLE `player_macrosses` (
  `player_id` int(11) NOT NULL,
  `order` int(3) NOT NULL,
  `macro` text NOT NULL,
  UNIQUE KEY `main` (`player_id`,`order`),
  CONSTRAINT `player_macrosses_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_minions`
-- ----------------------------
DROP TABLE IF EXISTS `player_minions`;
CREATE TABLE `player_minions` (
  `player_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL DEFAULT '0',
  `minion_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `grade` varchar(11) NOT NULL,
  `level` varchar(11) NOT NULL,
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `growthpoints` int(6) NOT NULL DEFAULT '0',
  `is_locked` int(1) NOT NULL DEFAULT '0',
  `buff_bag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`player_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_monsterbook`
-- ----------------------------
DROP TABLE IF EXISTS `player_monsterbook`;
CREATE TABLE `player_monsterbook` (
  `player_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `kill_count` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `claim_reward` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`id`),
  CONSTRAINT `fk_player_monsterbook` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_motions`
-- ----------------------------
DROP TABLE IF EXISTS `player_motions`;
CREATE TABLE `player_motions` (
  `player_id` int(11) NOT NULL,
  `motion_id` int(3) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`motion_id`) USING BTREE,
  CONSTRAINT `motions_player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_npc_factions`
-- ----------------------------
DROP TABLE IF EXISTS `player_npc_factions`;
CREATE TABLE `player_npc_factions` (
  `player_id` int(11) NOT NULL,
  `faction_id` int(2) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `time` int(11) NOT NULL,
  `state` enum('NOTING','START','COMPLETE') NOT NULL DEFAULT 'NOTING',
  `quest_id` int(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`faction_id`),
  CONSTRAINT `player_npc_factions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_passkey`
-- ----------------------------
DROP TABLE IF EXISTS `player_passkey`;
CREATE TABLE `player_passkey` (
  `account_id` int(11) NOT NULL,
  `passkey` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`,`passkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_passports`
-- ----------------------------
DROP TABLE IF EXISTS `player_passports`;
CREATE TABLE `player_passports` (
  `account_id` int(11) NOT NULL,
  `passport_id` int(11) NOT NULL,
  `stamps` int(11) NOT NULL DEFAULT '0',
  `last_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rewarded` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_passport` (`account_id`,`passport_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_pets`
-- ----------------------------
DROP TABLE IF EXISTS `player_pets`;
CREATE TABLE `player_pets` (
  `player_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `decoration` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hungry_level` tinyint(4) NOT NULL DEFAULT '0',
  `feed_progress` int(11) NOT NULL DEFAULT '0',
  `reuse_time` bigint(20) NOT NULL DEFAULT '0',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mood_started` bigint(20) NOT NULL DEFAULT '0',
  `counter` int(11) NOT NULL DEFAULT '0',
  `mood_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `gift_cd_started` bigint(20) NOT NULL DEFAULT '0',
  `dopings` varchar(80) CHARACTER SET ascii DEFAULT NULL,
  `despawn_time` timestamp NULL DEFAULT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`pet_id`),
  CONSTRAINT `FK_player_pets` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_punishments`
-- ----------------------------
DROP TABLE IF EXISTS `player_punishments`;
CREATE TABLE `player_punishments` (
  `player_id` int(11) NOT NULL,
  `punishment_type` enum('PRISON','GATHER','CHARBAN') NOT NULL,
  `start_time` int(10) unsigned DEFAULT '0',
  `duration` int(10) unsigned DEFAULT '0',
  `reason` text,
  PRIMARY KEY (`player_id`,`punishment_type`),
  CONSTRAINT `player_punishments_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_quests`
-- ----------------------------
DROP TABLE IF EXISTS `player_quests`;
CREATE TABLE `player_quests` (
  `player_id` int(11) NOT NULL,
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT 'NONE',
  `quest_vars` int(10) unsigned NOT NULL DEFAULT '0',
  `complete_count` int(3) unsigned NOT NULL DEFAULT '0',
  `next_repeat_time` timestamp NULL DEFAULT NULL,
  `reward` smallint(3) DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`,`quest_id`),
  CONSTRAINT `player_quests_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_recipes`
-- ----------------------------
DROP TABLE IF EXISTS `player_recipes`;
CREATE TABLE `player_recipes` (
  `player_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`,`recipe_id`),
  CONSTRAINT `player_recipes_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_registered_items`
-- ----------------------------
DROP TABLE IF EXISTS `player_registered_items`;
CREATE TABLE `player_registered_items` (
  `player_id` int(10) NOT NULL,
  `item_unique_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `expire_time` int(20) DEFAULT NULL,
  `color` int(11) DEFAULT NULL,
  `color_expires` int(11) NOT NULL DEFAULT '0',
  `owner_use_count` int(10) NOT NULL DEFAULT '0',
  `visitor_use_count` int(10) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `h` smallint(3) DEFAULT NULL,
  `area` enum('NONE','INTERIOR','EXTERIOR','ALL','DECOR') NOT NULL DEFAULT 'NONE',
  `floor` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`item_unique_id`,`item_id`),
  CONSTRAINT `player_regitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_settings`
-- ----------------------------
DROP TABLE IF EXISTS `player_settings`;
CREATE TABLE `player_settings` (
  `player_id` int(11) NOT NULL,
  `settings_type` tinyint(1) NOT NULL,
  `settings` blob NOT NULL,
  PRIMARY KEY (`player_id`,`settings_type`),
  CONSTRAINT `ps_pl_fk` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_shugo_sweep`
-- ----------------------------
DROP TABLE IF EXISTS `player_shugo_sweep`;
CREATE TABLE `player_shugo_sweep` (
  `player_id` int(11) NOT NULL,
  `free_dice` int(10) NOT NULL DEFAULT '0',
  `sweep_step` int(10) NOT NULL DEFAULT '0',
  `board_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_skills`
-- ----------------------------
DROP TABLE IF EXISTS `player_skills`;
CREATE TABLE `player_skills` (
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`,`skill_id`),
  CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_skill_skins`
-- ----------------------------
DROP TABLE IF EXISTS `player_skill_skins`;
CREATE TABLE `player_skill_skins` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `skin_id` int(11) NOT NULL DEFAULT '0',
  `remaining` bigint(22) DEFAULT '0',
  `active` int(1) DEFAULT '0',
  PRIMARY KEY (`player_id`,`skin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_titles`
-- ----------------------------
DROP TABLE IF EXISTS `player_titles`;
CREATE TABLE `player_titles` (
  `player_id` int(11) NOT NULL,
  `title_id` int(11) NOT NULL,
  `remaining` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`title_id`),
  CONSTRAINT `player_titles_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_transformation`
-- ----------------------------
DROP TABLE IF EXISTS `player_transformation`;
CREATE TABLE `player_transformation` (
  `player_id` int(10) NOT NULL,
  `panel_id` int(5) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_vars`
-- ----------------------------
DROP TABLE IF EXISTS `player_vars`;
CREATE TABLE `player_vars` (
  `player_id` int(11) NOT NULL,
  `param` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `time` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`player_id`,`param`),
  CONSTRAINT `player_vars_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_wardrobe`
-- ----------------------------
DROP TABLE IF EXISTS `player_wardrobe`;
CREATE TABLE `player_wardrobe` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `reskin_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`item_id`),
  CONSTRAINT `player_wardrobe_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `player_world_bans`
-- ----------------------------
DROP TABLE IF EXISTS `player_world_bans`;
CREATE TABLE `player_world_bans` (
  `player` int(11) NOT NULL,
  `by` varchar(255) NOT NULL,
  `duration` bigint(11) NOT NULL,
  `date` bigint(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`player`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `portal_cooldowns`
-- ----------------------------
DROP TABLE IF EXISTS `portal_cooldowns`;
CREATE TABLE `portal_cooldowns` (
  `player_id` int(11) NOT NULL,
  `world_id` int(11) NOT NULL,
  `reuse_time` bigint(13) NOT NULL,
  `entry_count` int(2) NOT NULL,
  PRIMARY KEY (`player_id`,`world_id`),
  CONSTRAINT `portal_cooldowns_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `server_variables`
-- ----------------------------
DROP TABLE IF EXISTS `server_variables`;
CREATE TABLE `server_variables` (
  `key` varchar(30) NOT NULL,
  `value` varchar(30) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `siege_locations`
-- ----------------------------
DROP TABLE IF EXISTS `siege_locations`;
CREATE TABLE `siege_locations` (
  `id` int(11) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `legion_id` int(11) NOT NULL,
  `occupy_count` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `siege_spawns`
-- ----------------------------
DROP TABLE IF EXISTS `siege_spawns`;
CREATE TABLE `siege_spawns` (
  `spawn_id` int(10) NOT NULL,
  `siege_id` int(10) NOT NULL,
  `race` enum('ELYOS','ASMODIANS','BALAUR') NOT NULL,
  `protector` int(10) DEFAULT '0',
  `stype` enum('PEACE','GUARD','ARTIFACT','PROTECTOR','MINE','PORTAL','GENERATOR','SPRING','RACEPROTECTOR','UNDERPASS') DEFAULT NULL,
  PRIMARY KEY (`spawn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `skill_motions`
-- ----------------------------
DROP TABLE IF EXISTS `skill_motions`;
CREATE TABLE `skill_motions` (
  `motion_name` varchar(255) NOT NULL DEFAULT '',
  `skill_id` int(11) NOT NULL,
  `attack_speed` int(11) NOT NULL,
  `weapon_type` varchar(255) NOT NULL,
  `off_weapon_type` varchar(255) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`motion_name`,`skill_id`,`attack_speed`,`weapon_type`,`off_weapon_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `spawns`
-- ----------------------------
DROP TABLE IF EXISTS `spawns`;
CREATE TABLE `spawns` (
  `spawn_id` int(10) NOT NULL AUTO_INCREMENT,
  `npc_id` int(10) NOT NULL,
  `npc_name` varchar(50) NOT NULL DEFAULT '',
  `map_id` int(10) NOT NULL,
  `pool_size` int(5) NOT NULL DEFAULT '1',
  `anchor` varchar(100) DEFAULT NULL,
  `handler` enum('RIFT','STATIC') DEFAULT NULL,
  `spawn_time` enum('ALL','DAY','NIGHT') NOT NULL DEFAULT 'ALL',
  `walker_id` int(10) NOT NULL DEFAULT '0',
  `random_walk` int(10) NOT NULL DEFAULT '0',
  `static_id` int(10) NOT NULL DEFAULT '0',
  `fly` tinyint(1) NOT NULL DEFAULT '0',
  `respawn_time` int(10) NOT NULL DEFAULT '0',
  `last_despawn_time` timestamp NULL DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(50) NOT NULL DEFAULT 'system',
  PRIMARY KEY (`spawn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `special_landing`
-- ----------------------------
DROP TABLE IF EXISTS `special_landing`;
CREATE TABLE `special_landing` (
  `id` int(2) NOT NULL,
  `type` enum('SPAWN','DESPAWN') NOT NULL DEFAULT 'DESPAWN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `surveys`
-- ----------------------------
DROP TABLE IF EXISTS `surveys`;
CREATE TABLE `surveys` (
  `unique_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `html_text` text NOT NULL,
  `html_radio` varchar(100) NOT NULL DEFAULT 'accept',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `used_time` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`unique_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tasks`
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(5) NOT NULL,
  `task_type` enum('SHUTDOWN','RESTART') NOT NULL,
  `trigger_type` enum('FIXED_IN_TIME') NOT NULL,
  `trigger_param` text NOT NULL,
  `exec_param` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `towns`
-- ----------------------------
DROP TABLE IF EXISTS `towns`;
CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `points` int(10) NOT NULL DEFAULT '0',
  `race` enum('ELYOS','ASMODIANS') NOT NULL,
  `level_up_date` timestamp NOT NULL DEFAULT '1970-01-01 07:00:01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `web_reward`
-- ----------------------------
DROP TABLE IF EXISTS `web_reward`;
CREATE TABLE `web_reward` (
  `unique` int(11) NOT NULL AUTO_INCREMENT,
  `item_owner` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_count` decimal(20,0) NOT NULL DEFAULT '1',
  `rewarded` tinyint(1) NOT NULL DEFAULT '0',
  `added` varchar(70) DEFAULT '',
  `received` varchar(70) DEFAULT '',
  PRIMARY KEY (`unique`),
  KEY `item_owner` (`item_owner`),
  CONSTRAINT `web_reward_ibfk_1` FOREIGN KEY (`item_owner`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `weddings`
-- ----------------------------
DROP TABLE IF EXISTS `weddings`;
CREATE TABLE `weddings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `player1` (`player1`),
  KEY `player2` (`player2`),
  CONSTRAINT `weddings_ibfk_1` FOREIGN KEY (`player1`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `weddings_ibfk_2` FOREIGN KEY (`player2`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `abyss_landing` VALUES ('1','1','0','0','0','0','0','0','0','0','ELYOS','2018-11-05 14:58:32'), ('2','1','18000','0','0','0','18000','0','0','0','ASMODIANS','2018-11-05 14:58:33');
INSERT INTO `abyss_rank` VALUES ('320949','0','0','0','0','0','0','1','0','0','0','0','1','0','0','0','1541437212728','1','0','0');
INSERT INTO `houses` VALUES ('71425','0','353000','6006','2018-11-05 13:26:39','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('71437','0','352000','6003','2018-11-05 13:26:28','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:14',''), ('220775','0','353000','7009','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('220779','0','352000','7002','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('220783','0','352000','7003','2018-11-05 13:26:39','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('220791','0','352000','7005','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('303933','0','350000','10019','2018-11-05 13:26:47','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('303957','0','353000','10097','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('303977','0','353000','10156','2018-11-05 13:26:28','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:14',''), ('304037','0','353000','10216','2018-11-05 13:26:46','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('304205','0','353000','10311','2018-11-05 13:26:46','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('304253','0','353000','10330','2018-11-05 13:26:44','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('304337','0','353000','10357','2018-11-05 13:26:25','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:12',''), ('304361','0','353000','10367','2018-11-05 13:26:45','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('304481','0','353000','10402','2018-11-05 13:26:44','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('304497','0','353000','10406','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('304545','0','353000','10419','2018-11-05 13:26:42','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('304569','0','353000','10425','2018-11-05 13:26:46','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('304593','0','353000','10431','2018-11-05 13:26:47','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('304645','0','353000','10444','2018-11-05 13:26:43','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('304669','0','353000','10450','2018-11-05 13:26:46','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('304673','0','353000','10451','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('304705','0','353000','10459','2018-11-05 13:26:42','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('304829','0','353000','10490','2018-11-05 13:26:36','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('304845','0','353000','10494','2018-11-05 13:26:29','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:15',''), ('304865','0','353000','10499','2018-11-05 13:26:42','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('304885','0','352000','10037','2018-11-05 13:26:37','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('304993','0','352000','10127','2018-11-05 13:26:27','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:13',''), ('305097','0','352000','10172','2018-11-05 13:26:36','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:17',''), ('305125','0','352000','10189','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('305237','0','352000','10247','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('305245','0','352000','10249','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('305257','0','352000','10262','2018-11-05 13:26:24','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:10',''), ('305341','0','352000','10305','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('305345','0','352000','10319','2018-11-05 13:26:36','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:17',''), ('305437','0','351000','10006','2018-11-05 13:26:35','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:16',''), ('305449','0','351000','10009','2018-11-05 13:26:26','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:13',''), ('305469','0','351000','10014','2018-11-05 13:26:24','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:09',''), ('305545','0','351000','10038','2018-11-05 13:26:26','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:13',''), ('305789','0','351000','10144','2018-11-05 13:26:37','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('307589','0','352000','20108','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('307625','0','352000','20128','2018-11-05 13:26:42','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('307649','0','352000','20134','2018-11-05 13:26:39','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('307705','0','352000','20167','2018-11-05 13:26:25','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:11',''), ('307937','0','352000','20285','2018-11-05 13:26:40','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('307941','0','352000','20286','2018-11-05 13:26:45','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('307993','0','352000','20324','2018-11-05 13:26:45','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('308069','0','353000','20077','2018-11-05 13:26:45','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('308117','0','353000','20177','2018-11-05 13:26:37','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('308181','0','353000','20235','2018-11-05 13:26:40','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('308213','0','353000','20255','2018-11-05 13:26:39','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('308237','0','353000','20272','2018-11-05 13:26:39','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('308293','0','353000','20295','2018-11-05 13:26:40','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:21',''), ('308305','0','353000','20306','2018-11-05 13:26:36','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:17',''), ('308369','0','353000','20329','2018-11-05 13:26:27','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:13',''), ('308457','0','353000','20357','2018-11-05 13:26:41','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('308509','0','353000','20374','2018-11-05 13:26:44','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('308529','0','353000','20382','2018-11-05 13:26:43','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('308549','0','353000','20387','2018-11-05 13:26:40','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('308605','0','353000','20403','2018-11-05 13:26:40','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:20',''), ('308649','0','353000','20414','2018-11-05 13:26:36','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('308681','0','353000','20423','2018-11-05 13:26:24','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:10',''), ('308685','0','353000','20424','2018-11-05 13:26:42','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:22',''), ('308725','0','353000','20434','2018-11-05 13:26:43','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:23',''), ('308773','0','353000','20446','2018-11-05 13:26:37','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:18',''), ('308829','0','353000','20460','2018-11-05 13:26:38','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:19',''), ('308993','0','350000','20001','2018-11-05 13:26:47','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:24',''), ('309025','0','351000','20008','2018-11-05 13:26:25','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:12',''), ('309037','0','351000','20011','2018-11-05 13:26:26','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:12',''), ('309121','0','351000','20033','2018-11-05 13:26:29','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:14',''), ('309221','0','351000','20069','2018-11-05 13:26:35','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:16',''), ('309353','0','351000','20140','2018-11-05 13:26:35','256','SELL_WAIT','1',NULL,'2018-11-05 13:26:15','');
INSERT INTO `house_bids` VALUES ('0','71425','12000000','2018-11-05 13:26:40'), ('0','71437','112000000','2018-11-05 13:26:28'), ('0','220775','12000000','2018-11-05 13:26:41'), ('0','220779','112000000','2018-11-05 13:26:39'), ('0','220783','112000000','2018-11-05 13:26:40'), ('0','220791','112000000','2018-11-05 13:26:38'), ('0','303933','1000000000','2018-11-05 13:26:47'), ('0','303957','12000000','2018-11-05 13:26:42'), ('0','303977','12000000','2018-11-05 13:26:29'), ('0','304037','12000000','2018-11-05 13:26:47'), ('0','304205','12000000','2018-11-05 13:26:47'), ('0','304253','12000000','2018-11-05 13:26:44'), ('0','304337','12000000','2018-11-05 13:26:26'), ('0','304361','12000000','2018-11-05 13:26:46'), ('0','304481','12000000','2018-11-05 13:26:44'), ('0','304497','12000000','2018-11-05 13:26:39'), ('0','304545','12000000','2018-11-05 13:26:43'), ('0','304569','12000000','2018-11-05 13:26:47'), ('0','304593','12000000','2018-11-05 13:26:47'), ('0','304645','12000000','2018-11-05 13:26:43'), ('0','304669','12000000','2018-11-05 13:26:46'), ('0','304673','12000000','2018-11-05 13:26:39'), ('0','304705','12000000','2018-11-05 13:26:43'), ('0','304829','12000000','2018-11-05 13:26:37'), ('0','304845','12000000','2018-11-05 13:26:29'), ('0','304865','12000000','2018-11-05 13:26:42'), ('0','304885','112000000','2018-11-05 13:26:37'), ('0','304993','112000000','2018-11-05 13:26:27'), ('0','305097','112000000','2018-11-05 13:26:36'), ('0','305125','112000000','2018-11-05 13:26:41'), ('0','305237','112000000','2018-11-05 13:26:39'), ('0','305245','112000000','2018-11-05 13:26:41'), ('0','305257','112000000','2018-11-05 13:26:25'), ('0','305341','112000000','2018-11-05 13:26:41'), ('0','305345','112000000','2018-11-05 13:26:36'), ('0','305437','335000000','2018-11-05 13:26:36'), ('0','305449','335000000','2018-11-05 13:26:26'), ('0','305469','335000000','2018-11-05 13:26:24'), ('0','305545','335000000','2018-11-05 13:26:27'), ('0','305789','335000000','2018-11-05 13:26:38'), ('0','307589','112000000','2018-11-05 13:26:38'), ('0','307625','112000000','2018-11-05 13:26:42'), ('0','307649','112000000','2018-11-05 13:26:40'), ('0','307705','112000000','2018-11-05 13:26:25'), ('0','307937','112000000','2018-11-05 13:26:41'), ('0','307941','112000000','2018-11-05 13:26:45'), ('0','307993','112000000','2018-11-05 13:26:46'), ('0','308069','12000000','2018-11-05 13:26:45'), ('0','308117','12000000','2018-11-05 13:26:37'), ('0','308181','12000000','2018-11-05 13:26:40'), ('0','308213','12000000','2018-11-05 13:26:39'), ('0','308237','12000000','2018-11-05 13:26:39'), ('0','308293','12000000','2018-11-05 13:26:41'), ('0','308305','12000000','2018-11-05 13:26:36'), ('0','308369','12000000','2018-11-05 13:26:28'), ('0','308457','12000000','2018-11-05 13:26:42'), ('0','308509','12000000','2018-11-05 13:26:45'), ('0','308529','12000000','2018-11-05 13:26:43'), ('0','308549','12000000','2018-11-05 13:26:40'), ('0','308605','12000000','2018-11-05 13:26:40'), ('0','308649','12000000','2018-11-05 13:26:37'), ('0','308681','12000000','2018-11-05 13:26:25'), ('0','308685','12000000','2018-11-05 13:26:43'), ('0','308725','12000000','2018-11-05 13:26:44'), ('0','308773','12000000','2018-11-05 13:26:38'), ('0','308829','12000000','2018-11-05 13:26:38'), ('0','308993','1000000000','2018-11-05 13:26:47'), ('0','309025','335000000','2018-11-05 13:26:26'), ('0','309037','335000000','2018-11-05 13:26:26'), ('0','309121','335000000','2018-11-05 13:26:29'), ('0','309221','335000000','2018-11-05 13:26:36'), ('0','309353','335000000','2018-11-05 13:26:35');
INSERT INTO `inventory` VALUES ('320950','182400001','1900','0','0','','0','0','320949','0','0','65535','0','0','182400001','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320952','110300292','1','0','0','','0','0','320949','1','0','8','0','0','110300292','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320953','113300278','1','0','0','','0','0','320949','1','0','4096','0','0','113300278','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320954','160000001','12','0','0','','0','1','320949','0','0','0','0','0','160000001','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320955','169300002','20','0','0','','0','0','320949','0','0','1','0','0','169300002','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320956','162000170','100','0','0','','0','1','320949','0','0','2','0','0','162000170','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('320957','162000171','100','0','0','','0','1','320949','0','0','3','0','0','162000171','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('321027','188055235','1','0','0','','0','1','320949','0','0','4','0','0','188055235','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('323514','152150004','1','0','0','','0','0','320949','0','0','5','0','0','152150004','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('323515','152000401','1','0','0','','0','0','320949','0','0','6','0','0','152000401','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('323516','164002010','19','0','0','','0','1','320949','0','0','7','0','0','164002010','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('323517','164002011','19','0','0','','0','1','320949','0','0','8','0','0','164002011','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('323518','164002057','20','0','0','','0','1','320949','0','0','9','0','0','164002057','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328040','162000066','60','0','0','','0','1','320949','0','0','10','0','0','162000066','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328041','186000236','120','0','0','','0','0','320949','0','0','0','0','0','186000236','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328042','186000242','18','0','0','','0','1','320949','0','0','1','0','0','186000242','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328044','164002302','10','0','0','','0','1','320949','0','0','12','0','0','164002302','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328075','100100012','1','0','0','','0','0','320949','1','0','1','0','0','100100012','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328081','164002300','10','0','0','','0','1','320949','0','0','13','0','0','164002300','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'), ('328085','186000469','2','0','0','','0','0','320949','0','0','2','0','0','186000469','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
INSERT INTO `players` VALUES ('320949','Teste','4','wellijacob','0','0','1212.94','1044.85','140.756','32','210010000','0','FEMALE','ELYOS','PRIEST','2018-11-05 14:59:47',NULL,'2018-11-05 15:28:17','0','0','0','0','-1','-1','0','0','0','0','0','0','0',NULL,'0','0','0','0','0','0','0',NULL,'0','0','NONE','0','0','1',NULL,'NEW','256','0','0','0','2','0','0','0','0','0',NULL);
INSERT INTO `player_appearance` VALUES ('320949','0','9877212','7171548','5395138','8887031','40','74','0','0','0','0','3','1','5395138','7','19','16','34','133','188','25','16','6','100','1','157','189','22','129','188','156','135','8','17','31','130','137','145','4','251','255','247','243','254','0','0','0','0','0','0','1','0','254','0','249','43','25','0','0','0','0','0.969497');
INSERT INTO `player_events_window` VALUES ('4','1','2018-11-05 15:00:15','0','0'), ('4','2','2018-11-05 15:00:15','0','0'), ('4','3','2018-11-05 15:00:15','0','0');
INSERT INTO `player_life_stats` VALUES ('320949','201','375','60');
INSERT INTO `player_luna_shop` VALUES ('320949','1','1','1');
INSERT INTO `player_passports` VALUES ('4','8','1','2018-11-05 15:00:44','1');
INSERT INTO `player_quests` VALUES ('320949','1000','COMPLETE','0','1',NULL,'0','2018-11-05 15:00:37'), ('320949','1001','START','0','0',NULL,'0',NULL), ('320949','1002','START','0','0',NULL,'0',NULL), ('320949','1100','COMPLETE','0','1',NULL,'0','2018-11-05 15:10:31'), ('320949','1101','COMPLETE','0','1',NULL,'0','2018-11-05 15:03:36'), ('320949','1102','COMPLETE','0','1',NULL,'0','2018-11-05 15:05:39'), ('320949','1103','COMPLETE','0','1',NULL,'0','2018-11-05 15:06:43'), ('320949','1104','COMPLETE','0','1',NULL,'0','2018-11-05 15:10:20'), ('320949','1205','COMPLETE','0','1',NULL,'0','2018-11-05 15:10:04');
INSERT INTO `player_shugo_sweep` VALUES ('320949','0','17','1');
INSERT INTO `player_skills` VALUES ('320949','39','1'), ('320949','40','1'), ('320949','41','1'), ('320949','103','1'), ('320949','243','1'), ('320949','245','1'), ('320949','302','1'), ('320949','1614','1'), ('320949','1838','1'), ('320949','4012','1'), ('320949','30001','2');
INSERT INTO `server_variables` VALUES ('auctionProlonged','0'), ('auctionTime','1541945100'), ('houseMaintainTime','1541988000'), ('time','4393');
INSERT INTO `siege_locations` VALUES ('1011','BALAUR','0','1'), ('1014','BALAUR','0','0'), ('1016','BALAUR','0','0'), ('1017','BALAUR','0','0'), ('1018','BALAUR','0','0'), ('1019','BALAUR','0','0'), ('1131','BALAUR','0','1'), ('1132','BALAUR','0','1'), ('1133','BALAUR','0','0'), ('1134','BALAUR','0','0'), ('1135','BALAUR','0','0'), ('1141','BALAUR','0','1'), ('1142','BALAUR','0','0'), ('1143','BALAUR','0','0'), ('1144','BALAUR','0','0'), ('1145','BALAUR','0','0'), ('1146','BALAUR','0','0'), ('1221','BALAUR','0','1'), ('1224','BALAUR','0','0'), ('1231','BALAUR','0','1'), ('1241','BALAUR','0','1'), ('1401','BALAUR','0','0'), ('1402','BALAUR','0','0'), ('1403','BALAUR','0','0'), ('7011','BALAUR','0','2'), ('7012','BALAUR','0','0'), ('7013','BALAUR','0','0'), ('7014','BALAUR','0','0'), ('8021','BALAUR','0','0'), ('8022','BALAUR','0','0'), ('8023','BALAUR','0','0'), ('8024','BALAUR','0','0'), ('9021','BALAUR','0','0'), ('9022','BALAUR','0','0'), ('9023','BALAUR','0','0'), ('9024','BALAUR','0','0'), ('10111','BALAUR','0','0'), ('10211','BALAUR','0','0'), ('10311','BALAUR','0','0'), ('10411','BALAUR','0','0');
INSERT INTO `tasks` VALUES ('1','RESTART','FIXED_IN_TIME','04:20:00','60 5 320');
INSERT INTO `towns` VALUES ('1001','1','0','ELYOS','1970-01-01 07:00:01'), ('1002','1','0','ELYOS','1970-01-01 07:00:01'), ('1003','1','0','ELYOS','1970-01-01 07:00:01'), ('1004','1','0','ELYOS','1970-01-01 07:00:01'), ('1005','1','0','ELYOS','1970-01-01 07:00:01'), ('1006','1','0','ELYOS','1970-01-01 07:00:01'), ('1007','1','0','ELYOS','1970-01-01 07:00:01'), ('1008','1','0','ELYOS','1970-01-01 07:00:01'), ('1009','1','0','ELYOS','1970-01-01 07:00:01'), ('1010','1','0','ELYOS','1970-01-01 07:00:01'), ('1011','1','0','ELYOS','1970-01-01 07:00:01'), ('1012','1','0','ELYOS','1970-01-01 07:00:01'), ('1013','1','0','ELYOS','1970-01-01 07:00:01'), ('1014','1','0','ELYOS','1970-01-01 07:00:01'), ('1015','1','0','ELYOS','1970-01-01 07:00:01'), ('1016','1','0','ELYOS','1970-01-01 07:00:01'), ('1017','1','0','ELYOS','1970-01-01 07:00:01'), ('1018','1','0','ELYOS','1970-01-01 07:00:01'), ('1019','1','0','ELYOS','1970-01-01 07:00:01'), ('1020','1','0','ELYOS','1970-01-01 07:00:01'), ('1021','1','0','ELYOS','1970-01-01 07:00:01'), ('1022','1','0','ELYOS','1970-01-01 07:00:01'), ('1023','1','0','ELYOS','1970-01-01 07:00:01'), ('1024','1','0','ELYOS','1970-01-01 07:00:01'), ('1025','1','0','ELYOS','1970-01-01 07:00:01'), ('2001','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2002','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2003','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2004','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2005','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2006','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2007','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2008','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2009','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2010','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2011','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2012','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2013','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2014','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2015','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2016','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2017','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2018','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2019','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2020','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2021','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2022','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2023','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2024','1','0','ASMODIANS','1970-01-01 07:00:01'), ('2025','1','0','ASMODIANS','1970-01-01 07:00:01');
