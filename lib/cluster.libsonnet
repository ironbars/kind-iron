local registry = import 'registry.libsonnet';
local ingress = import 'ingress.libsonnet';
local mounts = import 'mounts.libsonnet';
local ports = import 'ports.libsonnet';

local defaults = {
  registry: {
    enabled: false,
  },
  ingress: {
    enabled: false,
  },
  controlPlaneConfig: {},
  workerConfig: {},
  workers: 0,
};

local newCluster(name, options={}) =
  local opts = std.mergePatch(defaults, options);
  local features = [registry(opts), ingress(opts), mounts(opts), ports(opts)];
  local pick(layer) = std.foldl(
    function(acc, f) acc + std.get(f, layer, {}), features, {}
  );
  
  {
    apiVersion: 'kind.x-k8s.io/v1alpha4',
    kind: 'Cluster',
    name: name,
    nodes: [
      {
        role: 'control-plane',
      } + pick('controlPlane') + opts.controlPlaneConfig
    ] + [
      {
        role: 'worker',
      } + pick('worker') + opts.workerConfig for _ in std.range(1, opts.workers)
    ],
  } + pick('cluster');

{
  newCluster:: newCluster,
}
