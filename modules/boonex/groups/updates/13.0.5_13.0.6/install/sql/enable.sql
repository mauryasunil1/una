-- GRIDS
UPDATE `sys_objects_grid` SET `source`='SELECT `bx_groups_invites`.`id`, `bx_groups_invites`.`invited_profile_id`, `bx_groups_invites`.`added`, `bx_groups_invites`.`author_profile_id` FROM `bx_groups_invites` INNER JOIN `sys_profiles` AS `p` ON `bx_groups_invites`.`invited_profile_id` = `p`.`id` INNER JOIN `sys_accounts` AS `a` ON (`a`.`id` = `p`.`account_id`) ' WHERE `object`='bx_groups_invites';
