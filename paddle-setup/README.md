# Paddle cloud components integration testing environment setup
This suite of command is for quickly creating a testing environment for paddle cloud key components: master, pserver, and trainers in a 3 nodes virtual machine cluster with kubernetes, and start a training example task to verify end to end.

## Pre-requisites
1. 8G memory (2G for kube master node and 2*3G for worker node).
1. 8 CPU cores (2 for master node and 2*3 for worker node).
1. kubectl installed


## Quick start
All commands below are supposed to run within path of `paddle-setup`
### Create infrastructure and setup kubernetes
``` bash
./setup.sh
```
This includes creating virtual machines and setup kubernetes, which may take several minues.
### Create Paddle master, pservers, trainers and start training
``` bash
./start.sh
```
This step will create pods for master, pservers and trainers. Numbers of them are 1, 2, 2 by default.
### Check trainer logs
``` bash
./trainer_logs.sh <index>
```
index is the index of a trainer, 0 by default
### Check pserver logs
``` bash
./pserver_logs.sh <index>
```
index is the index of a pserver, 0 by default
### Check master logs
``` bash
./master_logs.sh
```
### Login to ETCD pod
``` bash
./etcd.sh
```
check if etcd keys are properly created
``` bash
etcdctl get / --prefix --keys-only
```
### Stop and remove paddle testing env
``` bash
./stop
```

### Stop & remove kubernetes and virtual machines
``` bash
./teardown.sh
```

## Further customizations
### Virtual machine customizations
Please refer to the file of `../Vagrantfile`. Memory or CPU settings are from line 110

### Paddle customizations
All master, pserver and trainer desc files are located in the folder of `./descs`.

### Training customizations
Training scripts and data are located in `../trainings`, this test setup runs `recommender_system` by default.
To run another test other than the default one:
1. update `./descs/train.json`, the field of `ENTRY` and `TRAINER_PACKAGE`
2. update `../trainings` accordingly with your training scripts and data

*Note: the repo root (`../`) will be mounted to virtual machine nodes' `/vagrant` by default. And trainer and master pods will mount `/vagrant/trainings` in nodes to its `/trainings`, which means your training scrips which located in `../trainings` will appear in pod's `/trainings`*