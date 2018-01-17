-- Create syntax for TABLE 'deposit'
CREATE TABLE `deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tx` varchar(128) NOT NULL DEFAULT '',
  `from_wallet` varchar(128) NOT NULL,
  `to_wallet` varchar(128) NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `real_amount` decimal(20,8) DEFAULT NULL,
  `fee` decimal(20,8) DEFAULT NULL,
  `destination_tag` bigint(20) NOT NULL,
  `user` varchar(50) NOT NULL,
  `ledger` bigint(20) NOT NULL,
  `balance_pre` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `balance_post` decimal(20,8) NOT NULL DEFAULT '0.00000000',
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
  KEY `real_amount` (`real_amount`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'message'
CREATE TABLE `message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `network` enum('reddit') NOT NULL DEFAULT 'reddit',
  `ext_id` varchar(64) DEFAULT NULL,
  `parent_id` varchar(64) DEFAULT NULL,
  `parent_author` varchar(64) DEFAULT NULL,
  `type` enum('pb','mention') NOT NULL DEFAULT 'mention',
  `from_user` varchar(64) DEFAULT NULL,
  `to_user` varchar(64) DEFAULT NULL,
  `subject` varchar(128) DEFAULT NULL,
  `message` text,
  `processed` int(1) NOT NULL DEFAULT '0',
  `processed_moment` timestamp NULL DEFAULT NULL,
  `action` enum('passthru','transaction','reaction') DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=548 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'tip'
CREATE TABLE `tip` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(20,8) NOT NULL,
  `from_user` varchar(50) NOT NULL DEFAULT '',
  `to_user` varchar(50) NOT NULL DEFAULT '',
  `reddit_post` int(11) unsigned DEFAULT NULL,
  `sender_balance` decimal(20,8) NOT NULL,
  `recipient_balance` decimal(20,8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reddit_post` (`reddit_post`),
  KEY `moment` (`moment`),
  KEY `amount` (`amount`),
  KEY `from` (`from_user`),
  KEY `from_balance` (`sender_balance`),
  KEY `to` (`to_user`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'transaction'
CREATE TABLE `transaction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL DEFAULT '',
  `ledger` bigint(20) NOT NULL,
  `from` varchar(64) NOT NULL DEFAULT '',
  `to` varchar(64) NOT NULL DEFAULT '',
  `xrp` decimal(20,8) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=180092 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'user'
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `last_login` timestamp NULL DEFAULT NULL,
  `tipbot_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_reason` enum('LOGIN','TIPPED') DEFAULT NULL,
  `balance` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `destination_tag` bigint(20) NOT NULL AUTO_INCREMENT,
  `destination_wallet` varchar(64) NOT NULL DEFAULT 'rPEPPER7kfTD9w2To4CQk6UCfuHM9c6GDY',
  `network` enum('reddit') NOT NULL DEFAULT 'reddit',
  PRIMARY KEY (`username`),
  KEY `last_login` (`last_login`),
  KEY `tipbot_created` (`tipbot_created`),
  KEY `create_reason` (`create_reason`),
  KEY `balance` (`balance`),
  KEY `destination_tag` (`destination_tag`),
  KEY `destination_wallet` (`destination_wallet`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=utf8mb4;

-- Create syntax for TABLE 'withdraw'
CREATE TABLE `withdraw` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `moment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(50) NOT NULL,
  `from_wallet` varchar(128) NOT NULL,
  `to_wallet` varchar(128) NOT NULL,
  `destination_tag` bigint(20) NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `fee` decimal(20,0) DEFAULT NULL,
  `tx` varchar(128) DEFAULT NULL,
  `ledger` bigint(20) NOT NULL,
  `processed` timestamp NULL DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `donate` decimal(20,8) DEFAULT NULL,
  `log` longtext,
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
  KEY `fee` (`fee`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
