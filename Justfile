default:
    echo "Nothing to do..."

save:
    #!/usr/bin/env bash
    if git diff-index --quiet HEAD -- ; then
        echo "No changes to commit."
    else
        git add -A
        git commit -m "update: {{`date`}} | ${DOTTER_MACHINE_ALIAS:-outer-space}"
    fi

upload:
    #!/usr/bin/env bash
    if git diff-index --quiet HEAD -- ; then
        git pull -r
        git push
    else
        echo "Worktree is dirty. Please commit your changes first."
    fi
