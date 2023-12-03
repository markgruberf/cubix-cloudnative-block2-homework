#!/bin/bash

# Start the backend
if [[ $MODE == "BE" || $MODE == "FULL" ]]; then

	java -jar backapp.jar --server.port=$BACK_PORT & 
	
fi

# in fullstack mode wait 15 secs for backend to start. It would be better to check backend's URL for readiness. 

if [[ $MODE == "FULL" ]]; then

	sleep 15
	
fi
	

# Start the frontend
if [[ $MODE == "FE" || $MODE == "FULL" ]]; then

	java -jar frontapp.jar --back.url=$BACK_URL &
	
fi



# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?