this.legend_full_draw_skill <- this.inherit("scripts/skills/actives/aimed_shot", {
	m = {
		Prepared = false,
		TargetTile = null,
		SoundResumeOnUse = ::Legends.S.setSounds("sounds/combat/quick_shot", 3)
	}
	function create() {
		this.aimed_shot.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFullDraw);
		this.m.Description = "Take full advantage of the draw weight of your bow to deliver a devastating and accurate shot. Can not be used while engaged in melee.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/aimed", 3);
		this.m.FatigueCost = 25;
		this.m.MinRange = 3;
		this.m.ActionPointCost = 9;
		this.m.DirectDamageMult = 0.5;
		this.m.IsTargetingActor = false;
	}

	function onResumeUse() {
		local actor = this.getContainer().getActor();
		::Sound.play(this.m.SoundResumeOnUse[::Math.rand(0, this.m.SoundResumeOnUse.len() - 1)], 1.0, actor.getPos());
		this.m.TargetTile.clear(::Const.Tactical.DetailFlag.SpecialOverlay);
		this.consumeAmmo();
		
		if (!actor.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = actor,
				TargetTile = this.m.TargetTile
			};
			::Time.scheduleEvent(::TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);
		
			if (!actor.isPlayerControlled() && this.m.TargetTile.getEntity().isPlayerControlled()) {		
				actor.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return true;
		}
		else {		
			return this.attackEntity(actor, this.m.TargetTile.getEntity());
		}
	}

	function onUse( _user, _targetTile ) {
		this.m.Prepared = true;
		this.m.TargetTile = _targetTile;
		_targetTile.spawnDetail("mortar_target_02", ::Const.Tactical.DetailFlag.SpecialOverlay, false, true);
		::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " draws the bow to it's maximum and prepares a shot");
		return true;
	}

	function onTurnStart() {
		if (this.m.Prepared) {
			this.onResumeUse();
		}
	}

	function onResumeTurn() {
		if (this.m.Prepared && this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows) {
			this.onResumeUse();
		}
	}

	function onAfterUpdate ( _properties ) {
		this.aimed_shot.onAfterUpdate(_properties);
		if (_properties.IsSpecializedInBows) {
			this.m.ActionPointCost -= 1;
		}
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 2 : 1);
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.3;

			if (_properties.IsSharpshooter) {
				_properties.DamageDirectMult += 0.05;
			}
		}
	}
});
