::mods_hookExactClass("entity/tactical/enemies/orc_young", function(o)
{
	o.onFactionChanged <- function ()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		flip = !flip;
		local v = -3;
		local v2 = -3;
		foreach (a in ::Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
			this.setSpriteOffset(a, this.createVec(flip ? v2 : -v2, v));
		}
	}

	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.OrcYoung);

		if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Orcs.YoungThrowingSpecDay) {
			b.IsSpecializedInThrowing = true;

			if (::World.getTime().Days >= ::Const.World.Scaling.Orcs.YoungStatIncreaseDay) {
				b.RangedSkill += 5;
			}
		}

		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_01_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_01_body");
		body.varySaturation(0.05);
		body.varyColor(0.07, 0.07, 0.07);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_01_head_0" + ::Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_01_head_injured");
		this.setAlwaysApplySpriteOffset(true);
		local v = -3;
		local v2 = -3;
		foreach (a in ::Const.CharacterSprites.Helmets)
		{

			this.addSprite(a);
			this.setSpriteOffset(a, this.createVec(v2, v));

		}
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_01_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		::Legends.Actives.grant(this, ::Legends.Active.Charge);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPugilist);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		::Legends.Actives.grant(this, ::Legends.Active.WakeAlly);
		::Legends.Effects.grant(this, ::Legends.Effect.Captain);
		::Legends.Effects.grant(this, ::Legends.Effect.BerserkerRage);
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType ) {
		this.legend_orc.onDeath( _killer, _skill, _tile, _fatalityType );
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local weapon;

		r = ::Math.rand(1, 100);
		if (r <= 30)
		{
			r = ::Math.rand(1, 2);
			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/legend_orc_throwing_spear"));
			}
		}

		if (::Math.rand(1, 100) <= 75)
		{
			if (::Math.rand(1, 100) <= 75)
			{
				r = ::Math.rand(1, 3);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_axe");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				}
					else if (r == 3)
				{
					weapon = this.new("scripts/items/weapons/greenskins/legend_skin_flayer");
				}
			}
			else
			{
				r = ::Math.rand(1, 2);
				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_wooden_club");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_metal_club");
				}
			}
		}
		else
		{
			r = ::Math.rand(1, 4);

			if (r == 1)
			{
				weapon = this.new("scripts/items/weapons/greenskins/goblin_falchion");
			}
			else if (r == 2)
			{
				weapon = this.new("scripts/items/weapons/morning_star");
			}
			else if (r == 3)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_meat_hacker");
			}
				else if (r == 4)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_bone_carver");
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		local item = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.orc_young_light_armor],
			[1, ::Legends.Armor.Greenskin.orc_young_medium_armor],
			[1, ::Legends.Armor.Greenskin.orc_young_heavy_armor],
			[1, ::Legends.Armor.None]
		]);
		this.m.Items.equip(item);

		local item = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.orc_young_light_helmet],
			[1, ::Legends.Helmet.Greenskin.orc_young_medium_helmet],
			[1, ::Legends.Helmet.Greenskin.orc_young_heavy_helmet]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
