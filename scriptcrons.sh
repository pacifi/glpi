#!/bin/bash
docker exec glpi php /var/www/glpi/front/cron.php --force  mailgate


docker exec glpi php /var/www/glpi/front/cron.php --force  queuednotification

