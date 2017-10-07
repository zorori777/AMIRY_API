-- This is just a blueprint of all tables used in this project.
-- Tables are created by migration files, not sql statments in this file.
-- Keeping the policy that this create_table.sql file should be up to date.

CREATE TABLE `users`(
  `id`            BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name`    VARCHAR(64)          NOT NULL DEFAULT '',
  `last_name`     VARCHAR(64)          NOT NULL DEFAULT '',
  `avatar`        VARCHAR(64) UNSIGNED NOT NULL DEFAULT '',
  `band_id`       BIGINT(20)  UNSIGNED NOT NULL DEFAULT '',
  `bands_count`   BIGINT(20)  UNSIGNED NOT NULL DEFAULT '0',
  `university_id` BIGINT(20)  UNSIGNED NOT NULL,
  PRIMARY KEY(`id`),
  CONSTRAINT `fk_users_on_band_id` FOREIGN KEY(`band_id`) REFERENCES `bands` (`id`) ON UPDATE CASCADE
  CONSTRAINT `fk_lives_on_university_id` FOREIGN KEY(`university_id`) REFERENCES `universities` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- パートのマスタテーブル
CREATE TABLE `parts`(
  `id`         BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(64)          NOT NULL DEFAULT '',
  `user_id`    BIGINT(20)  UNSIGNED NOT NULL,
  `created_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP           
  PRIMARY KEY(`id`),
  CONSTRAINT `user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_parts`(
  `id`      BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) UNSIGNED NOT NULL, 
  `part_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY(`id`),
  CONSTRAINT `user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
  CONSTRAINT `part_id` FOREIGN KEY(`part_id`) REFERENCES `parts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `lives`(
  `id`                 BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`               VARCHAR(64)          NOT NULL DEFAULT ''
  `max_capacity`       BIGINT(20)  UNSIGNED NOT NULL DEFAULT '0',
  `reservations_count` BIGINT(20)  UNSIGNED NOT NULL DEFAULT '0',
  `university_id`      BIGINT(20)  UNSIGNED NOT NULL DEFAULT '0',
  `type`               TINYINT(3)  UNSIGNED NOT NULL DEFAULT '0',               COMMENT 'サークルライブ以外: 0, サークルライブ: 1'
  `hold_at`            DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP
  `created_at`         DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`         DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP           
  PRIMARY KEY(`id`),
  KEY(`university_id`, `type`),
  KEY(`hold_at`),
  CONSTRAINT `fk_lives_on_university_id` FOREIGN KEY(`university_id`) REFERENCES `universities` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `reservations` (
  `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    BIGINT(20) UNSIGNED NOT NULL,
  `live_id`    BIGINT(20) UNSIGNED NOT NULL,
  `created_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  KEY(`user_id`),
  KEY(`live_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bands`(
  `id`            BIGINT(20)  UNSIGNED NOT NULL,
  `name`          VARCHAR(20)          NOT NULL DEFAULT '',
  `concept`       VARCHAR(64)          NOT NULL DEFAULT '',
  `description`   TEXT                 NOT NULL,
  `people_num`    BIGINT(64)           NOT NULL DEFAULT '0',
  `type`          TINYINT(3)  UNSIGNED NOT NULL DEFAULT '0', 
  `university_id` BIGINT(20)  UNSIGNED NOT NULL DEFAULT '0',               COMMENT 'インカレなら、0',
  `united_at`     DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  `created_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP           
  PRIMARY KEY(`id`),
  UNIQUE KEY(`university_id`, `name`),
  CONSTRAINT `fk_lives_on_university_id` FOREIGN KEY(`university_id`) REFERENCES `universities` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `band_images` (
  `id`         BIGINT(20)  UNSIGNED NOT NULL,
  `band_id`    BIGINT(20)  UNSIGNED NOT NULL, 
  `name`       VARCHAR(20)          NOT NULL DEFAULT '',
  `created_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  KEY(`band_id`),
  CONSTRAINT `fk_lives_on_band_id` FOREIGN KEY(`band_id`) REFERENCES `bands` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_bands`(
  `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    BIGINT(20) UNSIGNED NOT NULL, 
  `band_id`    BIGINT(20) UNSIGNED NOT NULL,
  `created_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP           
  PRIMARY KEY(`id`),
  CONSTRAINT `fk_user_bands_on_user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE, 
  CONSTRAINT `fk_user_bands_on_band_id` FOREIGN KEY(`band_id`) REFERENCES `bands` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `universities` (
  `id`         BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(64)          NOT NULL DEFAULT '',
  `created_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,    
  PRIMARY KEY(`id`),    
  UNIQUE KEY(`name`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `circles` (
  `id`            BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `university_id` BIGINT(20)  UNSIGNED NOT NULL,
  `name`          VARCHAR(64)          NOT NULL DEFAULT '',
  `logo`          VARCHAR(64)          NOT NULL DEFAULT '',
  `members_count` BIGINT(20)  UNSIGNED NOT NULL DEFAULT 0,
  `bands_count`   BIGINT(20)  UNSIGNED NOT NULL DEFAULT 0,
  `created_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,    
  PRIMARY KEY(`id`),
  UNIQUE KEY(`name`, `university_id`),
  CONSTRAINT `fk_circles_on_university_id` FOREIGN KEY(`university_id`) REFERENCES `universities` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `circle_images`(
  `id`         BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `circle_id`  BIGINT(20)  UNSIGNED NOT NULL,
  `name`       VARCHAR(64)          NOT NULL DEFAULT '',
  `created_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,    
  PRIMARY KEY(`id`),
  CONSTRAINT `fk_lives_on_circle_id` FOREIGN KEY(`circle_id`) REFERENCES `circles` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
CREATE TABLE `user_circles`(
  `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`    BIGINT(20) UNSIGNED NOT NULL,
  `circle_id`  BIGINT(20) UNSIGNED NOT NULL, 
  `created_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(`id`),
  UNIQUE KEY(`user_id`, `circle_id`),
  CONSTRAINT `fk_user_circles_on_user_id` FOREIGN KEY(`user_id`)   REFERENCES `users`   (`id`) ON UPDATE CASCADE, 
  CONSTRAINT `fk_user_circles_on_band_id` FOREIGN KEY(`circle_id`) REFERENCES `circles` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `events` (
  `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(64)         NOT NULL DEFAULT '',
  `description` TEXT                NOT NULL,
  `user_id`     BIGINT(20) UNSIGNED NOT NULL, 
  `hold_at`     DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at`  DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(`id`),
  KEY(`hold_at`),
  CONSTRAINT `fk_events_on_user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lectures` (
  `id`          BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,  
  `description` TEXT                 NOT NULL,
  `address`     VARCHAR(64)          NOT NULL DEFAULT '',
  `hold_at`     DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at`  DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(`id`),
  KEY(`hold_at`),
  CONSTRAINT `fk_lectures_on_user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `articles` (
  `id`         BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,  
  `user_id`    BIGINT(20) UNSIGNED NOT NULL,  
  `content`    TEXT                NOT NULL,
  `created_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(`id`),
  KEY(`created_at`),
  CONSTRAINT `fk_user_circles_on_user_id` FOREIGN KEY(`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `article_comments` (
  `id`         BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,  
  `user_id`    BIGINT(20)  UNSIGNED NOT NULL,
  `article_id` BIGINT(20)  UNSIGNED NOT NULL,
  `content`    VARCHAR(64)          NOT NULL DEFAULT '',
  `created_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY(`id`), 
  CONSTRAINT `fk_article_comments_on_user_id`    FOREIGN KEY(`user_id`)    REFERENCES `users` (`id`)    ON UPDATE CASCADE ON DELETE CASCADE, 
  CONSTRAINT `fk_article_comments_on_article_id` FOREIGN KEY(`article_id`) REFERENCES `articles` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `messages`(
  `id`            BIGINT(20)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `body`          VARCHAR(64)          NOT NULL
  `user_id`       BIGINT(20)  UNSIGNED NOT NULL,
  `created_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  CONSTRAINT `fk_messages_on_user_id`       FOREIGN KEY(`user_id`)       REFERENCES `users`       (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_messages`(
  `id`           BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id`    BIGINT(20) UNSIGNED NOT NULL,
  `recipient_id` BIGINT(20) UNSIGNED NOT NULL, 
  `message_id`   BIGINT(20) UNSIGNED NOT NULL,
  `created_at`   DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  CONSTRAINT `fk_user_messages_on_sender_id`    FOREIGN KEY(`sender_id`)    REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
  CONSTRAINT `fk_user_messages_on_recipient_id` FOREIGN KEY(`recipient_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `likes` (
  `id`           BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id`    BIGINT(20) UNSIGNED NOT NULL
  `recipient_id` BIGINT(20) UNSIGNED NOT NULL
  `created_at`   DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  UNIQUE KEY(`user_id`, `chat_group_id`), 
  CONSTRAINT `fk_user_messages_on_sender_id`    FOREIGN KEY(`sender_id`)    REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
  CONSTRAINT `fk_user_messages_on_recipient_id` FOREIGN KEY(`recipient_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `taggings_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tags_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `tagger_type` varchar(255) DEFAULT NULL,
  `tagger_id` int(11) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggings_idx` (`tag_id`,`taggable_id`,`taggable_type`,`context`,`tagger_id`,`tagger_type`),
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id` (`taggable_id`),
  KEY `index_taggings_on_taggable_type` (`taggable_type`),
  KEY `index_taggings_on_tagger_id` (`tagger_id`),
  KEY `index_taggings_on_context` (`context`),
  KEY `index_taggings_on_tagger_id_and_tagger_type` (`tagger_id`,`tagger_type`),
  KEY `taggings_idy` (`taggable_id`,`taggable_type`,`tagger_id`,`context`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8
