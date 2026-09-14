this.legend_vala_spiritual_bond_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Vala = null,
		ResolveAtCheck = 0,
	},
	function setVala(_v)
	{
		this.m.Vala = ::MSU.asWeakTableRef(_v);
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaSpiritualBondEffect);
		this.m.Description = "";
		this.m.Icon = "skills/status_effect_87.png";
		this.m.IconMini = "status_effect_87_mini";
		this.m.Overlay = "status_effect_87";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function isValid( _attacker, _skill )
	{
		if (_skill != null && !_skill.isAttack())
			return false;

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID())
			return false;

		if (::MSU.isNull(this.m.Vala) || ::MSU.isNull(this.m.Vala.m.WardenEntity))
			return false;

		return true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.m.ResolveAtCheck = 0;

		if (!this.isValid(_attacker, _skill))
			return;

		this.m.ResolveAtCheck = this.getContainer().getActor().getBravery() / 400.00;
		local reduction = ::Math.maxf(0.5, 1.0 - (0.1 + this.m.ResolveAtCheck));
		_properties.DamageReceivedRegularMult *= reduction;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (::MSU.isNull(this.m.Vala) || ::MSU.isNull(this.m.Vala.m.WardenEntity))
			return false;

		if (_damageHitpoints < 1)
			return;

		local transfer = ::Math.minf(0.5, 0.1 + this.m.ResolveAtCheck);
		local reduction = ::Math.maxf(0.5, 1.0 - (0.1 + this.m.ResolveAtCheck));
		local DamageToWarden = this.Math.ceil((_damageHitpoints / reduction) * transfer);

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = DamageToWarden;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.m.Vala.m.WardenEntity.onDamageReceived(_attacker, this, hitInfo);
	}
});
