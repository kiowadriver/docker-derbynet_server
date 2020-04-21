<?php
$roles = array('' => array('password' => '',
                            'permissions' => VIEW_RACE_RESULTS_PERMISSION),
                'Timer' => array('password' => ${TIMER_PASSWORD},
                                 'permissions' => TIMER_MESSAGE_PERMISSION,
                                 'interactive' => false),
                'Photo' => array('password' => ${PHOTO_PASSWORD},
                                 'permissions' => PHOTO_UPLOAD_PERMISSION,
                                 'interactive' => false),
                'RaceCrew' => array('password' => ${RACE_CREW_PASSWORD},
                                    'permissions' =>
                                    VIEW_RACE_RESULTS_PERMISSION | VIEW_AWARDS_PERMISSION
                                    | CHECK_IN_RACERS_PERMISSION | REVERT_CHECK_IN_PERMISSION
                                    | ASSIGN_RACER_IMAGE_PERMISSION | JUDGING_PERMISSION | PHOTO_UPLOAD_PERMISSION
                                    | EDIT_RACER_PERMISSION | REGISTER_NEW_RACER_PERMISSION),
                'RaceCoordinator' => array('password' => ${RACE_COORD_PASSWORD},
                                           'permissions' => -1)
               );
$post_setup_role = 'RaceCoordinator';
?>
