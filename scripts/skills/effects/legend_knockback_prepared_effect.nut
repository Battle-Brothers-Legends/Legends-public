this.legend_knockback_prepared_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendKnockbackPrepared);
		this.m.Description = "This character is ready to deal a strong blow that will push the target back and baffle them if it connects.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onAdded() {
		if (this.getContainer().getActor().isPlacedOnMap()) {
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());
		}
		this.onRefresh();
	}

	function onRefresh() {
		this.m.AttacksLeft = 1;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (!_skill.m.IsAttack) {
			return;
		}

		local item = _skill.getItem();
		if (_skill.isRanged() && item != null && !item.isWeaponType(::Const.Items.WeaponType.Throwing)) {
			return;
		}

		if (--this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}

		if (::Legends.S.isEntityNullOrDead(_targetEntity)) {
			return;
		}

		if (!_targetEntity.getCurrentProperties().IsImmuneToDaze) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendBaffled);
			local actor = this.getContainer().getActor();
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " baffled");
			}
		}
	}

	function onTargetMissed(_skill, _targetEntity) {
		if (!_skill.m.IsAttack || _skill.isRanged()) {
			return;
		}

		if (--this.m.AttacksLeft <= 0) {
			this.removeSelf();
		}
	}

	function findTileToKnockBackTo(_userTile, _targetTile) {
		local direction = _userTile.getDirectionTo(_targetTile);
		foreach (dir in [direction, (direction - 1) % 6, (direction + 1) % 6]) {
			if (_targetTile.hasNextTile(dir)) {
				local knockToTile = _targetTile.getNextTile(dir);
				if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1) {
					return knockToTile;
				}
			}
		}
		return null;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "The next [color=%positive%]" + this.m.AttacksLeft + "[/color] attack will attempt to knock back the target.";
	}
});
