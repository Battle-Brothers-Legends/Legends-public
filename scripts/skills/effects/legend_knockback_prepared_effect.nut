this.legend_knockback_prepared_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendKnockbackPrepared);
		this.m.Icon = "ui/perks/smackdown_circle.png";
		this.m.IconMini = "mini_smackdown_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is preparing an attack to inflict strong blow that will push the target back and baffle them if it connects.";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onAdded() {
		if (this.getContainer().getActor().isPlacedOnMap())
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());
		this.onRefresh();
	}

	function onRefresh() {
		this.m.AttacksLeft = 1;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.m.IsAttack || _skill.isRanged())
			return;

		--this.m.AttacksLeft;
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendBaffled);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!_skill.m.IsAttack || _skill.isRanged())
			return;

		--this.m.AttacksLeft;
		if (this.m.AttacksLeft <= 0)
			this.removeSelf();
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
				return knockToTile;
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
				return knockToTile;
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
				return knockToTile;
		}

		return null;
	}

});
