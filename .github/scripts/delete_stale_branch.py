from github import Github
from datetime import datetime, timedelta
import os

GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
ORG_NAME = os.getenv('ORG_NAME')
DAYS_THRESHOLD = 7

g = Github(GITHUB_TOKEN)
org = g.get_organization(ORG_NAME)

for repo in org.get_repos():
    for branch in repo.get_branches():
        last_commit = repo.get_branch(branch.name).commit.commit.author.date
        if datetime.now() - last_commit > timedelta(days=DAYS_THRESHOLD):
            # Notify owner and delete the branch
            owner_email = repo.get_branch(branch.name).commit.commit.author.email
            print(f"Stale branch found: {repo.name}/{branch.name}")
            print(f"Notifying owner ({owner_email}) and deleting the branch...")
            # Implement notification logic here (e.g., send an email)
            repo.get_git_ref(f"heads/{branch.name}").delete()
            print("Branch deleted.")
