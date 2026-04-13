this.legend_leap_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLeap);
		this.m.Description = "Learning to jump extended distances allows escape from usually impossible situations. Fatigue cost is 15 plus the weight of your armor. Range can be increased with the Backflip perk, and by taking Staff Mastery and wielding a staff.";
		this.m.Icon = "skills/leap_square.png";
		this.m.IconDisabled = "skills/leap_square_bw.png";
		this.m.Overlay = "horse_pirouette";
		this.m.SoundOnUse = [
			"sounds/combat/jump_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 2;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			if (item.isWeaponType(this.Const.Items.WeaponType.Staff) && actor.getCurrentProperties().IsSpecializedInPolearms)
			{
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Leap range increased by 1 tile while wielding a staff and having staff mastery"
				});
			}
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}

	function getModifier()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = fat * -1;

		return fat;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local fat = this.getModifier();
		local bonus = 0;
		if (item != null)
		{
			if (item.isWeaponType(this.Const.Items.WeaponType.Staff) && actor.getCurrentProperties().IsSpecializedInPolearms)
			{
				bonus += 1;
			}
		}

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip))
		{
			bonus += 1;
		}

		this.m.MaxRange = 2 + bonus;

		this.m.FatigueCost = 15 + fat;

	}

	function isUsable()
	{
		if ( !this.getContainer().getActor().getCurrentProperties().IsRooted)
		{

			return true;

		}
		else
		{
			return false;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}

});

