Setting up a Git repo:

Create a folder called 'git_practice' somewhere in your users main folder or subfolder
// mkdir git_practice
Create a file called abc.rb inside that folder. Give it some content: puts "Hello World"
// namo abc.rb
Initialize a git repo
// git init
Stage and commit the file you just created
// git status
// git commit
Create a repo on Github.
// copy the SSH address
Add Github repo you just created as a remote repo by following the instructions given from Github
// git remote add (SSH url)
Push your local repo to Github
// git push -u --all
Add the classmate youre paired with as a collaborator on your Github repo
Collaborating:

Clone your classmates repo to a folder different from the one you created (maybe git_practice_2)
// git clone git@github.com:BirdpersonC137/git_practice.git
Add a file xyz.rb with content: puts "Hello Back!"
// nano xyz.rb
Commit and push the new file to Github
// git status
// git add xyz.rb
// git commit
// git push -u --all

Got back to your git_practice folder
Pull the changes after your classmate pushes to Github
// git pull --all
