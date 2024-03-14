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

Bring up the app.  Assuming the repo is cloned at `/home/me/scoresvr`:  

```
kubectl apply -f /home/me/scoresvr/manifests/scoreserver.yaml
```

### Playing around with jsonnet

Adjust the variables in `iron-config.jsonnet` and create the config:  

```
jsonnet iron-config.jsonnet > iron-config.json
```

Then you can convert this to YAML however you like.  For example, with Python and PyYAML:  

```
cat iron-config.json \
  | python3 -c 'import yaml, sys, json; print(json.dumps(yaml.safe_load(sys.stdin), indent=2))' > iron-config.yaml
```
