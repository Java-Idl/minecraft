# 1. Create a brand new branch with no history
git checkout --orphan clean-main

# 2. Stage everything (current working state)
git add -A

# 3. Make the single clean commit
git commit -m "feat: Minecraft Paper server with WebSocket tunnel and Mumble voice chat"

# 4. Delete the old main, rename this one to main
git branch -D main
git branch -m main

# 5. Force push (rewrites remote history)
git push --force-with-lease origin main

