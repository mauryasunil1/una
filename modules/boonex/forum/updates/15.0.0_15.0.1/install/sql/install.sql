SET @sName = 'bx_forum';


-- VOTES
UPDATE `sys_objects_vote` SET `TriggerFieldAuthor`='' WHERE `Name`='bx_forum_poll_answers';
