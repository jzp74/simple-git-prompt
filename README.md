# simple-git-prompt
A very simple ``bash`` prompt that displays information about the current git repository, the branch name, number of files staged, changed, etc.

Note: Tested only on Windows machines in a Git shell

Note: This prompt is a port of the "Informative and fancy bash prompt for Git users" which you can find [here](https://github.com/magicmonty/bash-git-prompt)

## Installation
First clone this repository to your home directory
```bash
cd ~
git clone https://github.com/jzp74/simple-git-prompt.git .simple-git-prompt
```
Then add the following lines to your ```~/.bashrc```
```bash
# settings for simple-git-prompt
#SIMPLE_GIT_PROMPT_WINDOW_TITLE="Some title"  # Uncomment to set a window title
#SIMPLE_GIT_PROMPT_MAX_PWD_LEN=24             # Uncomment to set a maximum length of current path (PWD). Use 0 to not display $PWD at all
#SIMPLE_GIT_PROMPT_PREFIX="@\h"               # Uncomment to change the standard prefix of this prompt
#SIMPLE_GIT_PROMPT_SUFFIX="-->"               # Uncomment to change the standard postfix of this prompt
source ~/.simple-git-prompt/simplegitprompt.sh
```
Then reopen your bash shell, ```cd``` to a git repository and test it!

## Examples
* ``(status|●2)``: on branch ``status``, 2 files staged
* ``(master|✚7?3)``: on branch ``master``, 7 files changed, 4 files untracked
* ``(master|✖2✚3)``: on branch ``master``, 2 conflicts, 3 files changed
* ``(status|✔)``: on branch ``status``, repository clean

## License
This code is under the [GNU General Public License version 2.0 license][license].
