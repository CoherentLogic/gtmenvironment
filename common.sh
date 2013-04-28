#!/bin/bash

function set-environment
{
    ENV_HOME=${HOME}
    GTM_HOME=$1

    export ENV_DB=${HOME}/g
    export ENV_GLD=${ENV_DB}/default.gld
    export ENV_DAT=${ENV_DB}/default.dat
    export ENV_JNL=${HOME}/j/default.mjl

    export gtm_dist=${GTM_HOME}
    export gtmgbldir=${ENV_GLD}
    export gtm_log=${HOME}/log
    export gtmroutines="${GTM_HOME} ${HOME}/o(${HOME}/p ${HOME}/r)"
}

function build-directory-structure
{
    BASE_DIR=${HOME}
    mkdir ${BASE_DIR}/g
    mkdir ${BASE_DIR}/j
    mkdir ${BASE_DIR}/log
    mkdir ${BASE_DIR}/p
    mkdir ${BASE_DIR}/r
    mkdir ${BASE_DIR}/o
}

function configure-gld
{
    $gtm_dist/mumps -r ^GDE <<EOF
change -segment DEFAULT -file=${ENV_DAT}
change -segment DEFAULT -block_size=4096 -global_buffer_count=2048
change -segment DEFAULT -allocation=150000 -extension=20000
change -region DEFAULT -key_size=255 -record_size=4080
change -region DEFAULT -journal=(BEFORE_IMAGE,file_name="${ENV_JNL}")
exit
EOF
    $gtm_dist/mupip create
    $gtm_dist/mupip set -journal="enable,before" -file ${ENV_DAT}
}