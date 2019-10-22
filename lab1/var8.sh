#!/bin/bash

print_info () {
	printf 'Возможные команды:\n'
	printf '1. Напечатать имя текущего каталога\n'
	printf '2. Сменить текущий каталог\n'
	printf '3. Создать файл\n'
	printf '4. Предоставить всем право на запись в файл\n'
	printf '5. Удалить файл\n'
	printf '6. Выйти из программы\n'
	printf "\n"
}

error_file='/home/redish/lab1_err'

print_info;

read -p 'Введите команду: ' str

while [ 1 = 1 ]
do

  case $str in
	1)  printf '\n'
		echo 'Текущая директория:' 
		pwd;
		printf '\n' 	
		;;
	2)  printf 'Введите путь к директории, в которую хотите перейти:\n'
		read to_dir
		cd "$to_dir" 2>> $error_file
		if [ "$?" = "0" ]; then
			printf "Директория изменена\n"
		else
			echo "Директории не существует или доступ к ней невозможен" 1>&2
		fi
		;;
	3)  printf 'Введите имя файла:\n'
		read new_file
		touch "$new_file" 2>> $error_file
		if [ "$?" = "0" ]; then
			printf "Файл создан!\n"
		else
			echo "Ошибка при создании файла." 1>&2
		fi
		;;
	4)  printf 'Введите имя файла:\n'
		read change_file
		chmod gou+r "$change_file" 2>> $error_file
		if [ "$?" = "0" ]; then
			printf "Права изменены!\n"
		else
			echo "Ошибка при изменении прав доступа." 1>&2
		fi
		;;
	5)  printf 'Введите имя файла:\n'
		read file_to_delete
		echo -n "Продолжить? (y/n) "
		read item
		case "$item" in
    		y|Y) rm "$file_to_delete" 2>> $error_file
				if [ "$?" = "0" ]; then
					printf "Файл удалён!\n"
				else
					echo "Ошибка удаления файла!" 1>&2
				fi
       		;;
		esac
		;;
	6)  printf "До свидания!\n"
		break
		;;
	*)  printf "\nНекорректный ввод! \n\n"
	esac

	printf "\n"
	print_info;
	read -p 'Введите команду: ' str
	
done
