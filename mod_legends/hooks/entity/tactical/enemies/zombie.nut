::mods_hookExactClass("entity/tactical/enemies/zombie", function(o)
{
	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Zombie);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
		}
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local app = this.getItems().getAppearance();
		app.Body = "bust_naked_body_0" + this.Math.rand(0, 2);
		app.Corpse = app.Body + "_dead";
		this.m.InjuryType = this.Math.rand(1, 4);
		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("quiver").setHorizontalFlipping(true);
		local body = this.addSprite("body");
		body.setHorizontalFlipping(true);
		body.setBrush(this.Const.Items.Default.PlayerNakedBody);
		body.Saturation = 0.5;
		body.varySaturation(0.2);
		body.Color = this.createColor("#c1ddaa");
		body.varyColor(0.05, 0.05, 0.05);
		local tattoo_body = this.addSprite("tattoo_body");
		tattoo_body.setHorizontalFlipping(true);
		tattoo_body.Saturation = 0.9;
		tattoo_body.setBrightness(0.75);
		local body_injury = this.addSprite("body_injury");
		body_injury.Visible = true;
		body_injury.setBrightness(0.75);
		body_injury.setBrush("zombify_body_01");
		this.addSprite("armor").setHorizontalFlipping(true);
		this.addSprite("armor_layer_chain").setHorizontalFlipping(true);
		this.addSprite("armor_layer_plate").setHorizontalFlipping(true);
		this.addSprite("armor_layer_tabbard").setHorizontalFlipping(true);
		this.addSprite("armor_layer_cloak").setHorizontalFlipping(true);
		this.addSprite("armor_upgrade_back").setHorizontalFlipping(true);
		this.addSprite("surcoat");
		this.addSprite("armor_upgrade_front");
		local body_blood_always = this.addSprite("body_blood_always");
		body_blood_always.setBrush("bust_body_bloodied_01");
		this.addSprite("shaft");
		local head = this.addSprite("head");
		head.setHorizontalFlipping(true);
		head.setBrush(this.Const.Faces.AllHuman[this.Math.rand(0, this.Const.Faces.AllHuman.len() - 1)]);
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local tattoo_head = this.addSprite("tattoo_head");
		tattoo_head.setHorizontalFlipping(true);
		tattoo_head.Saturation = 0.9;
		tattoo_head.setBrightness(0.75);
		local beard = this.addSprite("beard");
		beard.setHorizontalFlipping(true);
		beard.varyColor(0.02, 0.02, 0.02);

		if (this.Math.rand(1, 100) <= 50)
		{
			if (this.m.InjuryType == 4)
			{
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieExtended[this.Math.rand(0, this.Const.Beards.ZombieExtended.len() - 1)]);
				beard.setBrightness(0.9);
			}
			else
			{
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.Zombie[this.Math.rand(0, this.Const.Beards.Zombie.len() - 1)]);
			}
		}

		local injury = this.addSprite("injury");
		injury.setHorizontalFlipping(true);
		injury.setBrush("zombify_0" + this.m.InjuryType);
		injury.setBrightness(0.75);
		local hair = this.addSprite("hair");
		hair.setHorizontalFlipping(true);
		hair.Color = beard.Color;

		if (this.Math.rand(0, this.Const.Hair.Zombie.len()) != this.Const.Hair.Zombie.len())
		{
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Zombie[this.Math.rand(0, this.Const.Hair.Zombie.len() - 1)]);
		}

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a).setHorizontalFlipping(true);
		}

		local beard_top = this.addSprite("beard_top");
		beard_top.setHorizontalFlipping(true);

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}

		// this.addSprite("armor_upgrade_front"); already doing this above
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = this.Math.rand(1, 100) <= 33;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = this.Math.rand(1, 100) <= 50;
		local rage = this.addSprite("status_rage");
		rage.setHorizontalFlipping(true);
		rage.setBrush("mind_control");
		rage.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("arms_icon").setBrightness(0.85);
		this.getSprite("status_rooted").Scale = 0.55;

		this.setHitpoints(this.getHitpointsMax() * this.Math.rand(45, 100) * 0.01);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		}
	}

	o.assignRandomEquipment = function ()
	{

		if (this.Math.rand(1, 100) <= 50) {
			// Make sure not to include weapons that only have 6AP skills
			// in this list, as zombies only have 5AP.
			local weapons = [
				"weapons/knife",
				"weapons/bludgeon",
				"weapons/militia_spear",
				"weapons/pickaxe",
				"weapons/butchers_cleaver",
				"weapons/legend_hammer",
				"weapons/legend_shovel",
				"weapons/legend_tipstaff",
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local aList = [
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.apron],
			[1, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.monk_robe]
		];
		local armor = this.Const.World.Common.pickArmor(aList);

		if (this.Math.rand(1, 100) <= 50)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 33)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.kettle_hat],
				[1, ::Legends.Helmet.Standard.padded_kettle_hat],
				[1, ::Legends.Helmet.Standard.full_leather_cap]
			]);
			if (item != null)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					item.setArmor(item.getArmorMax() / 2 - 1);
				}
			}

			this.m.Items.equip(item);
		}
	}

	o.onFactionChanged = function ()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("tattoo_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("tattoo_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("status_rage").setHorizontalFlipping(flip);
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}
});
