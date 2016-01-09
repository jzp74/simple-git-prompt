# simple-git-prompt
This prompt is a port of the "Informative and fancy bash prompt for Git users" which you can find [here](https://github.com/magicmonty/bash-git-prompt)
A ``bash`` prompt that displays information about the current git repository, the branch name, number of files staged, changed, etc.
## Installation
First clone this repository to your home directory
```bash
cd ~
git clone https://github.com/jzp74/simple-git-promt.git simple-git-prompt
```
Then source the file `simplegitprompt.sh` from `~/.bashrc`
## Examples
* ``(status|●2)``: on branch ``status``, 2 files staged
* ``(master|✚7…)``: on branch ``master``, 7 files changed, some files untracked
* ``(master|✖2✚3)``: on branch ``master``, 2 conflicts, 3 files changed
* ``(status|●2)``: on branch ``status``, repository clean
## License
This code is under the [GNU General Public License version 2.0 license][license].
