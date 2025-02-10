This is meant to go hand in hand with the [scoresvr
app](https://github.com/ironbars/scoresvr).

The deployment here is on [kind](https://kind.sigs.k8s.io/) with the nginx
ingress controller applied.

Obviously, you'll need kind and docker both installed for this to work.

You can use the script `kind-with-registry.sh` to bring up a cluster with
everything you need for the scoresvr use case (extra mounts, ingress, and local
registry).

```
./kind-with-registry.sh
```

### Playing around with jsonnet

Adjust the variables in `iron-config.jsonnet` and create the config:  

```
jsonnet iron-config.jsonnet > iron-config.json
```

Then you can convert this to YAML however you like (if you even want to).  For
example, with Python and PyYAML:  

```
cat iron-config.json \
  | python3 -c 'import yaml, sys, json; print(json.dumps(yaml.safe_load(sys.stdin), indent=2))' > iron-config.yaml
```
