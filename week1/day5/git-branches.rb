The master itself is not a commit. The master always follows the latest commit.

A Head is like a bookmark, keeping track of a branch that you are working on.

#******************************************************

We are on a master, and we are creating a branch, Testing.

 Head
  |
  v
Master
  |
  v
Last Master Commit  -- > Previous Commit  -- > Prior Commit

            ^
            |

        First Testing Commit < -- Current Testing Commit

                                            ^
                                            |
                                          Testing

#*******************************************************

Branches in Github:
1.) Create a Branch: git branch hello-core-logic
2.) Switch to that branch: git checkout hello-core-logic
3.) Check branches in machine: git branch #Which ever one you are on will have an *

Why are branches useful:
 - Isolate a development effort in one branch.
 - Throw away Branch
 - Makes working on a project very flexible.
 - Name Branches after its Purpose. #id of bug fix, feature name

Switching to Branches in one Steps
 - git checkout -b <name>
  = git branch <name>
    git checkout <name>

git push origin hello-core-logic
