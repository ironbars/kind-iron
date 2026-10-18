local util = import 'internal/util.libsonnet';

function(opts)
  if !('ports' in opts) then {} else util.attrsByRole('extraPortMappings', opts.ports)
