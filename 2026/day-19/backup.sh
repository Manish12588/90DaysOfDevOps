#!/bin/bash


if [ $# -ne 2 ]; then
        echo "Usage: ./backup.sh <path of your source diretcory> <path of your backup directory>"
        exit 1    
fi

SOURCE_DIR=$1
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "ERROR: Directory '$SOURCE_DIR' does not exist"
    exit 1
fi

BACKUP_DIR=$2
TIMESTAMP=$(date '+%Y-%m-%d-%H-%M-%S')

function create_backup {
    
    tar -czf "$BACKUP_DIR/backup-$TIMESTAMP.tar.gz" "$SOURCE_DIR" > /dev/null

    if [ $? -eq 0 ]; then
        echo -e "\nBackup Generated Successfully for $TIMESTAMP"
    fi

    echo -e "\nPrinting the name and size of created backup: "
    du -sh $BACKUP_DIR/backup-$TIMESTAMP.tar.gz
    echo -e "\n"
}

function perform_rotation_for_5_days {

    backups=($(ls -t "$BACKUP_DIR/backup-"*.tar.gz 2>/dev/null))

    if [ "${#backups[@]}" -gt 5 ]; then
        echo "performing rotation for 5 days"

        backups_to_remove=("${backups[@]:5}")
        echo "${backups_to_remove[@]}"

        for backups in "${backups_to_remove[@]}";
        do
            rm -f ${backups}
        done
    fi

}

function delete_backup_older_then_14_days {

    
}
 
create_backup
perform_rotation_for_5_days