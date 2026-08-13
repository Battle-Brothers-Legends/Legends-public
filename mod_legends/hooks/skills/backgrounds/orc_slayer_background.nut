::mods_hookExactClass("skills/backgrounds/orc_slayer_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.OrcSlayer);
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = 9;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader;
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onBuildDescription <- function ()
	{
		return "%name% doesn\'t talk much about himself. He just wants to kill orcs and goblins which, given the state of things, makes him a perfect fit for the company. If he\'s true to his word, he\'ll leave as soon as the invasion is taken care of.";
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.OrcSlayer);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Orc Slayer");
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/two_handed_hammer"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]))
	}

});
