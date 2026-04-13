this.legend_drink_alcohol_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		Effect = null,
	},

	function setItem( _i ) {
		this.m.Item = this.WeakTableRef(_i);
	}

	function create() {
		this.m.SoundOnUse = [
			"sounds/combat/drink_01.wav",
			"sounds/combat/drink_02.wav",
			"sounds/combat/drink_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 1;
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function getCursorForTile( _tile ) {
		if (_tile.ID == this.getContainer().getActor().getTile().ID)
			return this.Const.UI.Cursor.Drink;
		return this.Const.UI.Cursor.Give;
	}

	function isUsable() {
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile ) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
			return false;

		if (target.getID() != _originTile.getEntity().getID() && !target.getItems().hasEmptySlot(this.Const.ItemSlot.Bag))
			return false;

		if (!target.getFlags().has("human"))
			return false;

		return true;
	}


	function onUse( _user, _targetTile ) {
		local user = _targetTile.getEntity();

		if (_user.getID() == user.getID()) {
			if (user.getSkills().hasSkill("injury.severe_concussion") && user.getSkills().hasSkill("injury.sickness") && user.getSkills().hasSkill("injury.weakened_heart"))
				user.getSkills().add(this.new("scripts/skills/injury_permanent/brain_damage_injury"));

			if (user.getSkills().hasSkill("injury.severe_concussion") && user.getSkills().hasSkill("injury.sickness"))
				user.getSkills().add(this.new("scripts/skills/injury_permanent/weakened_heart_injury"));

			if (user.getSkills().hasSkill("injury.sickness"))
				user.getSkills().add(this.new("scripts/skills/injury/severe_concussion_injury"));
			else if (user.getSkills().hasEffect(::Legends.Effect.Drunk))
				user.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
			else if (::Legends.Food.isTipsy(user))
				::Legends.Effects.grant(user, ::Legends.Effect.Drunk);
			else if (this.m.Effect != null)
				::Legends.Effects.grant(user, this.m.Effect);

			if (!user.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.tacticalLogDrink(user));

			if (this.m.Item != null && !this.m.Item.isNull())
				this.m.Item.removeSelf();

			this.Const.Tactical.Common.checkDrugEffect(user);
		} else {
			if (!_user.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.tacticalLogGive(_user, user));

			this.spawnIcon("status_effect_93", _targetTile);
			this.Sound.play("sounds/combat/drink_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}
		return true;
	}

	function tacticalLogDrink(_user) {
		return "";
	}

	function tacticalLogGive(_user, _target) {
		return "";
	}
});
