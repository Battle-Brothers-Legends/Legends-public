::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A large and heavy crossbow with menacing spikes in front. More like a minitature ballista, it shoots stakes with enough force to knock back a target hit. Very effective against vampires.";
		this.setVariant(this.Math.rand(0, 1));
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local result = getTooltip();
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Deals extra damage to vampires"
		});
		return result;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/crossbow_goblin_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/crossbow_goblin_01" + v + ".png";
		if (this.getVariant() == 0) {
			this.m.ArmamentIcon = "icon_goblin_crossbow_01";
		} else {
			this.m.ArmamentIcon = "icon_crossbow_goblin_01" + v;
		}
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ShootStake))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.ShootStake, function (_skill)
			{
				_skill.m.Name = "Shoot Stake";
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
		::Legends.Actives.grant(this, ::Legends.Active.ReloadBolt);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (!_skill.isAttack())
			return;

		if (!_skill.isRanged())
			return;

		if (item == null)
			return;

		if (item.getID() != this.getID())
			return;

		if (_targetEntity != null && (_targetEntity.getType() == this.Const.EntityType.Vampire || _targetEntity.getType() == this.Const.EntityType.LegendVampireLord))
		{
			_properties.DamageRegularMin += 100;
			_properties.DamageRegularMax += 100;
		}
	}
});
