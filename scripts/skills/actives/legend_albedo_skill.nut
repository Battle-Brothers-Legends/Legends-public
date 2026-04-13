this.legend_albedo_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendAlbedo);
		this.m.Description = "Repair up to 25 armor.";
		this.m.Icon = "skills/repair_square.png";
		this.m.IconDisabled = "skills/repair_square_bw.png";
		this.m.Overlay = "active_41";
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
		this.m.IsVisibleTileNeeded = false;
		this.m.IsUsingHitchance = false;
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
		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
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

		local currentHeadArmor = target.getArmor(this.Const.BodyPart.Head);
		local currentBodyArmor = target.getArmor(this.Const.BodyPart.Body);
		local maxHeadArmor = target.getArmorMax(this.Const.BodyPart.Head);
		local maxBodyArmor = target.getArmorMax(this.Const.BodyPart.Body);
		local missingHeadArmor = maxHeadArmor - currentHeadArmor;
		local missingBodyArmor = maxBodyArmor - currentBodyArmor;
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

		local body = target.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = target.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local currentHeadArmor = 0;
		local maxHeadArmor = 0;
		if (head != null)
		{
			currentHeadArmor = head.getArmor();
			maxHeadArmor = head.getArmorMax();
		}
		local currentBodyArmor = 0;
		local maxBodyArmor = 0;
		if (body != null)
		{
			currentBodyArmor = body.getArmor();
			maxBodyArmor = body.getArmorMax();
		}
		local missingHeadArmor = maxHeadArmor - currentHeadArmor;
		local missingBodyArmor = maxBodyArmor - currentBodyArmor;
		local maxRepair = 25;

		if (missingHeadArmor + missingBodyArmor <= maxRepair)
		{
			if (missingHeadArmor > 0)
			{
				head.setArmor(this.Math.minf(maxHeadArmor, currentHeadArmor + missingHeadArmor))
			}

			if (missingBodyArmor > 0)
			{
				body.setArmor(this.Math.minf(maxBodyArmor, currentBodyArmor + missingBodyArmor))
			}
			local cost = (missingHeadArmor + missingBodyArmor) * -1.0;
			return;
		}

		local maxHeadRepair = maxRepair / 2.0;
		local maxBodyRepair = maxRepair / 2.0;
		local headLeftOver = maxHeadRepair;
		local bodyLeftOver = maxBodyRepair;

		if (missingHeadArmor > 0)
		{
			maxBodyRepair += this.Math.maxf(0, maxHeadRepair - missingHeadArmor);
		}
		else
		{
			maxBodyRepair += maxHeadRepair;
		}

		if (missingBodyArmor > 0)
		{
			maxHeadRepair += this.Math.maxf(0, maxBodyRepair - missingBodyArmor);
		}
		else
		{
			maxHeadRepair += maxBodyRepair;
		}

		if (maxHeadRepair > 0)
		{
			head.setArmor(this.Math.minf(maxHeadArmor, currentHeadArmor + maxHeadRepair))
		}

		if (maxBodyRepair > 0)
		{
			body.setArmor(this.Math.minf(maxBodyArmor, currentBodyArmor + maxBodyRepair))
		}
	}

});
