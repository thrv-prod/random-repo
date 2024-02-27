#!/usr/bin/env bash
# Author; Theo
# Description: Script to add boiler plate for basic python scripts
# Modification reason: 02/27/24 - script create

#####################
#Initialize variables
#####################
DISTRO=$(cat /etc/*release | grep "^ID=" | sed s/^ID=//g | tr -d '"')
SCRIPT="$0"
EXIT_ON_ERROR="true"
FILE_NAME=""
CURRENT_DIR="$PWD"

echo
echo "Running program $0 with $# arguments and with pid $$ on distribution $DISTRO"


#########################################
# help - used to provide usage guidance
#########################################

help() {
      echo
      echo "This script creates boiler plate code for python projects"
      echo
      echo "Supported cli arguments:"
      echo -e "\t[-h] ->> print this help (optional)"
      echo
      echo -e "\t[-d] ->> enable debug mode (optional)"
      echo
      echo "USAGE: $0 -f new.py"
      echo
 }


#########################
#debug: enable debug mode
#########################
debug() {
    set -x
}

### Set to true to exit if a non-zero exit status is encountered
if [ "${EXIT_ON_ERROR}" == "true" ]; then
      set -e
fi

########################################################
# checkfiles - verifies configurations files are present
########################################################
CheckFiles() {
    echo
}

###########################################
# createfiles - creates configuration files
###########################################

CreateFiles() {
    
    # Create python script
    if [ -f "$CURRENT_DIR"/"$FILE_NAME" ]; then
       echo "File already exists in this directory"
       exit 1
    else
    cat << EOF > "$CURRENT_DIR"/"$FILE_NAME"
#!/usr/bin/env python3
Author: THV

"""
Add comment
"""

def main ():
  pass

def prog():
  pass

if __name__ == "__main__":
  main()
EOF
  chmod +x "$CURRENT_DIR"/"$FILE_NAME"
  echo
  echo "$FILE_NAME" has been created in "$PWD"
fi
}

#############################
# Process input variables
############################
while getopts ":hdf:" opt; do
    case "${opt}" in
    	# display help
    	h)
      help # call help function
      exit 0
      	;;
    d)
      debug # call debug function
      	;;      
    f)
      FILE_NAME="${OPTARG}"
     ;;
   	*) # incorrect option
      echo "Error: Invalid options"
      help
      exit 1
      	;;
	esac
done

###############
# BEGIN PROGRAM
###############
if [[ $# -lt 1 ]]; then
	help
elif [[ $1 -ne "-f" ]]; then
	help
else
  CreateFiles
fi

