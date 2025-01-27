this.legend_pass_skill <- this.inherit("scripts/skills/skill", {


	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPass);
		this.m.Description = "Give the first item in your bag to an adjacent ally. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/pass.png";
		this.m.IconDisabled = "skills/pass_bw.png";
		this.m.Overlay = "active_pass";
		this.m.SoundOnUse = [
			"sounds/cloth_01.wav"
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
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Passes the first item in your bag to an ally"
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function getCursorForTile( _tile )
	{
		return this.Const.UI.Cursor.Give;

	}

	function isUsable()
	{
		if (!this.Tactical.isActive())
		{
			return false;
		}
		local item = this.getContainer().getActor().getItems().getItemAtBagSlot(0);

		if (item = null)
		{
			return false;
		}
		local tile = this.getContainer().getActor().getTile();
		return this.skill.isUsable() && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile )
	{

		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}



		local target = _targetTile.getEntity();
		local user = _originTile.getEntity();
		local item = user.getItems().getItemAtBagSlot(0);

		if (item = null)
		{
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getID() != user.getID())
		{
			if (!target.getItems().hasEmptySlot(this.Const.ItemSlot.Bag))
			{
				return false;
			}

			return true;
		}
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local item = this.getContainer().getActor().getItems().getItemAtBagSlot(0);
		local itemName = item.getName();

		this.spawnIcon("status_helpful", _targetTile);

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives " + itemName + " to " + this.Const.UI.getColorizedEntityName(target));
		}

		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);

		_user.getItems().removeFromBag(item);
		target.getItems().addToBag(item);

		return true;
	}

});

