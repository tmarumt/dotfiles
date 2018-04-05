#!/bin/bash

set -u
DOTPATH="${HOME}/dotfiles"

echo "link home directory dotfiles"
cd ${DOTPATH}
for f in .??*
do
    # ignore file or directory
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue

    ln -snfv ${DOTPATH}/${f} ${HOME}/${f}
done

echo "linked dotfiles complete!"
