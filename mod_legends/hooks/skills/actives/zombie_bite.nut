::mods_hookExactClass("skills/actives/zombie_bite", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Wiederganger Bite";
		this.m.Description = "A vicious bite with a 15% increased chance to hit the head. Infects on legendary difficulty. Will revive humanoid enemies as allied Wiedergangers if dealt as a killing blow.";
		this.m.IconDisabled = "skills/active_24_bw.png";
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 2;
	}

	o.getTooltip <- function ()
	{
		return this.getDefaultTooltip();
	}

	o.onUse <- function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			if (!target.getCurrentProperties().IsImmuneToPoison && ::Legends.isLegendaryDifficulty() && hp - target.getHitpoints() >= this.Const.Combat.PoisonEffectMinDamage)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.LegendZombiePoison);
			}
		}
		return success;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local items = this.m.Container.getActor().getItems();
			local mhand = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
				_properties.DamageDirectAdd -= mhand.m.DirectDamageAdd;
			}

			_properties.DamageRegularMin += 15;
			_properties.DamageRegularMax += 35;
			_properties.DamageArmorMult = 0.5;
			_properties.HitChance[this.Const.BodyPart.Head] += 15;

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}

	o.onTargetKilled <- function ( _targetEntity, _skill )
	{
		if (_skill != this)
		{
			return;
		}

		if (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!this.isKindOf(actor.get(), "player"))
		{
			return;
		}

		if (_targetEntity.getTile().IsCorpseSpawned && _targetEntity.getTile().Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _targetEntity.getTile().Properties.get("Corpse");
			corpse.Faction = actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction();
			corpse.Hitpoints = 1.0;
			corpse.Items = _targetEntity.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
		}
	}

	o.canDoubleGrip <- function ()
	{
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return main != null && off == null && main.isDoubleGrippable();
	}

	o.isUsable = function ()
	{
		return this.skill.isUsable();
	}

	o.onUpdate = function ( _properties )
	{
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			this.m.IsIgnoredAsAOO = true;
		}
		else
		{
			this.m.IsIgnoredAsAOO = false;
		}
	}
});
