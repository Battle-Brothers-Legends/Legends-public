::mods_hookExactClass("ai/tactical/behaviors/ai_attack_knock_out", function ( o )
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendGrapple),
		::Legends.Actives.getID(::Legends.Active.LegendBucklerBash),
		::Legends.Actives.getID(::Legends.Active.LegendNinetailsDisarm),
		::Legends.Actives.getID(::Legends.Active.LegendWarforkDisarm)
	]);

	local getBestTarget = o.getBestTarget;
	o.getBestTarget = function ( _entity, _skill, _targets )
	{
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();

		if (attackSkill == null)
		{
			this.m.BestTarget = {
				Target = null,
				Score = 0.0
			};
			yield null;
			return true;
		}

		local getBestTarget = getBestTarget(_entity, _skill, _targets);

		while( resume getBestTarget == null)
		{
			yield null;
		}

		return getBestTarget;
	};
});
