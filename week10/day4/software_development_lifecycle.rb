Software Development Lifecycle: Waterfall and Agile. 

Waterfall: Requirement analysis, Design, Development, Testing, Maintenance. 
Agile: Product Backlog, Sprint Backlog, Sprint (30days), Working Increment of Software

1.) Concept
2.) Wireframe
3.) ERD: Entity Relationship Diagram. 
4.) Continuous Deployment
5.) Maintenance

Concept:
    - Requirements
    - Information Architecture
    - UX: User Experience. Speed, Navigation, Layout. F Patter. 

Wireframe: 
    - Moqups: https://moqups.com/
    - Draw.io: https://www.draw.io/ - User for ERD. 
    - Sketchapp.com 
    - Balsamiq

ERD: 
    - gem 'rails-erd': put in development section. Used for during/after project backend is built. 

Continuous Deployment:
    - GANTT Charts: www.teamgantt.com
    - Identify Dependencies. 
    - Estimate: Breakdown as much as possible. 
        - Points vs Actual. Poker Game.

Trello:
    To Do, Doing, To Review, Done 

Git Workflow:
Master Branch is Gold Standard. App in Working Form. 

git checkout f2
git merge integration
git push -u origin <branch name>

Git Rebase: 
Keep Branches commits together at the top of the history. 
    - go to branch that you want to rebase:
    - git rebase master 
    - look and solve the conflict
    - git add .
    - git rebase --continue
    - git push -f

Golden Rule of Rebasing: Only do it on your own branch. Never the Master or key branches. 