# Initialize tag with circle build num
if [ ! $CI ]; then
	tag="localbuild"
else
	tag="$CIRCLE_BRANCH-$CIRCLE_BUILD_NUM"
fi

# Loop through all td images, tag and push
for i in `docker ps -aq` ; do
	image=`docker inspect --format="{{ .Config.Image }}" $i`
	imageid=`docker inspect --format="{{ .Image }}" $i`
	echo Image is $image
	if [[ $image == project_banking-web* ]]; then
		echo Tagging $image...
		echo docker tag $imageid tradedepot/banking-web:$tag
		docker tag $imageid tradedepot/banking-web:$tag
		if [ $CI ]; then
			docker push tradedepot/banking-web:$tag
		fi
	fi
done
