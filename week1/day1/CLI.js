Terminal = BASH - Born Again Sheel
*Investigate ZShell
* Investigate Vim // terminal best text editor
* Investigate Hammer Spoon

// Commands
- pwd <print working directory>
    Prints the full path of where you are working.
    /Users/conorhalloran/documents/Coding/CodeCore/Bootcamp/Homework

- whoami = prints your user name
- ls = lists all the directory and files within current directory.
- cd = if nothing entered, sends you to root directory
- cd foldername
- man <manual> display detailed help for commands
- r // recursive
- less // move around a file
- cURL // client URL request library. Makes web request and can download from anywhere online.
// curl www.google.ca
// curl https://tinyurl.com/y7a2odbc
> & >> // are used to in combination with commands and redirect output
/* to download a file and save it to a name:
  curl http://www.randomtext.me/download/txt/gibberish/p-5/25-45 > filename */
  >> // will add to end of file
find // search for files by their name
// find . -name filename
// find . -name file* <* = none specific>
grep // globally search a regular expression and print. Used to search inside a files
// grep <folder> <filename>
// grep --color <word> <filename> = will colour highlight the word with the file
clear // clears the window
sudo // <superuser do> = get
// sudo touch make-me-a-sandwich
env // list all environtment variables <or, global variables>
export //
// export my-var = hello

// Options
Most commands can take options - or --
ls -lha = list all directorys

// Tips
command + = zoom in
command - = zoom out
h = help
~ = path to home directory
cd . = path to current directory
cd .. = path to parent directory
cd ../.. = go up two directories
command k = clears the screen
pressing up arrow can let you cycle through previouysly entered code
control c // will abort any command
 | pdcopy // copy whatever code to your clipboard
 cat id_rsa.pub | pbcopy


// Control your Surroundings
- cd <change directory>
// Examples
cd /
mkdir <Make Directory> - Creates a directory
mkdir -p Bootcamp/Day-1
touch // creates a empty file
echo // writes arguments to the standard output, or prints text to screen
// echo winter is coming
// echo 'Winter is coming'
// echo $<variable>
cp <copy> // cs file-a file-b
// cp <first file> <duplicate file>
// cp <file name> <directory>
mv <move> // moves files from one to another
// mv <file-name> <directory>
// can be used to rename files or directories
cat // joins file together
tail // displays the last part of a files
tail -f <filename> // -f makes it wait for a change to the file.


// Making Files
nano // Nano's another editor
nano <filename> // opens file in nano text editor

pwd // outputs the name of the current working directory.
ls // lists all files and directories in the working directory.
  // In addition to -a, the ls command has several more options.
  // Here are three common options:
  -a // lists all contents, including hidden files and directories
  -l // lists all contents of a directory in long format
  -t // order files and directories by the time they were last modified.
  -alt // all contents, including hidden files and directories, in long format, ordered by the date and time they were last modified.
cd // switches you into the directory you specify.
mkdir // creates a new directory in the working directory.
touch // creates a new file inside the working directory.

Wildcards
* // selects all files in the working directory, so here we use cp to copy all files into the satire/ directory.
cp m*.txt scifi/
  // selects all files in the working directory starting with "m" and ending with ".txt", and copies them to scifi/.
rm // removes specific files
rm -r // option that modifies the behavior of the rm command. The -r stands for "recursive," and it's used to delete a directory and all of its child directories.
