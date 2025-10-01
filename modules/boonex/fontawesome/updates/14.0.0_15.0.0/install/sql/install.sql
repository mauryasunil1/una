-- ICONSET
DELETE FROM `sys_objects_iconset` WHERE `object`='bx_fontawesome';
INSERT INTO `sys_objects_iconset` (`object`, `title`, `override_class_name`, `override_class_file`) VALUES
('bx_fontawesome', 'Font Awesome Pro', 'BxFontAwesomeIconset', 'modules/boonex/fontawesome/classes/BxFontAwesomeIconset.php');
