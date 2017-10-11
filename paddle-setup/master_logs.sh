podids=$(kubectl get pods -l jobname=paddlejob -l paddle-job-master=paddlejob -o=go-template='{{range .items}}{{printf "%.30s\n" .metadata.name}}{{end}}')
arr_podids=(${podids// / })
index=${1:0}
podid=${arr_podids[$index]}
echo "Fetching log for $podid"
kubectl logs $podid paddlejob