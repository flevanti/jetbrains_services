SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi


export HUB_DOMAIN=hub.local
export YOUTRACK_DOMAIN=youtrack.local
export UPSOURCE_DOMAIN=upsource.local
export DATA_FOLDER=./shared


if [[ ! -e "$DATA_FOLDER/foldersok" ]]; then
       echo "FOLDERS DO NOT EXIST, CREATING THEM...."
       mkdir -p -m 777 "$DATA_FOLDER/upsource/data" "$DATA_FOLDER/upsource/logs" "$DATA_FOLDER/upsource/conf" "$DATA_FOLDER/upsource/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/upsource/data" "$DATA_FOLDER/upsource/logs" "$DATA_FOLDER/upsource/conf" "$DATA_FOLDER/upsource/backups"

       mkdir -p -m 777 "$DATA_FOLDER/youtrack/data" "$DATA_FOLDER/youtrack/logs" "$DATA_FOLDER/youtrack/conf" "$DATA_FOLDER/youtrack/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/youtrack/data" "$DATA_FOLDER/youtrack/logs" "$DATA_FOLDER/youtrack/conf" "$DATA_FOLDER/youtrack/backups"

       mkdir -p -m 777 "$DATA_FOLDER/hub/data" "$DATA_FOLDER/hub/logs" "$DATA_FOLDER/hub/conf" "$DATA_FOLDER/hub/backups"
       $SUDO chown -R 13001:13001 "$DATA_FOLDER/hub/data" "$DATA_FOLDER/hub/logs" "$DATA_FOLDER/hub/conf" "$DATA_FOLDER/hub/backups"

       $sudo touch "$DATA_FOLDER/foldersok"
fi

if [[ ! -e "$DATA_FOLDER/foldersok" ]]; then
	echo "SOMETHING IS WRONG, LOOKS LIKE I WASN'T ABLE TO PROPERLY CREATE FOLDERS..."
	exit;
fi

$sudo docker-compose up --build
