::mods_hookExactClass("skills/actives/drink_antidote_skill", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getID() != _originTile.getEntity().getID())
		{
			if (!target.getItems().hasEmptySlot(this.Const.ItemSlot.Bag))
			{
				return false;
			}

			return true;
		}
		else
		{
			if (target.getSkills().hasEffect(::Legends.Effect.GoblinPoison))
			{
				return true;
			}

			if (target.getSkills().hasEffect(::Legends.Effect.SpiderPoison))
			{
				return true;
			}

			if (target.getSkills().hasEffect(::Legends.Effect.LegendRedbackSpiderPoison))
			{
				return true;
			}

			return false;
		}
	}

	o.onUse = function( _user, _targetTile )
	{
		local user = _targetTile.getEntity();
		this.spawnIcon("status_effect_97", _targetTile);

		if (_user.getID() == user.getID())
		{
			if (user.getSkills().hasEffect(::Legends.Effect.GoblinPoison))
			{
				user.getSkills().removeByID("effects.goblin_poison");
			}

			if (user.getSkills().hasEffect(::Legends.Effect.SpiderPoison))
			{
				user.getSkills().removeByID("effects.spider_poison");
			}

			if (user.getSkills().hasEffect(::Legends.Effect.LegendRedbackSpiderPoison))
			{
				user.getSkills().removeByID("effects.legend_redback_spider_poison");
			}

			user.getSkills().add(this.new("scripts/skills/effects/antidote_effect"));

			if (!user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " drinks Antidote");
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
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives Antidote to " + this.Const.UI.getColorizedEntityName(user));
			}

			this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}

});
