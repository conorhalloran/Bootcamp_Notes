git config --global user.name "<your-name>"
git config --global user.email "<your-email>"
git config --global core.editor "nano"

nano .gitconfig
mkdir git-demo
cd git-demo
git init

nano <filename>
git add
git add -A // adds everything!!!
git status // tracks what is going on in Git
git commit -m "<Description>"// start with present tense verb + description of what was done.
// if too much - made too much

git log
git log - p // full breakdown of changes
git reset HEAD <filename> // removes the desired file from a new commit

git remote add <repository ssh url>
git push -u --all // -u <links repository> --all <sends everything>

// To Identify Yourself
SSH <Secure>
ssh-keygen -t rsa -b 4096 -C "email@address.com"

Steps when creating new Project:
1.> Create folder
2.> Create filename
3.> git init
4.> git status
5.> git commit //add comments
6.> Create repository on github - copy SSH address:
// git@github.com:conorhalloran/git-practice.git
7.> git remote add origin git@github.com:conorhalloran/git-practice.git
8.> git push -u --all // git push origin master

Steps when Uploading:
- Make Changes to a file
- git add <filename> // adds the file to git
- git commit // then add comment

Cloning repository
git clone <SSH Address> // downloads entire repository to directory

Pulling Changes from Github
// git pull origin master

Unloading Commited File
// git reset <filename>

Reverting back to previous version
// git checkout -- <filename>

Creating a new branch
// git branch <branch name>

Switch to a different branch
// git checkout <branch name>
// to see which branch you are working in, type: git branch

To merge branches
1.> Switch to master
  // git checkout master
2.> Merge branches
  // git merge <branch name>

To Remove Finished Branches:
git branch -d <branch name>

To remove files:
// git rm <file name>
  to remove files from all types
    // git rm '*.<file type>'
