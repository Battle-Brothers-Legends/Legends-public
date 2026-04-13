this.legend_field_repairs_skill <- this.inherit("scripts/skills/skill", {
	m = {
		MaxTools = 4.0,
		RepairPerTool = 5.0
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFieldRepairs);
		this.m.Description = "Repair armor, costs 1 Armor Part for every " + this.m.RepairPerTool + " missing armor, up to " + this.m.MaxTools * this.m.RepairPerTool + " missing armor.";
		this.m.Icon = "skills/repair_square.png";
		this.m.IconDisabled = "skills/repair_square_bw.png";
		this.m.Overlay = "status_cart56";
		this.m.SoundOnUse = [
			"sounds/ambience/buildings/blacksmith_hammering_00.wav",
			"sounds/ambience/buildings/blacksmith_hammering_01.wav",
			"sounds/ambience/buildings/blacksmith_hammering_02.wav"
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
			text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color]."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You have [color=%positive%]" + this.Math.floor(this.World.Assets.getArmorParts()) + "[/color] tools."
		});
		local repairs = this.World.Assets.getArmorParts() * 5 ;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You can repair max [color=%positive%]" + this.Math.floor(repairs) +  "[/color] points of armor."
		});
		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false
		}
		if (this.World.Assets.getArmorParts() / 5.0 < 1)
		{
			return false
		}
		return true
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

		local headArmor = target.getArmor(this.Const.BodyPart.Head);
		local bodyArmor = target.getArmor(this.Const.BodyPart.Body);
		local maxHeadArmor = target.getArmorMax(this.Const.BodyPart.Head);
		local maxBodyArmor = target.getArmorMax(this.Const.BodyPart.Body);
		local missingHeadArmor = maxHeadArmor - headArmor;
		local missingBodyArmor = maxBodyArmor - bodyArmor;
		local missingArmor = missingHeadArmor + missingBodyArmor;

		if (missingArmor < 1)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		local head = target.getHeadItem();
		local headArmor = head == null ? 1 : head.getArmor();
		local maxHeadArmor = head == null ? 1 : head.getArmorMax();

		local body = target.getBodyItem();
		local bodyArmor = body == null ? 1 : body.getArmor();
		local maxBodyArmor = body == null ? 1 : body.getArmorMax();

		local cost = this.Math.minf((maxHeadArmor - headArmor + maxBodyArmor - bodyArmor) / this.m.RepairPerTool, this.Math.minf(this.m.MaxTools, this.World.Assets.getArmorParts()));
		// Cost is the number of tools we pay, aka; the amount of armor we're missing / RepairPerTool, the max number of tools we have, or MaxTools, whichever is smaller

		for (local i = 0; i < this.Math.ceil(cost * this.m.RepairPerTool); i = ++i)
		{
			if (headArmor + 1 / maxHeadArmor > bodyArmor + 1 / maxBodyArmor)
			{
				body.setArmor(this.Math.minf(maxBodyArmor, bodyArmor + 1));
				bodyArmor = body.getArmor();
			}
			else
			{
				head.setArmor(this.Math.minf(maxHeadArmor, headArmor + 1));
				headArmor = head.getArmor();
			}
		}

		target.setDirty(true);
		this.World.Assets.addArmorParts(cost * -1);
	}
});
