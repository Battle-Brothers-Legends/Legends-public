local legends_inherit = ::inherit;
::inherit = function( _baseScript, _members ) {
  if (_baseScript == "scripts/entity/tactical/actor") {
    local stack = getstackinfos(2);    
    if (stack != null && stack.src != null) {
      if (stack.src.find("orc_")) {
        _baseScript = "scripts/entity/tactical/legend_orc";
      }
      else if(stack.src.find("lesser_flesh_golem") || stack.src.find("greater_flesh_golem")){
        _baseScript = "scripts/entity/tactical/legend_flesh_golem";
      }
    }
  }
    return legends_inherit(_baseScript, _members);
};