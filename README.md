This is meant to go hand in hand with the [scoresvr
app](https://github.com/ironbars/scoresvr).

The deployment here is on [kind](https://kind.sigs.k8s.io/) with the nginx
ingress controller applied.

Order of operations is thus.

Create the cluster:  

```
kind create cluster --config iron-config.yaml
```

Install the NGINX ingress controller:  

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Bring up the app:  

```
kubectl apply -f scoreserver.yaml
```
