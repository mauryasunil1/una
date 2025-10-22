SET @sName = 'bx_organizations';


-- MENUS
UPDATE `sys_menu_items` SET `link`='page.php?i=organization-profile-friends' WHERE `set_name`='sys_account_notifications' AND `module`=@sName AND `name`='notifications-friend-requests';
UPDATE `sys_menu_items` SET `link`='page.php?i=organization-profile-relations' WHERE `set_name`='sys_account_notifications' AND `module`=@sName AND `name`='notifications-relation-requests';
