this.legend_super_nightmare_skill <- this.inherit("scripts/skills/actives/nightmare_skill", {
	m = {
		DoNotUseSkill = false
	},
	function create()
	{
		this.nightmare_skill.create();
		this.m.ActionPointCost = 6;
		this.m.MaxRange = 3;
	}

	function onTurnStart()
	{
		this.m.DoNotUseSkill = false;
	}

	function isUsable()
	{
		return !this.m.DoNotUseSkill && this.nightmare_skill.isUsable();
	}

	function getDamage( _actor )
	{
		return this.nightmare_skill.getDamage(_actor) * 2.0;
	}

	function onDelayedEffect( _tag )
	{
		local target = _tag.TargetTile.getEntity();

		if (!target.checkMorale(0, -35, this.Const.MoraleCheckType.MentalAttack))
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Horrified);

			if (!_tag.User.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is horrified");
			}
		}

		this.nightmare_skill.onDelayedEffect(_tag);
	}

});

