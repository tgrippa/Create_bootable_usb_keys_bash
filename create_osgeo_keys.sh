#!/bin/bash

# Unmount all the keys if need
START=$(date +%s)
for drive in $(cat output_drives_list); do
	sudo umount /dev/$drive &
done

jobs # get a list of running jobs
wait # wait for all processes to complete
sync
echo Unmonting keys took: $(( $(date +%s)-START )) seconds


# Create bootable keys from the .iso file
START=$(date +%s)
for drive in $(cat output_drives_list); do
	sudo dd if=ISO_FILE/osgeolive_1.iso of=/dev/$drive status=progress bs=4M && sync &
done

jobs # get a list of running jobs
wait # wait for all processes to complete
sync
echo Creating bootable keys took: $(( $(date +%s)-START )) seconds