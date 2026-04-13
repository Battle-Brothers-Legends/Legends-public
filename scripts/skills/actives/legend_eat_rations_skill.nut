this.legend_eat_rations_skill <- this.inherit("scripts/skills/actives/base/legend_eat_skill", {
	m = {},

	function create()
	{
		this.legend_eat_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEatRations);
		this.m.Description = "Give to an adjacent ally or eat food that slowly recovers hitpoints. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/rations_square.png";
		this.m.IconDisabled = "skills/rations_square_bw.png";
	}

	function getTooltip()
	{
		local amount = this.m.Amount;
		local rations = null;
		if (this.Tactical.isActive())
		{
			rations = ::Legends.Effects.get(this, ::Legends.Effect.LegendRationsEffect);
			if (rations != null)
			{
				amount += rations.getAmount() - (10 - rations.getTurnsLeft());
			}
		}
		local rate = this.Math.max(1, this.Math.floor(amount / 10));
		if (rations != null)
		{
			rate *= 2;
		}

		local title = this.getName() + " (" + this.m.Item.getName() + " : " + this.m.Amount + " units)";


		local ret = [
			{
				id = 1,
				type = "title",
				text = title
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
				text = "On self, will restore [color=%positive%]+" + rate + "[/color] Hitpoints per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "On self, recovers fatigue by [color=%negative%]-" + rate + "[/color] per turn for ten turns"
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
		local target = _targetTile.getEntity();

		if (target == null)
		{
			return false;
		}

		if (target.getID() != _user.getID())
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives food to " + this.Const.UI.getColorizedEntityName(target));
			}

			this.spawnIcon("status_effect_93", _targetTile);
			this.Sound.play("sounds/combat/eat_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			target.getItems().addToBag(item);
			return true;
		}

		if (!_user.getSkills().hasEffect(::Legends.Effect.LegendSatiatedEffect))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes satiated");
			}

			::Legends.Effects.grant(_user, ::Legends.Effect.LegendSatiatedEffect);
			::Legends.Effects.grant(_user, ::Legends.Effect.LegendRationsEffect, function(_effect) {
				_effect.setAmount(this.m.Amount);
			}.bindenv(this));

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}
			//this.Const.Tactical.Common.checkDrugEffect(_user);
			return true;
		}

		//We are satiated at this point

		local rationsEffect = ::Legends.Effects.get(_user, ::Legends.Effect.LegendRationsEffect);

		if (!_user.getSkills().hasEffect(::Legends.Effect.LegendStuffedEffect))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes stuffed");
			}

			::Legends.Effects.grant(_user, ::Legends.Effect.LegendStuffedEffect);

			rationsEffect.addAmount(rationsEffect.getAmount() + this.m.Amount);
			rationsEffect.resetTurns();

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}
			//this.Const.Tactical.Common.checkDrugEffect(_user);
			return true;
		}


		//We are satiated and stuffed
		if (!_user.getSkills().hasSkill("injury.sickness"))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes sick");
			}

			_user.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));

			rationsEffect.addAmount(rationsEffect.getAmount() + this.m.Amount);
			rationsEffect.resetTurns();

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}
			return true;
		}

		//Ate while sick - we be fat now
		if (!_user.getSkills().hasTrait(::Legends.Trait.Fat))
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " eats food and becomes fat");
			}

			::Legends.Traits.grant(_user, ::Legends.Trait.Fat);
			rationsEffect.addAmount(rationsEffect.getAmount() + this.m.Amount);
			rationsEffect.resetTurns();

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}
			return true;
		}

		//We are satiated stuffed and sick and fat- we can't eat no more, do nothing with food
		return false;
	}
});

