::mods_hookExactClass("entity/tactical/enemies/vampire", function(o)
{
	o.m.IsLady <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		if(this.Math.rand(1, 100) <= 25)
		{
			this.m.IsLady = true;
		}
	}

	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Vampire);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_skeleton_body_05");
		body.setHorizontalFlipping(true);
		this.addSprite("old_body");
		this.addSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
		this.addSprite("armor");
		local body_detail = this.addSprite("body_detail");

		if (this.Math.rand(1, 100) <= 75)
		{
			body_detail.setBrush("bust_skeleton_detail_0" + this.Math.rand(2, 3));
		}

		local head = this.addSprite("head");
		head.setBrush("bust_skeleton_head_05");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		this.addSprite("old_head");
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_05_injured");
		local head_detail = this.addSprite("head_detail");

		if (this.Math.rand(1, 100) <= 50)
		{
			head_detail.setBrush("bust_skeleton_head_detail_01");
		}

		local beard = this.addSprite("beard");
		beard.setBrightness(0.7);
		beard.varyColor(0.02, 0.02, 0.02);
		local hair = this.addSprite("hair");
		hair.Color = beard.Color;

		if (this.Math.rand(1, 100) <= 75)
		{
			local idx = this.Math.rand(0, this.Const.Hair.Vampire.len());
			if (idx = this.Const.Hair.Vampire.len())
			{
				hair.setBrush("bust_vampire_lord_hair_01")
			}
			else
			{
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Vampire[idx]);
			}
		}

		this.setSpriteOffset("hair", this.createVec(0, -3));
		local v = -3;
		local v2 = 0;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
			this.setSpriteOffset(a, this.createVec(v2, v));
		}
		this.addSprite("accessory");
		this.addSprite("accessory_special");

		local beard_top = this.addSprite("beard_top");

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = this.Math.rand(1, 100) <= 33;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;

		if (this.m.IsLady) //hides the beard if it's a female
		{
			this.getSprite("body").setBrush("bust_vampire_lady_body_01");
			this.getSprite("head").setBrush("bust_vampire_lady_head_01");
			beard.Alpha = 0;
			beard_top.Alpha = 0;
		}

		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/racial/vampire_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/darkflight"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HeadHunter);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Fearsome);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBloodbath);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Nimble);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = ++i )
			{
				local r = this.Math.rand(1, 100);
				local loot;
				if (r <= 5)
				{
					loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
					loot.drop(_tile);
				}
			}
		}
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_khopesh"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_crypt_cleaver"));
		}
	}

	local onFactionChanged = o.onFactionChanged;
	o.onFactionChanged = function ()
	{
		onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
				continue;
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}
});
