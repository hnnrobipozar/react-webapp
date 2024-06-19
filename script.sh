YAML_FILE=$1
DEPLOYMENT_NAME="react-app-rollingupdatev2"

start_time=$SECONDS

kubectl apply -f $YAML_FILE

while true; do
    status=$(kubectl rollout status deployment/$DEPLOYMENT_NAME)
    if [[ $status == *"successfully rolled out"* ]]; then
        end_time=$SECONDS
        deployment_time=$((end_time - start_time))
        echo "Aplikacja została wdrożona w ciągu $deployment_time sekund."
        exit 0
    fi

    sleep 5
done
