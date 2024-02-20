# I Can Has Kanban? 
*Yes, you can!*

Welcome to the meme Kanban board that I created as a learning project for the latest Rails stack.

The project is deployed on a free fly.io instance at http://has-kanban.fly.dev

After creating an account, you can create workspaces which will be able to be shared with others.
Within a workspace you can create as many boards as you need.
Each board has a collection of lists.
Each list has a collection of cards.
The boards and lists can be manipulated via drag-and-drop.

## Some notes on the stack used
- Ruby 3.2.3
- Ruby on Rails 7.1.3
- [Authentication Zero](https://github.com/lazaronixon/authentication-zero)
- [LiteStack](https://github.com/oldmoe/litestack)
- Flowbite TailwindCSS components
- [SortableJS](https://github.com/SortableJS/Sortable) through Stimulus
- Turbo frames and streams
- Pundit
- Minitest
- FactoryBot

## To-Do
- Implement Github Actions for CD/CD.
- Implement broadcast turbo-streams to allow muliple users to use the same board.
- Send invitations to members.
- Member management for workspaces.
