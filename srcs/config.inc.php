<?php
/* vim: set expandtab sw=4 ts=4 sts=4: */
/**
 * phpMyAdmin sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <https://docs.phpmyadmin.net/>.
 *
 * @package PhpMyAdmin
 */

$cfg['blowfish_secret'] = 'zuTZHZA/[r011PM[lHf{j.v3QGJo:F;H';

$i = 0;
$i++;

$cfg['Servers'][$i]['auth_type'] = 'cookie';

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

$cfg['TempDir'] = '/var/www/config_domain/phpmyadmin/tmp';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';