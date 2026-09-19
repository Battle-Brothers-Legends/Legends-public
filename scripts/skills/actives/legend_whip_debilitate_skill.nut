this.legend_whip_debilitate_skill <- this.inherit("scripts/skills/actives/legend_debilitate_skill", {
	m = {},
	function create() {
		this.legend_debilitate_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWhipDebilitate);
		this.m.Description = "Crack your whip to deliver a biting strike that leaves your opponent weakened.";
		this.m.MaxRange = 3;
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/whip", 3);
	}

	function onUse( _user, _targetTile ) {
		return this.attackEntity(_user, _targetTile.getEntity());
	}
});
