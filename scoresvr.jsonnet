local cluster = import 'lib/cluster.libsonnet';

local options = {
  ingress: {
    enabled: true,
  },
  registry: {
    enabled: true,
  },
  workers: 1,
  mounts: {
    worker: [
      {
        hostPath: '/Users/marc/make/data',
        containerPath: '/data',
      },
      {
        hostPath: '/Users/marc/make/build',
        containerPath: '/build',
      },
    ],
  },
  ports: {
    worker: [
      {
        containerPort: 30017,
        hostPort: 30017,
        protocol: 'TCP',
      },
    ],
  },
};

cluster.newCluster('iron-1', options)
