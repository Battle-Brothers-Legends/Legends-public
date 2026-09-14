this.legend_skin_ghoul_swallow_whole_skill <- this.inherit("scripts/skills/actives/swallow_whole_skill", {
	function create() {
		this.swallow_whole_skill.onCreate();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSkinGhoulSwallowWhole);
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " devours " + this.Const.UI.getColorizedEntityName(target));
		}

		::Const.Tactical.Common.removeStances(target, true);

		if (target.getMoraleState() != this.Const.MoraleState.Ignore)
			target.setMoraleState(this.Const.MoraleState.Breaking);

		this.m.SwallowedEntity = target;
		this.m.SwallowedEntity.getFlags().set("Devoured", true);
		this.m.SwallowedEntity.setHitpoints(this.Math.max(5, this.m.SwallowedEntity.getHitpoints() - this.Math.rand(10, 20)));
		target.removeFromMap();
		_user.getSprite("body").setBrush("bust_ghoulskin_body_04");
		_user.getSprite("injury").setBrush("bust_ghoul_04_injured");
		_user.getSprite("head").setBrush("bust_ghoulskin_04_head_0" + _user.m.Head);
		_user.m.Sound[this.Const.Sound.ActorEvent.Death] = _user.m.Sound[this.Const.Sound.ActorEvent.Other2];

		::Legends.Effects.grant(_user, ::Legends.Effect.SwallowedWhole, function(_effect) {
			_effect.setName(target.getName());
		}.bindenv(this));

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		return true;
	}

});

