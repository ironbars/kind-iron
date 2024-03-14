local cluster = 'iron-1';
local host_mount = '/Users/marc/make/scores';
local ctr_mount = '/scores';
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
          hostPath: host_mount,
          containerPath: ctr_mount,
          readOnly: true,
        },
      ],
    },
  ],
}
