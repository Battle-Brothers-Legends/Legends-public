this.legend_field_triage_skill <- this.inherit("scripts/skills/skill", {
	m = {
	Cost = 0,
	Meds = 0
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFieldTriage);
		this.m.Description = "Heal a unit at a rate of 1 medicine for every 2 hitpoints. Heals up to 20 hitpoints per use.";
		this.m.Icon = "skills/triage_square.png";
		this.m.IconDisabled = "skills/triage_square_bw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
		"sounds/combat/first_aid_01.wav",
		"sounds/combat/first_aid_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 16;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip( )
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color], can only target damaged units."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=%positive%]" + this.World.Assets.getMedicine() + "[/color] medicine."
		});
		local hp = this.World.Assets.getMedicine() * 2 ;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/health.png",
			text = "You can heal up to [color=%positive%]" + this.Math.floor(hp) +  "[/color] Hitpoints."
		});
		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		if (this.World.Assets.getMedicine() < 1)
		{
			return false;
		}
		return true;
	}


	function onVerifyTarget( _originTile, _targetTile )
	{

		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		if (target == null)
		{
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getHitpoints() >= target.getHitpointsMax())
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local meds = this.World.Assets.getMedicine();
		local target = _targetTile.getEntity();
		local maxHeal = 20;
		if (meds < 10)
		{
		maxHeal = meds * 2;
		}
		local neededHeal = target.getHitpointsMax() - target.getHitpoints();

		local finalHeal = maxHeal;
		if (neededHeal < maxHeal)
		{
		local finalHeal = neededHeal;
		}

		local finalMeds = finalHeal / 2;

		local cost = this.Math.min(meds, finalMeds);
		this.World.Assets.addMedicine(cost * -1);
		target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + finalHeal));
		return true;
	}

});
