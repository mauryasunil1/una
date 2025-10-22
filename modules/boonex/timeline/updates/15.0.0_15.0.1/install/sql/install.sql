SET @sName = 'bx_timeline';


-- VOTES
UPDATE `sys_objects_vote` SET `TriggerFieldAuthor`='' WHERE `Name`='bx_timeline_poll_answers';
