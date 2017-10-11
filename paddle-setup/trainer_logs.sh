podids=$(kubectl get pods -l jobname=paddlejob -l paddle-job=paddlejob -o=go-template='{{range .items}}{{printf "%.30s\n" .metadata.name}}{{end}}')
arr_podids=(${podids// / })
trainerIndex=${1:0}
podid=${arr_podids[$trainerIndex]}
echo "Fetching log for $podid"
kubectl logs $podid