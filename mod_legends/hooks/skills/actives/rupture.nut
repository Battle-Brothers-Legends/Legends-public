::mods_hookExactClass("skills/actives/rupture", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional [color=" + this.Const.UI.Color.DamageValue + "]" + this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms ? 10 : 5 + "[/color] bleeding damage over time if not stopped by armor"
			}
		]);
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms ? 10 : 5;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=" + this.Const.UI.Color.DamageValue + "]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});

		return tooltip;
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.BleedingSounds[this.Math.rand(0, this.m.BleedingSounds.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding )
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
					if (_user.getFaction() == this.Const.Faction.Player )
					{
						effect.setActor(this.getContainer().getActor());
					}
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms ? 10 : 5);
				target.getSkills().add(effect);
				this.Sound.play(this.m.BleedingSounds[this.Math.rand(0, this.m.BleedingSounds.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}

});
