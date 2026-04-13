this.legend_apothecary_mushrooms_skill <- this.inherit("scripts/skills/actives/base/legend_eat_skill", {
	m = {},

	function create()
	{
		this.legend_eat_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendApothecaryMushrooms);
		this.m.Description = "Give these strange mushrooms to an adjacent ally, or eat them yourself to enter a state of trance-like state with otherworldy dodging and no sense of pain. May result in sickness. The effect will slowly wear off over 4 turns. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_98.png";
		this.m.IconDisabled = "skills/active_98_sw.png";
		this.m.Overlay = "active_98";
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
				icon = "ui/icons/regular_damage.png",
				text = "Grants [color=%negative%]-40%[/color] Damage in Melee"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Grants [color=%positive%]+40%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Grants [color=%positive%]+40%[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
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

	function onUse( _user, _targetTile )
	{
		local user = _targetTile.getEntity();

		if (_user.getID() == user.getID())
		{
			local shrooms = ::Legends.Effects.get(user, ::Legends.Effect.LegendApothecaryMushrooms);

			if (shrooms != null)
			{
				shrooms.resetTime();
			}
			else
			{
				::Legends.Effects.grant(user, ::Legends.Effect.LegendApothecaryMushrooms);
			}

			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " eats Magic Mushrooms");
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
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives Magic Mushrooms to " + this.Const.UI.getColorizedEntityName(user));
			}

			this.spawnIcon("status_effect_67", _targetTile);
			this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}

});

