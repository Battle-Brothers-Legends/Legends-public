::mods_hookExactClass("skills/actives/knock_back", function(o)
{
	o.m.RegularDamage <- 10;
	o.m.RegularDamageMax <- 25;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.FatigueCost = 15;
	}

	o.setDamage <- function (_extraShieldDamageMin, _extraShieldDamageMax)
	{
		if (this.m.IsBaseValuesSaved) {
			setBaseValue("RegularDamage", getBaseValue("RegularDamage") + _extraShieldDamageMin);
			setBaseValue("RegularDamageMax", getBaseValue("RegularDamageMax") + _extraShieldDamageMin);
			this.m.RegularDamage = getBaseValue("RegularDamage");
			this.m.RegularDamageMax = getBaseValue("RegularDamageMax");
		}
		else {
			this.m.RegularDamage += _extraShieldDamageMin;
			this.m.RegularDamageMax += _extraShieldDamageMax;
			saveBaseValues();
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.getContainer().hasPerk(::Legends.Perk.ShieldBash) ? this.getDefaultTooltip() : this.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+40%[/color] chance to hit"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] chance to hit"
			});
		}

		if (this.getContainer().hasSkill("trait.oath_of_fortification"))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
			});
		}
		return ret;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local shouldNotHarmAlly = getContainer().hasTrait(::Legends.Trait.Teamplayer) && target.isAlliedWith(_user);

		if (!getContainer().hasPerk(::Legends.Perk.ShieldBash) || shouldNotHarmAlly) {
			if (shouldNotHarmAlly)
				target.getFlags().set("CanNotBeStaggered", true);

			local ret = onUse(_user, _targetTile);

			if (!::MSU.isNull(target))
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

		if (this.getContainer().hasPerk(::Legends.Perk.ShieldBash))
		{
			this.m.FatigueCostMult = this.m.FatigueCostMult *= 0.75;
			this.m.ActionPointCost = 3
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.getContainer().hasPerk(::Legends.Perk.ShieldBash))
		{
			local item = this.getContainer().getActor().getOffhandItem();
			local shieldBonus = this.Math.min(10, item == null ? 0 : this.Math.floor(item.m.ConditionMax * 0.05));
			_properties.DamageRegularMin = this.m.RegularDamage + shieldBonus;
			_properties.DamageRegularMax = this.m.RegularDamageMax + shieldBonus;
			_properties.DamageArmorMult = 0.5;
			_properties.FatigueDealtPerHitMult += 1.0;
		}
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
		if (this.getContainer().hasTrait(::Legends.Trait.Teamplayer) && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		if (!isUsingHitchance())
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}

});
