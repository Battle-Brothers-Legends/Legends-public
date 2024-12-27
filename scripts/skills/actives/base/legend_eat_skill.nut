this.legend_eat_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		Amount = 0
	},

	function setItem (_i) {
		this.m.Item = this.WeakTableRef(_i);
	}

	function setAmount(_a) {
		this.m.Amount = _a;
	}

	function create() {
		this.m.Overlay = "active_144";
		this.m.SoundOnUse = [
			"sounds/combat/eat_01.wav"
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

	function getCursorForTile( _tile ) {
		if (_tile.ID == this.getContainer().getActor().getTile().ID)
			return this.Const.UI.Cursor.Drink;
		return this.Const.UI.Cursor.Give;
	}

	function isUsable() {
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
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

});
