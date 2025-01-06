-- Script to create the player_exp_rates table into acore_characters
-- This table stores individual experience rates for each player.

CREATE TABLE IF NOT EXISTS `player_exp_rates` (
    `player_guid` INT UNSIGNED NOT NULL COMMENT 'Player GUID (unique identifier)',
    `rate` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Experience rate multiplier (1 to 5)',
    PRIMARY KEY (`player_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores custom experience rates for players';
