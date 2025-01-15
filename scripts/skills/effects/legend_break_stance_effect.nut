this.legend_break_stance_effect <- this.inherit("scripts/skills/skill", {
	m = {,
	function create()
	{
		this.m.ID = "effects.legend_break_stance";
		this.m.Name = "Break Stance";
		// this.m.Icon = "skills/baffled.png";
		// this.m.IconMini = "mini_baffled_circle";
		// this.m.Overlay = "baffled_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function onAdded () {
		this.getContainer().removeByID("effects.shieldwall");
		this.getContainer().removeByID("effects.spearwall");
		this.getContainer().removeByID("effects.riposte");
		this.getContainer().removeByID("effects.legend_return_favor");
		this.removeSelf();
	}
});
