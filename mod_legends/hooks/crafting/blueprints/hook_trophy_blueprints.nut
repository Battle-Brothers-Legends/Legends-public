local blueprints = [
	"alp_trophy_blueprint",
	"hexen_trophy_blueprint",
	"ghoul_trophy_blueprint",
];

foreach (blueprint in blueprints)
{
	::mods_hookExactClass("crafting/blueprints/" + blueprint, function(o)
	{
		local create = o.create;
		o.create = function ()
		{
			create();
			this.m.Type = this.Const.Items.ItemType.Accessory;
			this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendTrophyCarving)]);
		}
	});
};
