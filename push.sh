#!/bin/sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "\033[1;38;5;208mCroissant [🥐] will push for you!\033[0m "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Check for Änderungen.
if [ -z "$(git status --porcelain)" ]; then
  echo "[🥐] „Nothing to commit!“"
  echo "[🥐] „See you next time.“"
  exit 0
fi


# Ask for a commit message.
echo -n "[🥐] „Enter a commit message!“ | ✒️  "
read COMMIT_MSG

echo "[🥐] „Cool! You say: »$COMMIT_MSG«.“"

# Push everything.
echo "[🥐] „Let me push now...“"
git add .
git commit -m "$COMMIT_MSG"
git push

echo "[🥐] „All done my friend!“"
echo "[🥐] „See you next time.“"