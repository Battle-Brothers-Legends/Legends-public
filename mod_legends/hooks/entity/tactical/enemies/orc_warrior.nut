::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function(o)
{
	o.onFactionChanged <- function ()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		flip = !flip;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarrior);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.1;
		}

		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_03_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_03_body");
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_03_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_03_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_03_head_injured");
		this.setAlwaysApplySpriteOffset(true);
		local v = 1;
		local v2 = -6;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a);
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		::Legends.Actives.grant(this, ::Legends.Active.LineBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.BatteringRam);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		::Legends.Actives.grant(this, ::Legends.Active.WakeAlly);
		::Legends.Effects.grant(this, ::Legends.Effect.Captain);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/legend_skin_flayer",
				"weapons/greenskins/orc_cleaver"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				[1, ::Legends.Armor.Greenskin.orc_warrior_light_armor],
				[1, ::Legends.Armor.Greenskin.orc_warrior_medium_armor],
				[1, ::Legends.Armor.Greenskin.orc_warrior_heavy_armor],
				[1, ::Legends.Armor.Greenskin.orc_warrior_heavy_armor]
			];
			local item = this.Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[1, ::Legends.Helmet.Greenskin.orc_warrior_light_helmet],
				[1, ::Legends.Helmet.Greenskin.orc_warrior_medium_helmet],
				[1, ::Legends.Helmet.Greenskin.orc_warrior_heavy_helmet]
			];
			local item = this.Const.World.Common.pickHelmet(helmet);
			this.m.Items.equip(item);
		}
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_orc_cleaver",
			"weapons/named/named_orc_axe"
		];
		local shields = [
			"shields/named/named_orc_heavy_shield"
		];

		if (this.Math.rand(1, 100) <= 80)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		return true;
	}
});
