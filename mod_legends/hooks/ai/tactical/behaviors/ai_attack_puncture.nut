::mods_hookExactClass("ai/tactical/behaviors/ai_attack_puncture", function(o) 
{
	o.m.PossibleSkills.extend([
		::Legends.Actives.getID(::Legends.Active.LegendPunctureParryDagger),
		::Legends.Actives.getID(::Legends.Active.LegendChoke)
	]);

	o.onExecute = function ( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
			}

			this.m.TargetTile = null;
		}

		return true;
	}

	o.getBestTarget = function( _entity, _skill, _targets )
	{
		local bestTarget;
		local bestScore = 0.0;

		foreach( target in _targets )
		{
			if (!_skill.isUsableOn(target.getTile()))
			{
				continue;
			}

			if (target.getArmor(this.Const.BodyPart.Body) <= 25 || target.getArmor(this.Const.BodyPart.Head) <= 15)
			{
				continue;
			}

			if (target.getFatigue() < (target.getFatigueMax() / 2))
			{
				continue;
			}

			local p = _entity.getCurrentProperties();
			local armor = target.getArmor(this.Const.BodyPart.Body) * (p.getHitchance(this.Const.BodyPart.Body) / 100.0) + target.getArmor(this.Const.BodyPart.Head) * (p.getHitchance(this.Const.BodyPart.Head) / 100.0);

			if (armor <= 40 && target.getHitpoints() > _entity.getCurrentProperties().getRegularDamageAverage())
			{
				continue;
			}

			local score = this.queryTargetValue(_entity, target, _skill);
			score = score * this.Math.pow(armor / 100.0, 1.1);

			if (score > bestScore)
			{
				bestTarget = target;
				bestScore = score;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore
		};
	}
});
