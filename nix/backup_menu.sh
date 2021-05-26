#!/bin/bash

menu_1 () {

	while [[ exit_sub_menu != 1 ]]; do

			/usr/bin/clear
			printf "\nChoose an option (Local Options):\n\n1. Do backup.\n2. Make/mnt/backup tree file.\n0. Exit\n\n$ "
			
			read read_new_opt

			case "$read_new_opt" in
				
				"0" )
				printf "\nExiting...\n"	
				exit_sub_menu=1
				main_menu
				break
				;;

				"1" )
				printf "\n"
				/usr/bin/rsync -zavpPh /mnt/shared/SYSADMIN /mnt/backup/shared_importante
				/usr/bin/rsync -zavpPh /mnt/shared/UNIVERSIDAD /mnt/backup/shared_importante 
				/usr/bin/rsync -zavpPh /mnt/shared/OTROS /mnt/backup/shared_importante
				/usr/bin/rsync -zavpPh /home/aaj/Desktop /mnt/backup/desktop
				printf "\n"
				;;

				"2" )
				printf "\n"
				/usr/bin/tree /mnt/backup | /usr/bin/tee /home/aaj/backup_local_tree.txt
				printf "\n"
				;;

				* )
				printf "\nTry again, choose a valid option!\n"
				;;

			esac

		done

}

menu_2 () {

	while [[ exit_sub_menu != 1 ]]; do

			/usr/bin/clear
			printf "\nChoose an option (Timecapsule Options):\n\n1. Do backup.\n2. Make /mnt/capsule/aaj-xpg-suse tree file.\n3. Exit with Timecapsule mounted\n0. Exit with Timecapsule unmounted\n\n$ "

			read read_new_opt

			case "$read_new_opt" in
				
				"0" )
				printf "\nExiting...\n"
				/usr/bin/umount /mnt/capsule
				exit_sub_menu=1
				main_menu
				break
				;;

				"1" )
				/usr/bin/rsync -zavpPh /mnt/backup /mnt/capsule/aaj-xpg-suse
				;;

				"2" )
				printf "\n"
				/usr/bin/tree /mnt/capsule/aaj-xpg-suse | /usr/bin/tee /home/aaj/backup_timecapsule_tree.txt
				printf "\n"
				;;

				"3" )
				printf "\nExiting...\n"	
				exit_sub_menu=1
				main_menu
				break
				;;

				* )
				printf "\nTry again, choose a valid option!\n"
				;;

			esac

		done

}

mount_capsule () {

	wait_menu=$(ls /mnt/capsule | grep aaj-xpg-suse)
	/usr/bin/clear

	if [[ "$wait_menu" != "aaj-xpg-suse" ]]; then
		
		sudo mount -t cifs //10.24.10.2/Capsule /mnt/capsule -o password='Mi_contraseña',sec=ntlm,uid=1000,vers=1.0
		printf "\nPlease wait. Timecapsule is not mounted.\nRetry? [y/n]: "
		exit=0

		while [[ $exit != 1 ]]; do
			
			read retry

			if [[ "$retry" = "Y" || "$retry" = "y" ]]; then
				mount_capsule $exit_sub_menu
				exit=1
			elif [[ "$retry" = "N" || "$retry" = "n" ]]; then
				main_menu
				exit=1
			else
				printf "Try again, choose a valid option!"
			fi	

		done

	else
		menu_2 $exit_sub_menu
	fi

}

main_menu() {

	while [[ $exit_menu != 1 ]]; do

		exit_menu=0
		exit_sub_menu=0
		
		/usr/bin/clear
		printf "\nChoose an option:\n\n1. Show local options.\n2. Show timecapsule options.\n0. Exit\n\n$ "
		read read_opt

		case "$read_opt" in
			
			"0" )
			printf "\nExiting...\n"	
			exit_menu=1
			break
			;;

			"1" )
			menu_1 $exit_sub_menu
			break
			;;

			"2" )
			mount_capsule $exit_sub_menu
			break
			;;

			* )
			printf "\nTry again, choose a valid option!\n"
			;;
			
		esac

	done

}

main_menu