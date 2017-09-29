Practice Linux/Unix commands by doing the following exercises:

Open Terminal. Make sure you're in your user's home directory.
Create a folder named codecore.
Navigate to the codecore folder.
Create a subfolder called assignments inside the codecore folder.
Navigate to the assignments folder.
Create two folders inside the assignments folder called day1 and day2.
Navigate to the day1 folder and create a file called 1.txt using the touch command.
Use the nano program to open the 1.txt file and write Hello World in it.
// nano 1.txt
Navigate to the day2 folder
// cd ../day2
Move 1.txt file from day1 folder to day2 folder
// mv day1/1.txt day2
Duplicate 1.txt file to 2.txt file inside the day2 folder
// cp 1.txt 2.txt
Delete the 1.txt file
// rm 1.txt

Stretch exercises:
How would you create a folder with a space in its name? (try renaming day1 folder to day 1)
// mv day1 "day 1"
How would you enter a folder with a space in its name (navigate to the renamed day 1 folder)
// cd "day 1"
Create a symbolic link for the 2.txt file inside of day 1 folder
// ln -s 2.txt ../"day 1"/2.txt
