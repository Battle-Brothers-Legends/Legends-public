this.legend_leap_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLeap);
		this.m.Description = "Jump over distance or obstacles and unsuspecting enemies to gain tactical advantage.";
		this.m.Icon = "skills/leap_square.png";
		this.m.IconDisabled = "skills/leap_square_bw.png";
		this.m.Overlay = "leap";
		this.m.SoundOnUse = ["sounds/combat/jump_01.wav"];
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

	function getTooltip() {
		local ret = this.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsRooted) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot be used while rooted[/color]"
			});
		}

		local extraFatigueCost = getModifier();
		if(extraFatigueCost > 0)
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue cost increased by [color=%negative%]" + extraFatigueCost + "[/color] due to equipped armor's weight"
			});
		return ret;
	}

	function getModifier() {
		local extraFatigueCost = 0;
		local actor = this.getContainer().getActor();
		local armor = [
			actor.getItems().getItemAtSlot(::Const.ItemSlot.Body),
			actor.getItems().getItemAtSlot(::Const.ItemSlot.Head)
		];

		foreach (piece in armor) {
			extraFatigueCost -= piece != null ? piece.getStaminaModifier() : 0;
		}

		return extraFatigueCost;
	}

	function onAfterUpdate(_properties) {
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		this.m.MaxRange = 2 + (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip) ? 1 : 0) + (item != null && item.isWeaponType(::Const.Items.WeaponType.Staff) && actor.getCurrentProperties().IsSpecializedInPolearms ? 1 : 0);
		this.m.FatigueCost = 15 + this.getModifier();
	}

	function isUsable() {
		if (::Tactical.isActive() && ::Tactical.State.getStrategicProperties() != null && ::Tactical.State.getStrategicProperties().IsArenaMode) {
			return false;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted) {
			return false;
		}

		return true;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		if (!_targetTile.IsEmpty) {
			return false;
		}

		return true;
	}

	function onUse(_user, _targetTile) {
		::Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}
});
