this.legend_eat_porridge_skill <- this.inherit("scripts/skills/actives/base/legend_eat_skill", {
	m = {},

	function create()
	{
		this.legend_eat_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEatPorridge);
		this.m.Description = "Give to an adjacent ally or eat yourself a porridge that slowly recovers hitpoints. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/porridge_square.png";
		this.m.IconDisabled = "skills/porridge_square_bw.png";
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
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints per turn for 15 turns"
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

	function onUse( _user, _targetTile )
	{
		local user = _targetTile.getEntity();

		if (_user.getID() == user.getID())
		{
			::Legends.Effects.grant(user, ::Legends.Effect.LegendPorridgeEffect);

			if (!user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " eats porridge");
			}

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			this.Const.Tactical.Common.checkDrugEffect(user);
		}
		else
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives porridge to " + this.Const.UI.getColorizedEntityName(user));
			}

			this.spawnIcon("status_effect_93", _targetTile);
			this.Sound.play("sounds/combat/eat_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}

});

