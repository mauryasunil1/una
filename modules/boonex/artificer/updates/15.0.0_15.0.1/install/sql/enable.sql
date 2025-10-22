SET @sName = 'bx_artificer';


-- PRELOADER
DELETE FROM `sys_preloader` WHERE `module`='bx_artificer' AND `type`='js_system' AND `content`='modules/boonex/artificer/js/|sidebar.js';
