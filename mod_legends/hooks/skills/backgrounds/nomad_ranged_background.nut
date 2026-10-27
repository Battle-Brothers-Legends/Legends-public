::mods_hookExactClass("skills/backgrounds/nomad_ranged_background", function(o)
{
	o.create = function ()
	{
		this.nomad_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.NomadRanged);
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.NomadRanged);
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendThrowSand);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/oriental/nomad_sling"],
			[1, "weapons/oriental/composite_bow"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickBasicAmmo(items.getItemAtSlot(::Const.ItemSlot.Mainhand)));

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Southern.leather_nomad_robe]
		]));

		items.equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_leather_cap],
			[1, ::Legends.Helmet.Southern.nomad_light_helmet]
		]));
	}
});
