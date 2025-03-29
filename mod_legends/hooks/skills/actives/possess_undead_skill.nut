::mods_hookExactClass("skills/actives/possess_undead_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Allows you to boost the attacks of an undead minion";
		this.m.Icon = "skills/possess56_square.png";
		this.m.IconDisabled = "skills/possess56_square_bw.png";
		this.m.IsUsingHitchance = false;
		this.m.MaxRange = 9;
		this.m.Order = this.Const.SkillOrder.Any +10;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if (!this.getContainer().getActor().isPlayerControlled())
			this.m.MaxRange = 99;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " possesses " + this.Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.2, _user.getPos());
			}
		}
		::Legends.Effects.grant(target, ::Legends.Effect.PossessedUndead, function(_effect) {
			_effect.setPossessor(_user);
			_effect.setPlayerControlled(_user.isPlayerControlled());
		}.bindenv(this));

		target.setActionPoints(target.getCurrentProperties().ActionPoints);

		::Legends.Effects.grant(_user, ::Legends.Effect.PossessingUndead, function(_effect) {
			_effect.setPossessed(target);
		}.bindenv(this));
		return true;
	}
});
