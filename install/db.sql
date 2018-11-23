-- Create syntax for TABLE 'deposit'
CREATE TABLE `deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tx` varchar(128) NOT NULL DEFAULT '',
  `from_wallet` varchar(128) NOT NULL,
  `to_wallet` varchar(128) NOT NULL,
  `amount` decimal(20,6) NOT NULL,
  `real_amount` decimal(20,6) DEFAULT NULL,
  `fee` decimal(20,6) DEFAULT NULL,
  `destination_tag` bigint(20) NOT NULL,
  `user` varchar(50) NOT NULL,
  `ledger` bigint(20) NOT NULL,
  `balance_pre` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `balance_post` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `network` enum('reddit','twitter','discord','internal') NOT NULL DEFAULT 'reddit',
  `type` enum('tx','escrow') NOT NULL DEFAULT 'tx',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx_2` (`tx`),
  KEY `moment` (`moment`),
  KEY `tx` (`tx`),
  KEY `from_wallet` (`from_wallet`),
  KEY `to_wallet` (`to_wallet`),
  KEY `amount` (`amount`),
  KEY `destination_tag` (`destination_tag`),
  KEY `user` (`user`),
  KEY `ledger` (`ledger`),
  KEY `pre_balance` (`balance_pre`),
  KEY `new_balance` (`balance_post`),
  KEY `fee` (`fee`),
  KEY `real_amount` (`real_amount`),
  KEY `network` (`network`),
  KEY `type` (`type`),
  KEY `network_2` (`network`,`user`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'escrow'
CREATE TABLE `escrow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('create','finish') NOT NULL DEFAULT 'create',
  `hash` varchar(128) NOT NULL DEFAULT '',
  `ledger` bigint(20) NOT NULL,
  `from` varchar(64) DEFAULT '',
  `to` varchar(64) DEFAULT NULL,
  `xrp` decimal(20,6) DEFAULT NULL,
  `tag` bigint(20) DEFAULT NULL,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sequence` bigint(20) NOT NULL,
  `offer` bigint(20) DEFAULT NULL,
  `date` bigint(20) DEFAULT NULL,
  `cancel` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_2` (`hash`),
  KEY `type` (`type`),
  KEY `hash` (`hash`),
  KEY `ledger` (`ledger`),
  KEY `from` (`from`),
  KEY `to` (`to`),
  KEY `xrp` (`xrp`),
  KEY `tag` (`tag`),
  KEY `moment` (`moment`),
  KEY `sequence` (`sequence`),
  KEY `date` (`date`),
  KEY `cancel` (`cancel`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'ilp_deposits'
CREATE TABLE `ilp_deposits` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `connectionTag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `drops` int(10) unsigned NOT NULL,
  `fee` int(10) unsigned NOT NULL,
  `network` enum('twitter','reddit','discord','internal') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `user_destination_tag` bigint(20) DEFAULT NULL,
  `strata_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `strata_id` (`strata_id`),
  KEY `moment` (`moment`),
  KEY `connectionTag` (`connectionTag`),
  KEY `drops` (`drops`),
  KEY `network` (`network`),
  KEY `fee` (`fee`),
  KEY `user` (`user`),
  KEY `user_destination_tag` (`user_destination_tag`),
  KEY `user_2` (`user`,`network`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'message'
CREATE TABLE `message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `network` enum('reddit','twitter','discord','internal') NOT NULL DEFAULT 'reddit',
  `ext_id` varchar(64) DEFAULT NULL,
  `parent_id` varchar(64) DEFAULT NULL,
  `parent_author` varchar(64) DEFAULT NULL,
  `type` enum('pb','mention','sr_reaction') NOT NULL DEFAULT 'mention',
  `from_user` varchar(64) DEFAULT NULL,
  `to_user` varchar(64) DEFAULT NULL,
  `subject` varchar(128) DEFAULT NULL,
  `message` text,
  `processed` int(1) NOT NULL DEFAULT '0',
  `processed_moment` timestamp NULL DEFAULT NULL,
  `action` enum('passthru','transaction','reaction','ignore') DEFAULT NULL,
  `reaction` text,
  `context` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ext_id_2` (`ext_id`,`network`,`from_user`,`to_user`),
  KEY `moment` (`moment`),
  KEY `network` (`network`),
  KEY `type` (`type`),
  KEY `from` (`from_user`),
  KEY `to` (`to_user`),
  KEY `processed` (`processed`),
  KEY `processed_moment` (`processed_moment`),
  KEY `action` (`action`),
  KEY `ext_Id` (`ext_id`),
  KEY `parent_id` (`parent_id`),
  KEY `parent_author` (`parent_author`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'reddit_comments'
CREATE TABLE `reddit_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subreddit` varchar(50) NOT NULL DEFAULT '',
  `last_id` varchar(50) NOT NULL DEFAULT '',
  `last_moment` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `seen` int(10) unsigned NOT NULL,
  `matched` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subreddit` (`subreddit`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'tip'
CREATE TABLE `tip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(20,6) NOT NULL,
  `from_user` varchar(50) NOT NULL DEFAULT '',
  `to_user` varchar(50) NOT NULL DEFAULT '',
  `message` int(11) unsigned DEFAULT NULL,
  `sender_balance` decimal(20,6) NOT NULL,
  `recipient_balance` decimal(20,6) DEFAULT NULL,
  `network` enum('reddit','twitter','discord','btn','app') NOT NULL DEFAULT 'reddit',
  `context` varchar(100) DEFAULT NULL,
  `from_network` enum('reddit','twitter','discord','internal') DEFAULT NULL,
  `to_network` enum('reddit','twitter','discord','internal') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reddit_post` (`message`),
  UNIQUE KEY `message` (`message`),
  KEY `moment` (`moment`),
  KEY `amount` (`amount`),
  KEY `from` (`from_user`),
  KEY `to` (`to_user`),
  KEY `network` (`network`),
  KEY `context` (`context`),
  KEY `from_network` (`from_network`),
  KEY `to_network` (`to_network`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'transaction'
CREATE TABLE `transaction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL DEFAULT '',
  `ledger` bigint(20) NOT NULL,
  `from` varchar(64) NOT NULL DEFAULT '',
  `to` varchar(64) NOT NULL DEFAULT '',
  `xrp` decimal(20,6) NOT NULL,
  `tag` bigint(20) NOT NULL,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash_2` (`hash`),
  KEY `hash` (`hash`),
  KEY `ledger` (`ledger`),
  KEY `from` (`from`),
  KEY `to` (`to`),
  KEY `xrp` (`xrp`),
  KEY `tag` (`tag`),
  KEY `moment` (`moment`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'user'
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `userid` varchar(200) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `tipbot_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_reason` enum('LOGIN','TIPPED','ILPDEPOSIT') DEFAULT NULL,
  `balance` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `destination_tag` bigint(20) NOT NULL AUTO_INCREMENT,
  `destination_wallet` varchar(64) NOT NULL DEFAULT 'rPEPPER7kfTD9w2To4CQk6UCfuHM9c6GDY',
  `network` enum('reddit','twitter','discord','internal') NOT NULL DEFAULT 'reddit',
  `rejecttips` timestamp NULL DEFAULT NULL,
  `disablenotifications` int(1) unsigned NOT NULL DEFAULT '0',
  `public_destination_tag` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`username`,`network`),
  UNIQUE KEY `public_destination_tag_2` (`public_destination_tag`),
  KEY `last_login` (`last_login`),
  KEY `tipbot_created` (`tipbot_created`),
  KEY `create_reason` (`create_reason`),
  KEY `balance` (`balance`),
  KEY `destination_tag` (`destination_tag`),
  KEY `destination_wallet` (`destination_wallet`),
  KEY `network` (`network`),
  KEY `userid` (`userid`(191)),
  KEY `public_destination_tag` (`public_destination_tag`),
  KEY `rejecttips` (`rejecttips`),
  KEY `disablenotifications` (`disablenotifications`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for VIEW 'v_withdraw_error'
CREATE ALGORITHM=UNDEFINED DEFINER=`newuser`@`%` SQL SECURITY DEFINER VIEW `v_withdraw_error`
AS SELECT
   `withdraw`.`id` AS `id`,
   `withdraw`.`moment` AS `moment`,
   `withdraw`.`user` AS `user`,
   `withdraw`.`from_wallet` AS `from_wallet`,
   `withdraw`.`to_wallet` AS `to_wallet`,
   `withdraw`.`destination_tag` AS `destination_tag`,
   `withdraw`.`amount` AS `amount`,
   `withdraw`.`fee` AS `fee`,
   `withdraw`.`tx` AS `tx`,
   `withdraw`.`ledger` AS `ledger`,
   `withdraw`.`processed` AS `processed`,
   `withdraw`.`ip` AS `ip`,
   `withdraw`.`donate` AS `donate`,
   `withdraw`.`log` AS `log`
FROM `withdraw` where ((isnull(`withdraw`.`fee`) or (`withdraw`.`fee` < 10)) and (`withdraw`.`processed` is not null)) order by `withdraw`.`id` desc;

-- Create syntax for TABLE 'withdraw'
CREATE TABLE `withdraw` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(50) NOT NULL,
  `from_wallet` varchar(128) NOT NULL,
  `to_wallet` varchar(128) NOT NULL,
  `destination_tag` bigint(20) NOT NULL,
  `source_tag` bigint(20) DEFAULT NULL,
  `amount` decimal(20,6) NOT NULL,
  `fee` decimal(20,0) DEFAULT NULL,
  `tx` varchar(128) DEFAULT NULL,
  `ledger` bigint(20) NOT NULL,
  `processed` timestamp NULL DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `donate` decimal(20,6) DEFAULT NULL,
  `log` longtext,
  `network` enum('reddit','twitter','discord','internal') NOT NULL DEFAULT 'reddit',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `escrowts` int(10) unsigned DEFAULT NULL,
  `escrow_release_hash` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx_2` (`tx`),
  KEY `moment` (`moment`),
  KEY `tx` (`tx`),
  KEY `from_wallet` (`from_wallet`),
  KEY `to_wallet` (`to_wallet`),
  KEY `amount` (`amount`),
  KEY `destination_tag` (`destination_tag`),
  KEY `user` (`user`),
  KEY `ledger` (`ledger`),
  KEY `processed` (`processed`),
  KEY `ip` (`ip`),
  KEY `donate` (`donate`),
  KEY `fee` (`fee`),
  KEY `network` (`network`),
  KEY `user_2` (`user`,`network`),
  KEY `escrowts` (`escrowts`),
  KEY `escrow_release_hash` (`escrow_release_hash`),
  KEY `escrow_release_hash_2` (`escrow_release_hash`,`escrowts`,`ledger`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Create syntax for FUNCTION 'levenshtein'
CREATE DEFINER=`newuser`@`%` FUNCTION `levenshtein`( s1 VARCHAR(255), s2 VARCHAR(255) ) RETURNS int(11)
    DETERMINISTIC
BEGIN
        DECLARE s1_len, s2_len, i, j, c, c_temp, cost INT;
        DECLARE s1_char CHAR;
        -- max strlen=255
        DECLARE cv0, cv1 VARBINARY(256);

        SET s1_len = CHAR_LENGTH(s1), s2_len = CHAR_LENGTH(s2), cv1 = 0x00, j = 1, i = 1, c = 0;

        IF s1 = s2 THEN
            RETURN 0;
        ELSEIF s1_len = 0 THEN
            RETURN s2_len;
        ELSEIF s2_len = 0 THEN
            RETURN s1_len;
        ELSE
            WHILE j <= s2_len DO
                SET cv1 = CONCAT(cv1, UNHEX(HEX(j))), j = j + 1;
            END WHILE;
            WHILE i <= s1_len DO
                SET s1_char = SUBSTRING(s1, i, 1), c = i, cv0 = UNHEX(HEX(i)), j = 1;
                WHILE j <= s2_len DO
                    SET c = c + 1;
                    IF s1_char = SUBSTRING(s2, j, 1) THEN
                        SET cost = 0; ELSE SET cost = 1;
                    END IF;
                    SET c_temp = CONV(HEX(SUBSTRING(cv1, j, 1)), 16, 10) + cost;
                    IF c > c_temp THEN SET c = c_temp; END IF;
                    SET c_temp = CONV(HEX(SUBSTRING(cv1, j+1, 1)), 16, 10) + 1;
                    IF c > c_temp THEN
                        SET c = c_temp;
                    END IF;
                    SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;
                END WHILE;
                SET cv1 = cv0, i = i + 1;
            END WHILE;
        END IF;
        RETURN c;
    END;