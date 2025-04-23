::mods_hookExactClass("skills/backgrounds/fisherman_southern_background", function(o)
{
	o.create = function ()
	{
		this.fisherman_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fat)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% loved the sea and the serenity of fishing alone on the water | Ironically, %name% always hated the water, but became a fisherman after his father and his father\'s father | %name% was a strong and able fisherman | %name% was content with being a fisherman | %name% always had a lucky hand in finding the best fishing grounds and catching the fattest fish}. As long as there was no storm, he was out there, fishing, day in and out. {Sadly, his fishing cabin burned to the ground while he was out at sea. | But disaster struck as he lost his best friend at sea when a storm suddenly came up, leaving him with a badly damaged boat and no one to sail out with. | But disaster struck when his wife died during childbirth, shattering all what he held dear. | After being unable pay his debts for some time, however, his boat was taken from him by a merciless loan shark. | It was after he strangled his wife in a fit of rage that he lost all interest in the fishing trade. | Much to his dismay, for almost a whole summer most of the fish he caught was already dead and rotten inside. | It was after a priest of the gods told %name% that the life of a fisherman was not what they desired of him, but that they wished for him to spill blood in their name, that he would set his eyes on another trade.} Visiting the tavern one evening, a new opportunity presented itself with the promise of coin for dangerous work.";
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));

		local helm =this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap]
		]);
		items.equip(helm);
	}
});