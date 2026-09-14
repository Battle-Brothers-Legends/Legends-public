this.legend_RSW_blazing <- this.inherit("scripts/skills/skill", {
	m = {
		TargetTile = null,
	},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswBlazing);
		this.m.Description = "Rune Sigil: Blazing";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill.getItem() != null && _skill.getItem().getID() == this.getID() && _targetEntity != null)
			this.m.TargetTile = _targetEntity.getTile();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if ( _skill == null || _skill.m.IsWeaponSkill == false || !_skill.isAttack())
			return;

		if (_skill.getItem() == null || this.getItem() == null || _skill.getItem().getInstanceID() != this.getItem().getInstanceID())
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		local tile = this.m.TargetTile != null ? this.m.TargetTile : _targetEntity.getTile();
		if (tile == null)
			return;

		if (tile.Subtype != ::Const.Tactical.TerrainSubtype.Snow &&	tile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow && tile.Type != ::Const.Tactical.TerrainType.ShallowWater && tile.Type != ::Const.Tactical.TerrainType.DeepWater)	{
			::Tactical.State.spawnFireRSWBlazingOnTile(tile, this);
		}
	}
});
