if (!("Blueprints" in ::Legends)) {
	::Legends.Blueprints <- {};
}

::Legends.Blueprints.getID <- function (_def) {
	return ::Legends.Blueprints.BlueprintDefObjects[_def].ID;
}

::Legends.Blueprints.new <- function (_def) {
	return ::new(::Legends.Blueprints.BlueprintDefObjects[_def].Script);
}

::Legends.Blueprints.onCreate <- function (_blueprint, _blueprintDef) {
	local def = ::Legends.Blueprints.BlueprintDefObjects[_blueprintDef];
	_blueprint.m.ID = def.ID;
	_blueprint.m.ItemScript <- def.ItemScript;
	_blueprint.m.Ingredients <- def.Ingredients;
	_blueprint.m.Cost = def.Cost;
	_blueprint.m.Category <- def.Category;
	_blueprint.m.ProfessionRequired <- def.ProfessionRequired;
	_blueprint.m.AlternativeRequirements <- def.AlternativeRequirements;
	_blueprint.m.RequireAll <- def.RequireAll;
	_blueprint.m.Crafts <- def.Crafts;
	_blueprint.m.BlueprintType <- def.BlueprintType;
	if (_blueprint.m.BlueprintType == "Enchanting") {
		_blueprint.m.Rune <- ::Legends.Rune[def.Const];
	}
}
