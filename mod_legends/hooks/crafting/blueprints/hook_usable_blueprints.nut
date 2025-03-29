local blueprints = [
	"acid_flask_blueprint",
	"antidote_blueprint",
	"cat_potion_blueprint",
	"daze_bomb_blueprint",
	"fire_bomb_blueprint",
	"happy_powder_blueprint",
	"iron_will_potion_blueprint",
	"lionheart_potion_blueprint",
	"miracle_drug_blueprint",
	"night_vision_elixir_blueprint",
	"poisoned_oil_blueprint",
	"potion_of_knowledge_blueprint",
	"potion_of_oblivion_blueprint",
	"recovery_potion_blueprint",
	"reinforced_throwing_net_blueprint",
	"smoke_bomb_blueprint"
];

foreach (blueprint in blueprints)
{
	::mods_hookExactClass("crafting/blueprints/" + blueprint, function(o)
	{
		local create = o.create;
		o.create = function ()
		{
			create();
			this.m.Type = this.Const.Items.ItemType.Usable;
		}
	});
}

local path = "crafting/blueprints/snake_oil_";
for( local i = 1; i <= 14; i = ++i )
{
	local variant = i < 10 ? "0" + i : i;
	::mods_hookExactClass(path + variant + "_blueprint", function(o)
	{
		local create = o.create;
		o.create = function ()
		{
			create();
			this.m.Type = this.Const.Items.ItemType.Usable;
		}
	});
}