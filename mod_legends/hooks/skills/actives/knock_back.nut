::mods_hookExactClass("skills/actives/knock_back", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = 25;
		this.m.FatigueCost = 15;
		this.m.DirectDamageMult = 0.2;
	}

	o.getTooltip = function ()
	{
		local ret = ::Legends.Perks.has(this, ::Legends.Perk.ShieldBash) ? this.getDefaultTooltip() : this.getDefaultUtilityTooltip();

		if (this.getContainer().hasTrait(::Legends.Trait.OathOfFortification))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to stagger on a hit"
			});
		}
		return ret;
	}

	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local shouldNotHarmAlly = (::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) || ::Legends.Perks.has(this, ::Legends.Perk.Taunt)) && target.isAlliedWith(_user);

		if (!::Legends.Perks.has(this, ::Legends.Perk.ShieldBash) || shouldNotHarmAlly) {
			if (shouldNotHarmAlly)
				target.getFlags().set("CanNotBeStaggered", true);

			local ret = onUse(_user, _targetTile);

			if (!ret)
				target.getFlags().remove("CanNotBeStaggered");

			return ret;
		}

		local success = attackEntity(_user, target);

		if (!success || !_user.isAlive() || _user.isDying()) return false;

		if (!target.isAlive() || target.isDying()) return success;

		local current = [];
		current.extend(m.SoundOnUse);
		m.SoundOnUse = []; // put this to zero so sound on use doesn't get trigger twice
		m.IsUsingHitchance = false;
		onUse(_user, _targetTile); // let the onUse to handle the knock back
		m.IsUsingHitchance = true;
		m.SoundOnUse.extend(current);
		return success;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInShields ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash))
		{
			this.m.FatigueCostMult = this.m.FatigueCostMult *= 0.75;
			this.m.ActionPointCost = 3
		}
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed( _skill, _targetEntity, _properties );

		if (_skill != this)
			return;

		if (_properties.IsSpecializedInShields)
			this.m.HitChanceBonus += 15;

		_properties.DamageRegularMin = this.getItem().getRegularDamageMin();
		_properties.DamageRegularMax = this.getItem().getRegularDamageMax();
		_properties.DamageArmorMult = 0.5;
		_properties.FatigueDealtPerHitMult += 1.0;

		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash))
		{
			_properties.DamageRegularMin = this.getItem().getRegularDamageMin();
			_properties.DamageRegularMax = this.getItem().getRegularDamageMax();
			_properties.DamageArmorMult = 0.5;
			_properties.FatigueDealtPerHitMult += 1.0;
		}
	}

	o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if (_skill != this)
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity))
			return false;

		local skill = ::Legends.Actives.get(actor, ::Legends.Active.Taunt);
		if (skill != null && ::Legends.Perks.has(actor, ::Legends.Perk.Taunt))
			skill.onUse(actor, _targetEntity.getTile());
	}

	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.findTileToKnockBackTo(getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null)
			return;
		// to show where the target may be knocked back
		this.Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function ( _targetEntity )
	{
		if ((::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) || ::Legends.Perks.has(this, ::Legends.Perk.Taunt)) && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		if (!isUsingHitchance())
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}

});
