this.legend_drums_of_war_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Effect = 0
	},

	function setEffect( _e )
	{
		this.m.Effect = _e;
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDrumsOfWar);
		this.m.Description = "";
		this.m.Icon = "ui/perks/drums_of_war.png";
		this.m.Overlay = "drums_of_war_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.m.Effect));
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

