::mods_hookExactClass("entity/world/settlements/buildings/taxidermist_building", function (o) {
	o.m.TaxidermistSpecialization <- null;
	local create = o.create;
	o.create = function () {
		create();
		local craftingProfessions = [
			::Legends.Profession.LegendLeatherworking,
			::Legends.Profession.LegendMetalworking,
			::Legends.Profession.LegendTailoring,
			::Legends.Profession.LegendTrophyCarving,
			::Legends.Profession.LegendWoodworking
		];
		this.m.TaxidermistSpecialization = craftingProfessions[::Math.rand(0, craftingProfessions.len() - 1)];
	}

	o.getName <- function () {
		local name = this.building.getName();
		return name + " (" + ::Const.Professions.ProfessionDefObjects[this.m.TaxidermistSpecialization].Name + ")";
	}

	o.onSerialize = function (_out) {
		this.building.onSerialize(_out);
		_out.writeI8(this.m.TaxidermistSpecialization);
	}

	o.onDeserialize = function (_in) {
		this.building.onDeserialize(_in);
		this.m.TaxidermistSpecialization = _in.readI8();
	}
});
