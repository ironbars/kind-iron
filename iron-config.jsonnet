local cluster = 'iron-1';
local host_db_path = '/Users/marc/make/data';
local ctr_db_path = '/data';
local host_work_path = 'Users/marc/make/build';
local ctr_work_path = '/build';
{
  kind: 'Cluster',
  apiVersion: 'kind.x-k8s.io/v1alpha4',
  name: cluster,
  nodes: [
    {
      role: 'control-plane',
      kubeadmConfigPatches: [
        |||
          kind: InitConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "ingress-ready=true"
        |||,
      ],
      extraPortMappings: [
        {
          containerPort: 80,
          hostPort: 80,
          protocol: 'TCP',
        },
        {
          containerPort: 443,
          hostPort: 443,
          protocol: 'TCP',
        },
      ],
    },
    {
      role: 'worker',
      extraMounts: [
        {
          hostPath: host_db_path,
          containerPath: ctr_db_path,
        },
        {
          hostPath: host_work_path,
          containerPath: ctr_work_path,
        },
      ],
    },
  ],
}
