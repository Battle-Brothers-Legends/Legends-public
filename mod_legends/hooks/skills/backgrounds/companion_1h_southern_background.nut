::mods_hookExactClass("skills/backgrounds/companion_1h_southern_background", function(o)
{
	o.create = function ()
	{
		this.companion_1h_background.create();
		this.m.Bodies = ::Const.Bodies.Gladiator;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure)
		];
		this.m.Names = ::Const.Strings.SouthernNames;
		this.m.LastNames = ::Const.Strings.SouthernNamesLast;
	}

	o.onAddEquipment = function ()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Hitpoints] = 2;
		talents[::Const.Attributes.Fatigue] = 1;
		talents[::Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		local item = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.padded_vest],
			[1, ::Legends.Armor.Southern.leather_nomad_robe]
		]);
		items.equip(item);

		local helm = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.Southern.southern_head_wrap, ::Math.rand(0, 1) == 1 ? 12 : 8]
		]);
		items.equip(helm);
	}
});
