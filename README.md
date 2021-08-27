# wait-for-rs
Wait for Kubernetes Deployment to update new ReplicaSet

# Usage
```
./wait-for-rs.sh <kubectl get parameters>
```

# Reason

`kubectl` has nice option to `wait` for condition. However we can't use it in situation when we want to change Deployment manifest and wait for new ReplicaSet successfully progressed. Condition `Progressing` always True and became False after 10 minutes of unsuccessful attempts to deploy new ReplicaSet.

This shell script watch for condition `Progressing` status until it became successful or not. Additionaly you can run it like this to timeout it sooner:

```
timeout 60 ./wait-for-rs.sh -n sandbox deployment/myapp
```
