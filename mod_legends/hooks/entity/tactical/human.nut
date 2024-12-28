::mods_hookExactClass("entity/tactical/human", function(o)
{

	o.m.Outfits <- [];  //Always overridden if it's used
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Gender = -1;
	}

	o.getPronoun <- function (_neuter)
	{
		return this.Const.LegendMod.getPronoun(this.getGender(), _neuter);
	}

	// -1 = Default Male, 0 = Male, 1 = Female
	o.getGender <- function ()
	{
		return this.m.Gender;
	}

	o.setGender <- function ( _v, _reroll = true)
	{
		if ("LegendMod" in this.World && ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled")
			_v = 0;

		this.m.Gender = _v;
		if(this.m.Gender == 1)
		{
			this.m.Faces = this.Const.Faces.AllFemale;
			this.m.Beards = null;
			this.m.Bodies = this.Const.Bodies.AllFemale;
			this.m.BeardChance = 0;
			this.m.Hairs = this.Const.Hair.AllFemale;
			if (this.m.Ethnicity == 1)
			{
				this.m.Bodies = this.Const.Bodies.SouthernFemale;
				this.m.Faces = this.Const.Faces.SouthernFemale;
				this.m.Hairs = this.Const.Hair.SouthernFemale;
				this.m.HairColors = this.Const.HairColors.Southern;
			}

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
		else
		{
			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.HumanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}
			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.HumanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		}

		this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] = 1.4;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.1;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Fatigue] = 0.95;
	}

	o.playSound = function ( _type, _volume, _pitch = 1.0 )
	{
		if (this.m.Sound[_type].len() == 0)
		{
			return;
		}

		local volume = 1.0;
		if(this.m.Gender == 1)
		{
			if (this.m.VoiceSet > this.Const.WomanSounds.len() - 1)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
			volume *= this.Const.WomanSounds[this.m.VoiceSet].Volume
		}
		else
		{
			volume *= this.Const.HumanSounds[this.m.VoiceSet].Volume
		}

		this.Sound.play(this.m.Sound[_type][this.Math.rand(0, this.m.Sound[_type].len() - 1)], volume, this.getPos(), _pitch);
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath(_killer, _skill, _tile, _fatalityType);

		if (_tile != null)
			_tile.Properties.get("Corpse").isHuman = 1;
	}

	local onFactionChanged = o.onFactionChanged;
	o.onFactionChanged = function()
	{
		onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("permanent_injury_scarred").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_burned").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak_front").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);

		this.getSprite("helmet_vanity_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_lower_2").setHorizontalFlipping(flip);
		this.getSprite("helmet_helm").setHorizontalFlipping(flip);
		this.getSprite("helmet_top").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_2").setHorizontalFlipping(flip);
	}

	o.onInit = function ()
	{
		if (this.m.Body >= this.m.Bodies.len()){
			this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
		}
		this.actor.onInit();
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local app = this.getItems().getAppearance();
		app.Quiver = this.Const.Items.Default.PlayerQuiver;
		app.Body = this.m.Bodies[this.m.Body];
		app.Corpse = this.m.Bodies[this.m.Body] + "_dead";
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_player");
		this.addSprite("quiver");
		local body = this.addSprite("body");
		body.setBrush(this.m.Bodies[this.m.Body]);
		this.addSprite("tattoo_body");
		this.addSprite("scar_body");
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_naked_body_0" + this.m.Body + "_injured");
		this.addSprite("armor");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("surcoat");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_layer_cloak_front");	// Usually this should be below the helmets. But most Layer-5-Upgrades only consist of a back-piece which would make a two-piece cloak look very weird.
		this.addSprite("armor_upgrade_back");
		local bandage2 = this.addSprite("bandage_2");
		bandage2.Visible = false;
		bandage2.setBrush("bandage_clean_02");
		local bandage3 = this.addSprite("bandage_3");
		bandage3.Visible = false;
		bandage3.setBrush("bandage_clean_03");
		this.addSprite("shaft");
		this.addSprite("head");
		local eye_rings = this.addSprite("eye_rings");
		eye_rings.setBrush("bust_eye_rings");
		eye_rings.Visible = false;
		local closed_eyes = this.addSprite("closed_eyes");
		closed_eyes.setBrush("sleep_eyes");
		closed_eyes.Visible = false;
		this.addSprite("tattoo_head");
		this.addSprite("scar_head");
		this.addSprite("injury").Visible = false;
		this.addSprite("permanent_injury_3");
		this.addSprite("permanent_injury_2");
		this.addSprite("permanent_injury_scarred");
		this.addSprite("permanent_injury_burned");
		this.addSprite("beard");
		this.addSprite("hair");
		this.addSprite("permanent_injury_4");
		this.addSprite("permanent_injury_1");

		this.addSprite("accessory");
		this.addSprite("accessory_special");
		this.addSprite("beard_top");

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}

		this.addSprite("armor_upgrade_front");
		local bandage1 = this.addSprite("bandage_1");
		bandage1.Visible = false;
		bandage1.setBrush("bandage_clean_01");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_demon_hound_aura_effect"));
	}

	o.setArmorAlpha <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	o.setArmorSaturation <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Saturation = level;
		}
	}

	o.setArmorBrightness <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setBrightness(level);
		}
	}

	o.setBrushAlpha <- function (level)
	{
		this.setArmorAlpha(10);
		foreach (a in this.Const.CharacterSprites.Human)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	o.onSerialize = function ( _out )
	{
		this.actor.onSerialize(_out);
		if (this.m.Surcoat != null)
		{
			_out.writeU8(this.m.Surcoat);
		}
		else
		{
			_out.writeU8(0);
		}

		_out.writeU8(this.m.Ethnicity);
		_out.writeU8(this.m.Gender);
		_out.writeU8(this.m.VoiceSet);
		_out.writeU8(this.m.Body);
	}

	o.onDeserialize = function ( _in )
	{
		this.actor.onDeserialize(_in);
		this.m.Surcoat = _in.readU8();

		if (this.m.Surcoat == 0)
		{
			this.m.Surcoat = null;
		}

		this.m.Ethnicity = _in.readU8();
		this.m.Gender = _in.readU8();
		this.m.VoiceSet = _in.readU8();
		this.m.Body = _in.readU8();
		this.setGender(this.m.Gender, false)
	}
});
