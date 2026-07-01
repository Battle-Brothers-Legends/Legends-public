::mods_hookExactClass("entity/tactical/enemies/vampire", function(o)
{
	o.m.IsLady <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsLady = this.Math.rand(1, 100) <= 50;

		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.push([0.5, "scripts/items/misc/legend_ancient_scroll_item"]);
		}
	}

	o.onUpdateInjuryLayer = function ()
	{
		local p = this.getHitpointsPct();
		local bodyBrush = this.getSprite("body").getBrush().Name;
		local headBrush = this.getSprite("head").getBrush().Name;

		if (p <= 0.33)
		{
			this.getSprite("body").setBrush("bust_skeleton_body_03");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_03_injured");
			this.getSprite("head").setBrush("bust_skeleton_head_03");
			this.getSprite("injury").setBrush("bust_skeleton_head_03_injured");
		}
		else if (p <= 0.66)
		{
			this.getSprite("body").setBrush("bust_skeleton_body_04");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_04_injured");
			this.getSprite("head").setBrush("bust_skeleton_head_04");
			this.getSprite("injury").setBrush("bust_skeleton_head_04_injured");
		}
		else if (this.m.IsLady == true)
		{
			this.getSprite("body").setBrush("bust_vampire_lady_body_01");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
			this.getSprite("head").setBrush("bust_vampire_lady_head_01");
			this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
		}
		else
		{
			this.getSprite("body").setBrush("bust_skeleton_body_05");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
			this.getSprite("head").setBrush("bust_skeleton_head_05");
			this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
		}

		this.getSprite("body_injury").Visible = this.m.WasInjured;
		this.getSprite("injury").Visible = this.m.WasInjured;

		if (bodyBrush != this.getSprite("body").getBrush().Name)
		{
			local old_body = this.getSprite("old_body");
			old_body.Visible = true;
			old_body.Alpha = 255;
			old_body.setBrush(bodyBrush);
			old_body.fadeOutAndHide(3000);
			local old_head = this.getSprite("old_head");
			old_head.Visible = true;
			old_head.Alpha = 255;
			old_head.setBrush(headBrush);
			old_head.fadeOutAndHide(3000);
		}

		this.setDirty(true);
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
			this.m.IsLady ? body_detail.setBrush("bust_vampire_lady_detail_0" + this.Math.rand(1, 2)) : body_detail.setBrush("bust_skeleton_detail_0" + this.Math.rand(2, 3));
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
			this.m.IsLady ? head_detail.setBrush("bust_vampire_head_lady_detail_01") : head_detail.setBrush("bust_skeleton_head_detail_01");
		}

		local beard = this.addSprite("beard");
		beard.setBrightness(0.7);
		beard.varyColor(0.02, 0.02, 0.02);
		local hair = this.addSprite("hair");
		hair.Color = beard.Color;

		if (this.Math.rand(1, 100) <= 75 && !this.m.IsLady)
		{
			local idx = this.Math.rand(0, this.Const.Hair.Vampire.len() - 1);
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Vampire[idx]);
		}
		else if (this.Math.rand(1, 100) <= 67 && this.m.IsLady)
		{
			local idx = this.Math.rand(0, this.Const.Hair.VampireLady.len() - 1);
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.VampireLady[idx]);
		}

		this.setSpriteOffset("hair", this.createVec(0, -3));
		local v = -3;
		local v2 = 0;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a);
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

		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialVampire);
		::Legends.Actives.grant(this, ::Legends.Active.Darkflight);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendWindReader);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/named/named_khopesh"],
			[2, "weapons/named/named_crypt_cleaver"]
		], "scripts/items/"));
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
