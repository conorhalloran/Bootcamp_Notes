Express is a javascript library for building a web application that we will use later. The repo is here: https://github.com/expressjs/express

Lets do the following:

Fork the Express repo
Clone the repo to your computer. You can clone it in a folder under your users main folder, you may create a folder called codecore and put it in it.
// git clone git@github.com:conorhalloran/express.git
Make a change to any of the files with .md extension
// nano Readme.md
Commit the change you made
// git add Readme.md
// git commit
Push the change to your forked Github repo
// git push -u --all

Searching:
Using the Command Line, search within the content of all the files in the Express folder for the word middleware
// grep -hrn "middleware" express
Do the search again with color highlighting option so the word middleware displays in color
// grep -hrn --color "middleware" express
Do the search again looking only within files that have .md extensions
// grep --color middleware *.md
// grep -hrn --color --include="*.md" "middleware" express
