SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi


export HUB_DOMAIN=jbhub.deploy.me.uk
export YOUTRACK_DOMAIN=jbyoutrack.deploy.me.uk
export UPSOURCE_DOMAIN=jbupsource.deploy.me.uk
export TEAMCITY_DOMAIN=jbteamcity.deploy.me.uk
export DATA_FOLDER=./shared

if [ "$1" = "down" ] 
then
    docker-compose down -t 60
    exit
fi


if [ "$1" = "up" ] 
then

	if [[ ! -e "$DATA_FOLDER/foldersok" ]]; then
       echo "FOLDERS DO NOT EXIST, CREATING THEM...."
       mkdir -p -m 777 "$DATA_FOLDER/upsource/data" "$DATA_FOLDER/upsource/logs" "$DATA_FOLDER/upsource/conf" "$DATA_FOLDER/upsource/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/upsource/data" "$DATA_FOLDER/upsource/logs" "$DATA_FOLDER/upsource/conf" "$DATA_FOLDER/upsource/backups"

       mkdir -p -m 777 "$DATA_FOLDER/youtrack/data" "$DATA_FOLDER/youtrack/logs" "$DATA_FOLDER/youtrack/conf" "$DATA_FOLDER/youtrack/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/youtrack/data" "$DATA_FOLDER/youtrack/logs" "$DATA_FOLDER/youtrack/conf" "$DATA_FOLDER/youtrack/backups"

       mkdir -p -m 777 "$DATA_FOLDER/hub/data" "$DATA_FOLDER/hub/logs" "$DATA_FOLDER/hub/conf" "$DATA_FOLDER/hub/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/hub/data" "$DATA_FOLDER/hub/logs" "$DATA_FOLDER/hub/conf" "$DATA_FOLDER/hub/backups"

       mkdir -p -m 777 "$DATA_FOLDER/teamcity/data" "$DATA_FOLDER/teamcity/logs" "$DATA_FOLDER/teamcity/conf" "$DATA_FOLDER/teamcity/backups"
       #$SUDO chown -R 13001:13001 "$DATA_FOLDER/teamcity/data" "$DATA_FOLDER/teamcity/logs" "$DATA_FOLDER/teamcity/conf" "$DATA_FOLDER/teamcity/backups"

       $sudo touch "$DATA_FOLDER/foldersok"
	fi

	if [[ ! -e "$DATA_FOLDER/foldersok" ]]; then
		echo "SOMETHING IS WRONG, LOOKS LIKE I WASN'T ABLE TO PROPERLY CREATE FOLDERS..."
		exit;
	fi

	$sudo docker-compose up --build

    exit
fi

echo "up or down???"