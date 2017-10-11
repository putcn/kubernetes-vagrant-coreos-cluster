podids=$(kubectl get pods -l jobname=paddlejob -l paddle-job-master=paddlejob -o=go-template='{{range .items}}{{printf "%.30s\n" .metadata.name}}{{end}}')
arr_podids=(${podids// / })
podid=${arr_podids[0]}
echo "pod to connet to $podid"
echo "To list all keys in etcd"
echo "etcdctl get / --prefix --keys-only"
kubectl exec -it $podid -c paddlejob-etcd -- /bin/sh