SET @sName = 'bx_protean';


-- SETTINGS:
UPDATE `sys_options` SET `value`='16px' WHERE `name`=CONCAT(@sName, '_font_size_default');
UPDATE `sys_options` SET `value`='14px' WHERE `name`=CONCAT(@sName, '_font_size_middle');
UPDATE `sys_options` SET `value`='20px' WHERE `name`=CONCAT(@sName, '_font_size_large');
UPDATE `sys_options` SET `value`='28px' WHERE `name`=CONCAT(@sName, '_font_size_h2');
UPDATE `sys_options` SET `value`='24px' WHERE `name`=CONCAT(@sName, '_font_size_h3');


-- MIXES
SET @iMixId = (SELECT `id` FROM `sys_options_mixes` WHERE `type`=@sName AND `name`='Neat-Mix' LIMIT 1);

UPDATE `sys_options_mixes2options` SET `value`='16px' WHERE `option`='bx_protean_font_size_default' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='20px' WHERE `option`='bx_protean_font_size_large' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='28px' WHERE `option`='bx_protean_font_size_h2' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='24px' WHERE `option`='bx_protean_font_size_h3' AND `mix_id`=@iMixId;

SET @iMixId = (SELECT `id` FROM `sys_options_mixes` WHERE `type`=@sName AND `name`='Protean-Light-Mix' LIMIT 1);

UPDATE `sys_options_mixes2options` SET `value`='16px' WHERE `option`='bx_protean_font_size_default' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='32px' WHERE `option`='bx_protean_font_size_h1' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='28px' WHERE `option`='bx_protean_font_size_h2' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='24px' WHERE `option`='bx_protean_font_size_h3' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='20px' WHERE `option`='bx_protean_font_size_large' AND `mix_id`=@iMixId;

SET @iMixId = (SELECT `id` FROM `sys_options_mixes` WHERE `type`=@sName AND `name`='Protean-Dark-Mix' LIMIT 1);

UPDATE `sys_options_mixes2options` SET `value`='rgba(255, 255, 255, 0.1)' WHERE `option`='bx_protean_button_lg_border_color' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='rgba(255, 255, 255, 0.2)' WHERE `option`='bx_protean_button_lg_border_color_hover' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='rgba(255, 255, 255, 0.1)' WHERE `option`='bx_protean_button_sm_border_color' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='rgba(255, 255, 255, 0.2)' WHERE `option`='bx_protean_button_sm_border_color_hover' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='16px' WHERE `option`='bx_protean_font_size_default' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='32px' WHERE `option`='bx_protean_font_size_h1' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='28px' WHERE `option`='bx_protean_font_size_h2' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='24px' WHERE `option`='bx_protean_font_size_h3' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='20px' WHERE `option`='bx_protean_font_size_large' AND `mix_id`=@iMixId;
UPDATE `sys_options_mixes2options` SET `value`='div.bx-base-pofile-cover {\r\nborder: 1px solid rgba(136, 153, 170, 0.3);\r\nborder-bottom-width: 0;\r\n}\r\n\r\n\r\ndiv.bx-market-unit-cover div.bx-base-text-unit-no-thumb {\r\nborder-width: 0px;\r\n}\r\n\r\n.sys-cpf-header,\r\n.sys-cpf-title,\r\n.sys-cpf-submenu-cnt ul li {\r\nborder-bottom-color: rgba(136, 153, 170, 0.3);\r\n}\r\n\r\n.sys-cpf-submenu-cnt ul li.bx-menu-inter-act {\r\nborder-bottom-color: rgb(17, 34, 51);\r\n}\r\n\r\n.bx-def-hr, \r\n.bx-def-hr-auto {\r\nborder-color: rgba(255, 255, 255, 0.1);\r\n}\r\n\r\n.bx-def-font {\r\nline-height:18px;\r\nline-height:1.125rem;\r\n}\r\nh1,\r\n.bx-def-font-h1 {\r\nline-height:36px;\r\nline-height:2.25rem;\r\n}\r\nh2,\r\n.bx-def-font-h2 {\r\nline-height:27px;\r\nline-height:1.6875rem;\r\n}\r\nh3,\r\n.bx-def-font-h3 {\r\nline-height:20.25px;\r\nline-height:1.265625rem;\r\n}\r\n\r\n.bx-def-label {\r\nbackground-color: rgba(245, 250, 255, 0.5);\r\n}\r\n.bx-def-label,\r\n.bx-def-label a,\r\n.bx-def-label .sys-icon {\r\ncolor: rgba(51, 68, 85, 1);\r\n}\r\n\r\n#bx-popup-fog {\r\nbackground-color: rgba(0, 0, 0) !important;\r\n}\r\n\r\n/*--- Informers ---*/\r\n.bx-informer-msg-info {\r\nbackground-color: rgba(60, 164, 85, 1.0);\r\n}\r\n.bx-informer-msg-alert {\r\nbackground-color: rgba(230, 115, 55, 1.0);\r\n}\r\n.bx-informer-msg-error {\r\nbackground-color: rgba(200, 64, 64, 1.0);\r\n}\r\n\r\n\r\n/*--- Menus ---*/\r\n.bx-menu-notif li.bx-menu-tab-active a, \r\n.bx-menu-verlit li.bx-menu-tab-active a, \r\n.bx-menu-ver li.bx-menu-tab-active a,\r\n.bx-menu-hor li.bx-menu-tab-active a {\r\ncolor: rgba(252, 253, 254, 1);\r\n}\r\n\r\n/*--- Forms ---*/\r\n.bx-form-value .bx-form-input-autotoken b {\r\ncolor: rgba(243, 244, 245, 1);\r\n}\r\n.bx-form-value .select2-container--default .select2-selection--multiple {\r\nbackground-color: rgba(17, 34, 51, 1);\r\nborder-color: rgba(17, 34, 51, 1);\r\n}\r\n.bx-form-value .select2-container--default .select2-selection--multiple .select2-selection__choice {\r\nbackground-color: rgba(51, 68, 85, 1);\r\nborder-color: rgba(68, 136, 255, 1);\r\n}\r\n.bx-form-value .select2-container--default .select2-selection--multiple .select2-selection__choice__remove,\r\n.bx-form-value .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {\r\ncolor:  rgba(243, 244, 245, 1);\r\n}\r\n.select2-container .select2-dropdown  {\r\nbackground-color: rgba(17, 34, 51, 1);\r\nborder-color: rgba(17, 34, 51, 1);\r\n}\r\n.s2-to-tree.select2-container li.select2-results__option[aria-selected="true"] > span.item-label {\r\nbackground-color: rgba(34, 51, 68, 1);\r\n}\r\n.bx-popup .dropzone {\r\nbackground-color: rgba(17, 34, 51, 1);\r\n}\r\n\r\n/*--- Timeline ---*/\r\ndiv.bx-tl-view-timeline div.bx-tl-items:before,\r\ndiv.bx-tl-view-timeline div.bx-tl-item-circle {\r\nbackground-color: rgba(51, 68, 85, 1);\r\n}\r\ndiv.bx-tl-il-embed {\r\npadding: 0.5rem;\r\nbackground-color: rgba(255, 255, 255, 0.8);\r\nborder-radius:  5px;\r\n}\r\ndiv.bx-tl-item div.bx-tl-item-activity .bx-menu-custom li .sys-action-counter-icon,\r\ndiv.bx-tl-item div.bx-tl-item-activity .bx-menu-custom li .sys-action-do-icon, \r\ndiv.bx-tl-item div.bx-tl-item-activity .bx-menu-custom li .bx-menu-item-icon {\r\nbackground-color: rgba(51, 68, 85, 1) !important;\r\nborder: 1px solid rgba(255, 255, 255, 0.1)  !important;\r\n}\r\ndiv.bx-tl-item div.bx-tl-item-activity .bx-menu-custom li a:hover .sys-action-do-icon, \r\ndiv.bx-tl-item div.bx-tl-item-activity .bx-menu-custom li a:hover .bx-menu-item-icon {\r\nbackground-color: rgba(51, 68, 85, 0.8);\r\nborder: 1px solid rgba(255, 255, 255, 0.2);\r\n}\r\n' WHERE `option`='bx_protean_styles_custom' AND `mix_id`=@iMixId;
