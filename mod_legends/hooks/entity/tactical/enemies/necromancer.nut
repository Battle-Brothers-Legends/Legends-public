::mods_hookExactClass("entity/tactical/enemies/necromancer", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		setGender(this.m.Gender);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([0.5, "scripts/items/misc/legend_ancient_scroll_item"]);
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			"dagger",
			"knife",
			"butchers_cleaver",
			"scramasax"
		];
		this.m.Items.equip(this.new("scripts/items/weapons/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.ragged_dark_surcoat],
			[1, ::Legends.Armor.Standard.thick_dark_tunic]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.witchhunter_hat],
			[1, ::Legends.Helmet.Standard.dark_cowl],
			[1, ::Legends.Helmet.Standard.hood, 63]
		]);
		this.m.Items.equip(item);
	}

	o.setGender <- function (_gender = -1, _reroll = true)
	{
		if ("LegendMod" in this.World && ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled")
			_gender = 0;

		this.m.Gender = _gender;
		if(this.m.Gender == 1)
		{
			this.m.Faces = this.Const.Faces.NecromancerFemale;
			this.m.Beards = null;
			this.m.Bodies = this.Const.Bodies.NorthernFemale;
			this.m.BeardChance = 0;
			this.m.Hairs = this.Const.Hair.AllFemale;

			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}

			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.WomanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.WomanSounds[this.m.VoiceSet].Flee;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.WomanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(105, 115) * 0.01;
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_dagger"
		];

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Named.witchhunter_helm],
		]);
		this.m.Items.equip(item);

		weapons.extend([
			"weapons/named/named_dagger",
			"weapons/named/named_qatal_dagger"
		]);

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.ActionPoints = 9;
		this.m.BaseProperties.ActionPoints = 9;
		this.m.Skills.update();

		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([3, "scripts/items/misc/legend_ancient_scroll_item"]);
		return true;
	}
});
