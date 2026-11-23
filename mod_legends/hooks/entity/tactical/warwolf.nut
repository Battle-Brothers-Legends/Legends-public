::mods_hookExactClass("entity/tactical/warwolf", function (o) {
	local setItem = o.setItem;
	o.setItem = function (_i) {
		setItem(_i);
		::Legends.Professions.onAnimalDeployed(this, _i);
	}

	local onDeath = o.onDeath;
	o.onDeath = function (_killer, _skill, _tile, _fatalityType) {
		::Legends.Professions.onAnimalDowned(this, _fatalityType);
		onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
