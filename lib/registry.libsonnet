function(opts)
  if !opts.registry.enabled then {} else {
    cluster: {
      containerdConfigPatches+: [
        |||
          [plugins."io.containerd.grpc.v1.cri".registry]
            config_path = "/etc/containerd/certs.d"
        |||,
      ],
    },
  }
