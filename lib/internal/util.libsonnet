{
  attrsByRole(field, spec)::
    local valid = ['controlPlane', 'worker', 'all'];
    assert std.all([std.member(valid, r) for r in std.objectFields(spec)])
      : 'unknown role in %s: %s' % [field, std.objectFields(spec)];
    {
      [role]: {
        [field]+: spec[role]
      }
      for role in std.objectFields(spec)
    },
}
