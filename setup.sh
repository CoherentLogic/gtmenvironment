#!/bin/bash

source common.sh

echo -n "Enter GT.M installation path: "
read GTM_LOC
   
set-environment ${GTM_LOC}
build-directory-structure
configure-gld