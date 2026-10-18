local util = import 'internal/util.libsonnet';

function(opts)
  if !("mounts" in opts) then {} else util.attrsByRole('extraMounts', opts.mounts)
