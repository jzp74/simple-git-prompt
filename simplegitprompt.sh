#!/usr/bin/env bash
# Simple Git Prompt
# Based on https://github.com/magicmonty/bash-git-prompt

# SEE STANDARD SETTINGS AT BOTTOM OF THIS FILE

function simple_git_prompt_dir() {
    # assume the gitstatus.sh is in the same directory as this script
    # code thanks to http://stackoverflow.com/questions/59895
    if [ -z "$__SIMPLE_GIT_PROMPT_DIR" ]; then
        local SOURCE="${BASH_SOURCE[0]}"
        while [ -h "$SOURCE" ]; do
            local DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
            SOURCE="$(readlink "$SOURCE")"
            [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
        done
        __SIMPLE_GIT_PROMPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    fi
}

function simple_git_prompt() {
    # get git status
    local git_status_fields=($("$__GIT_STATUS_CMD" 2>/dev/null))
    local GIT_BRANCH=${git_status_fields[0]}
    local GIT_STAGED=${git_status_fields[3]}
    local GIT_CONFLICTS=${git_status_fields[4]}
    local GIT_CHANGED=${git_status_fields[5]}
    local GIT_UNTRACKED=${git_status_fields[6]}
    local GIT_STASHED=${git_status_fields[7]}
    local GIT_CLEAN=${git_status_fields[8]}
    local CUR_WORK_DIR=$(pwd)
    local SIMPLE_GIT_PROMPT=""

    # add window title
    if [[ -n "$SIMPLE_GIT_PROMPT_WINDOW_TITLE" ]]; then
        SIMPLE_GIT_PROMPT+="\[\033]2;${SIMPLE_GIT_PROMPT_WINDOW_TITLE}\007\]"
    fi

    # add prefix
    if [[ -z "$SIMPLE_GIT_PROMPT_PREFIX" ]]; then
        SIMPLE_GIT_PROMPT_PREFIX="@\h"
    fi
    SIMPLE_GIT_PROMPT+="${BoldBlue}${SIMPLE_GIT_PROMPT_PREFIX}${ResetColor}"

    # somehow pwd command returns an empty string

    # set abbreviated pwd (only if coresponding setting is set)
    if [[ -n "$SIMPLE_GIT_PROMPT_MAX_PWD_LEN" ]]; then
        if [[ $SIMPLE_GIT_PROMPT_MAX_PWD_LEN -eq 0 ]]; then
            SIMPLE_GIT_PROMPT+=""
        elif [[ ${#PWD} -gt $SIMPLE_GIT_PROMPT_MAX_PWD_LEN ]]; then
            SIMPLE_GIT_PROMPT+=" ${BoldWhite}...${CUR_WORK_DIR: -$SIMPLE_GIT_PROMPT_MAX_PWD_LEN}${ResetColor}"
        else
            SIMPLE_GIT_PROMPT+=" ${BoldWhite}$CUR_WORK_DIR${ResetColor}"
        fi
    else
        SIMPLE_GIT_PROMPT+=" ${BoldWhite}$CUR_WORK_DIR${ResetColor}"
    fi

    # set git status part of prompt
    if [ -z $GIT_CLEAN ]; then
        SIMPLE_GIT_PROMPT+=""
    else 
        SIMPLE_GIT_PROMPT+=" ["
        if [ $GIT_CLEAN -eq 1 ]; then
            SIMPLE_GIT_PROMPT+="${BoldCyan}${GIT_BRANCH}|${BoldGreen}✔"
        else
            if [ $GIT_CLEAN -eq 0 ]; then
                SIMPLE_GIT_PROMPT+="${BoldCyan}${GIT_BRANCH}|"
                if [ $GIT_STAGED -ne 0 ]; then
                    SIMPLE_GIT_PROMPT+="${BoldYellow}●${GIT_STAGED}"
                fi
                if [ $GIT_CONFLICTS -ne 0 ]; then
                    SIMPLE_GIT_PROMPT+="${BoldRed}✖${GIT_CONFLICTS}"
                fi
                if [ $GIT_CHANGED -ne 0 ]; then
                    SIMPLE_GIT_PROMPT+="${BoldYellow}✚${GIT_CHANGED}"
                fi
                if [ $GIT_UNTRACKED -ne 0 ]; then
                    SIMPLE_GIT_PROMPT+="${BoldRed}?${GIT_UNTRACKED}"
                fi
            fi
        fi
        SIMPLE_GIT_PROMPT+="${ResetColor}]"
    fi

    # add suffix
    if [[ -z "$SIMPLE_GIT_PROMPT_SUFFIX" ]]; then
        SIMPLE_GIT_PROMPT_SUFFIX="-->"
    fi
    SIMPLE_GIT_PROMPT+=" ${SIMPLE_GIT_PROMPT_SUFFIX} "

    # set the git prompt
    PS1="$SIMPLE_GIT_PROMPT"
}

# MAIN FUNCTIONALITY

# set several environment variables
simple_git_prompt_dir
__COLORS_CMD="${__SIMPLE_GIT_PROMPT_DIR}/prompt-colors.sh"
__GIT_STATUS_CMD="${__SIMPLE_GIT_PROMPT_DIR}/gitstatus.sh"

# set colors
source "${__COLORS_CMD}"

# set standard function to set PS1
PROMPT_COMMAND=simple_git_prompt