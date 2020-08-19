#!/bin/sh
##############################################################################
THIS_SCRIPT_NAME="run_this_bashscript-for-hugo_LEELASRECIPES_WEBSITE_rsync_upload.sh"
##############################################################################

##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## CREATING SCRIPT USAGE FUNCION AND CALLING IT VIA '--help'
usage()
{
cat <<EOM
USAGE: $(basename $0)
  ##############################################################################
  ## Step 1a: This script creates the LUNR search index,
  ## Step 1b: Deletes the tmp yaml files created during lunr index making.
  ## Step 2: Runs the hugo command to build the actual LEELASRECIPES.com website
  ## Step 3: then syncs HUGO NOTES Website public folder to the dreamhost server
  ##############################################################################
  USAGE: bash $THIS_SCRIPT_NAME
  ##############################################################################
  DATE CREATED: 2020-08-11
  ##############################################################################  
EOM

exit 0 ## EXITING IF ONLY USAGE IS NEEDED
}
## Calling the usage function
if [ "$1" == "--help" ] ; then usage ; fi
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##################################################################################
##------------------------------------------------------------------------------
echo "Currently sourcing the bash color script, which outputs chosen texts in various colors ..." ;
source $DIR_GITHUB/Bash-Scripts-To-Make-Life-Easier/2000_vendor_programs/color-logger.sh
info "This enables use of keywords for coloring, such as: debug, info, error, success, warn, highlight." ;
debug "Read it's help by running: >> bash $DIR_GITHUB/Bash-Scripts-To-Make-Life-Easier/2000_vendor_programs/color-logger.sh -h"
##------------------------------------------------------------------------------

##############################################################################
HUGO_PROJECT_DIR="$(pwd)" ;
info ">>>> HUGO_PROJECT_DIR = $HUGO_PROJECT_DIR " ;

##############################################################################
## CREATING ALL SITE STATISTICS AND SAVING TO HTML FILE IN STATIC DIRECTORY
echo ">> BEGINNING: CREATING SITE STATISTICS"
bash $DIR_GITHUB/Bash-Scripts-To-Make-Life-Easier/1002-leelasrecipes-website-scripts/1002-leelasrecipes-CREATE-AND-SAVE-SITE-STATISTICS.sh
success ">> DONE: CREATING SITE STATISTICS"

##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## BEGIN: FUNCION DEFINITIONS
func_create_lunar_search_index () {
  ###### STEP 1a + 1b: CREATING LUNR SEARCH INDEX ###################################
  cd $HUGO_PROJECT_DIR/static/LUNR/ ; ## cd to the LUNR search directory
  echo "#################################### Current PWD = $(pwd)" ;

  ## Running indexing scripts
  sh bashscript-step1-bulk-bash-yaml-creator-from-markdown-files.sh
  sh bashscript-step2-lunr-all-run-commands-in-sequence.sh

  ## Deleting tmp yaml files from static/LUNR/_TMP_yaml_files/ directory
  echo ;
  echo ">>> BEGIN: TMP YAML files deletion started." ;
  rm _TMP_yaml_files/yamltest-* ; ## make sure that you are deleting the right yaml files
  echo "<<< DONE: TMP YAML files successfully deleted." ;
  echo ;
}
## END: FUNCION DEFINITIONS
## Runing the lunr seach index function:
#func_create_lunar_search_index
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd $HUGO_PROJECT_DIR ; ## cd back to main project directory
echo "#################################### Current PWD = $(pwd)" ;

## SEE IF EVERYTHING IS OKAY, ELSE PRESS CTRL+C to stop
## Audio notification (Mac OS only command.).
echo;
read -p ">>>>>>>>>>>>>>>>> IF ALL IS OKAY SO FAR, then press ENTER key to continue ... " ;
echo ;

##############################################################################
## BEGIN: DELETE FUNCTION DEFINITION ###############
function DELETE_EVERYTHING_IN_HUGO_PUBLIC_DIRECTORY () {
  ###### STEP 2a: DELETING EVERYTHING INSIDE PUBLIC DIRECTORY ###################################
  info ">>> BEGIN: DELETING EVERYTHING INSIDE PUBLIC DIRECTORY = $HUGO_PROJECT_DIR/public/* ..." ;
  ## Audio notification (Mac OS only command.).
  echo "Planning to delete everything inside hugo public directory to save space on hard disk." ;

  ## CONFRMATION TO SEE IF EVERYTHING IS OKAY, ELSE PRESS CTRL+C to stop
  #echo; read -p ">>>>>>>>>>>>>>>>> IF ALL IS OKAY, then press ENTER key to continue ... " ; echo ;

  ## ACTUAL DELETING STARTS NOW...
  rm -rf $HUGO_PROJECT_DIR/public/* ;
  info ">>> END: DELETING EVERYTHING INSIDE PUBLIC DIRECTORY ..." ;
  echo "Everything deleted ... " ;
}
## END: DELETE FUNCTION DEFINITION ###############

## Calling the above function
#DELETE_EVERYTHING_IN_HUGO_PUBLIC_DIRECTORY

###### STEP 2b: RUNNING HUGO COMMAND ###################################
echo "Now creating whole website using hugo ... " ;

info ">>> BEGIN: HUGO command running ..." ;
hugo ;
info "<<< DONE: HUGO command successfully ran." ;
echo ;

##############################################################################
###### STEP 3: SYNCING HUGO NOTES WEBSITE TO SERVER ###################################

## Audio notification (Mac OS only command.).
echo "Hugo site generated. Now R-syncing is about to begin. Please be ready to enter your password." ;

echo ">>> BEGIN: Final backup to DH server ..." ;
## Defining some variables
USER="abhiannu_clients"
HOST="ps575942.dreamhostps.com"
INPUT_DIR="$DIR_GITHUB/2020-LEELA-RECIPES/public/"
OUTPUT_DIR="/home/abhiannu_clients/leelasrecipes.com/"

echo "########################################" ;
echo "INPUT_DIR : $INPUT_DIR " ;
echo "OUTPUT_DIR : $OUTPUT_DIR " ;
echo "USER : $USER " ;
echo "HOST : $HOST " ;
echo "########################################" ;

cd $INPUT_DIR ;
echo "PWD is $(pwd)" ;
echo "########################################" ;
echo "BEGIN: RSYNCing..." ;
rsync -avz --delete $INPUT_DIR ${USER}@${HOST}:${OUTPUT_DIR} ;
warn ">>>>IF ERRORS, run the following command:" ;
warn "rsync -avz --delete $INPUT_DIR $USER@$HOST:$OUTPUT_DIR" ;
echo ;
echo "########################################" ;
echo "DONE: RSYNCing..." ;
echo "########################################" ;

## FINAL AUDIO MESSAGE
FINAL_MSG="Hugo site has been uploaded to server. Have fun! But not before checking it." ;
success "$FINAL_MSG" ;
echo "$FINAL_MSG" ;

## Opening website (Works on MAC OS only).
echo ">>>> Opening website = https://www.leelasrecipes.com"
# open https://www.leelasrecipes.com

##################################################################

## FINAL STEP: EMPTYING HUGO PUBLIC DIRECTORY TO SAVE SPACE ON HARD DISK
## BY CALLING DELETE FUNCTION
DELETE_EVERYTHING_IN_HUGO_PUBLIC_DIRECTORY

###################################################################
exit 0
