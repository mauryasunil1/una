<?php

$mixCheckResult = 'Update can not be applied';

if (!(PHP_VERSION_ID >= 80100)) {
    $mixCheckResult = 'This update requires a PHP version ">= 8.1.0". You are running ' . PHP_VERSION;
}
else {
    $sVer = $this->oDb->getOne("SELECT `version` FROM `sys_modules` WHERE `name` = 'system'");
    if ('14.0.0' == $sVer)
        $mixCheckResult = true;
}

if (true === $mixCheckResult && ($this->oDb->getOne("SELECT `id` FROM `sys_modules` WHERE `name` = 'bx_profiler'") > 0 || file_exists(BX_DIRECTORY_PATH_MODULES . 'boonex/profiler'))) {
    $mixCheckResult = 'The Profiler module must be uninstalled and deleted before applying this update. After the update is complete, you can download the latest version from the App Store.';
}

return $mixCheckResult;
