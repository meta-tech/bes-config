#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function bes.config ()
{
    bes.echo.title "Reading Configuration Project" $APP_NAME
    if [ -f ./bes.ini ]; then 
        bes.ini ./bes.ini -p bes -b 1

        local    keys="vendor name version license author type homepage description keywords"
        local   value=""
        local hasconf=0
        for key in $keys; do
            value="bes_project_$key"
            if [ ! -z "${!value}" ]; then
                hasconf=1
                bes.echo.keyval $key "${!value}"
            fi
        done
        if [ "$hasconf" = "0" ]; then
            bes.echo "    -"
        fi

        bes.echo.title "Dependencies"
        bes.ini ./bes.ini require -p bes -b 1
        local prefix="bes_require"
        local    key=""
        for name in ${bes_ALL_VARS}; do
                  key=${name:${#prefix}+1}
            local tmp=${key//_/.}
            bes.echo.keyval "$tmp" "${!name}"
        done
    else
        bes.echo "     $project does not have bes.ini file"
    fi
    echo
}
