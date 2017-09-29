To check current version: git --version
To update git: brew install git

New Project:

Steps to creating git repository:
1. Create new project folder
2. git init the folder
3. Create Github repository
4. git remote add origin <ssh url>
5. git remote -v #verifies that it works
- Do some Work
5. git add <file or folder name>
6. git commit -m
  # git commit -m 'Create Project'
7. Finished? git push origin

New Files #Untracked Files
  - git add
  - to reverse: git clean
    - git clean -n #Dry Run. What would be removed without removing it.
    - git clean -f #Removes the files.
    - git clean -i #Interactive way to remove file.

Reversing Workflow
Changes not stated to commit #Working three
  - git add
  - to reverse: git checkout--
Changes to be commited = #Indexed (staging area)
  - git commit
  - to reverse: git reset @ (can still get it back)
    - git reset @ --hard (its gone!)
Changes saved in history #Repository
  - to reverse: git reset
      - git reset <commit id>0434aed9fb338ba8290996ecf64d8a8de3eb4d46
      - git reset <commit id>0434aed9fb338ba8290996ecf64d8a8de3eb4d46~1
    #Doesn't reset that commit, resets up to that commit.

git diff #Way to see changes in files
git checkout -- README.md ## Reverts specific files
git checkout -- # Reverts all
git reset HEAD . # resets commit in current directory
git reset --hard @

https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

What is a commit? A Snapshot

Components of a commit:
Commit - Size
tree - <id> #Directory
author - <name><email>
commiter - <name><email>
Comment

Every commit, except for the first, has a parent. Can check the parent track to find original commit. #Singly Linked List
 - you cannot erase a commit, you can only modify it.
 - The core of Git is the commit.

how to delete a branch:
git branch -D <branch name>

how to rename a branch:
git branch -m ruby_exercises

how to merge a branch:
1. Create a branch: git checkout -b merge-experiments
2. Merge with desired branch: git merge ruby_exercises
git merge ruby_exercises

How to clone a repository:
git clone git@github.com:whilestevego/homework.git
git branch
git branch -a
1.) you will then see a list of directories
2.) move throughout the branches to unlock them. 

Force push
git push -f origin merge-exp


What is a merge Confict
