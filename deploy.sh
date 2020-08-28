IFS=$'\t'
array=("develop\tmaster")
unset IFS

value="$CIRCLE_BRANCH"
echo ${value}

# Colors for cosmetics
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

if [[ "\t${array[@]}\t" =~ "\t${value}\t" ]]; then
    echo -e "${YELLOW}Starting deployment of $CIRCLE_BRANCH to docker"
    docker login -e $DOCKER_EMAIL -u $DOCKER_USERNAME -p $DOCKER_PASS
    ./tagandpush.sh
    echo -e "${GREEN} Done deploying of $CIRCLE_BRANCH to docker"
fi

exit 0;
