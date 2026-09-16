this.legend_drink_potion_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		Effects = [],
		StatusEffect = null
	},

	function setItem( _i ) {
		this.m.Item = this.WeakTableRef(_i);
	}

	function create() {
		this.m.StatusEffect = "status_effect_93";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/drink", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
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

		if (::Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
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
			return ::Const.UI.Cursor.Drink;
		return ::Const.UI.Cursor.Give;
	}

	function isUsable() {
		return !::Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile ) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
			return false;

		if (target.getID() != _originTile.getEntity().getID() && !target.getItems().hasEmptySlot(::Const.ItemSlot.Bag))
			return false;

		if (!target.getFlags().has("human"))
			return false;

		return true;
	}

	function onUse( _user, _targetTile ) {
		local user = _targetTile.getEntity();
		if (_user.getID() == user.getID()) {
			foreach (effect in this.m.Effects)
				user.getSkills().add(this.new("scripts/skills/effects/" + effect));

			if (!user.isHiddenToPlayer())
				::Tactical.EventLog.log(tacticalLogDrink(user));

			if (this.m.Item != null && !this.m.Item.isNull())
				this.m.Item.removeSelf();

			::Const.Tactical.Common.checkDrugEffect(user);
		} else {
			if (!_user.isHiddenToPlayer())
				::Tactical.EventLog.log(tacticalLogGive(_user, user));

			this.spawnIcon(this.m.StatusEffect, _targetTile);
			::Sound.play("sounds/bottle_01.wav", ::Const.Sound.Volume.Inventory);
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
