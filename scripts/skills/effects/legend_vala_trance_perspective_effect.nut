this.legend_vala_trance_perspective_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Vala = null,
		TurnsLeft = 3
	},
	function setVala(_v)
	{
		if (typeof _v == "instance")
		{
			this.m.Vala = _v;
		}
		else
		{
			this.m.Vala = this.WeakTableRef(_v);
		}
	}


	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaTrancePerspectiveEffect);
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Overlay = "status_effect_52";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function isHidden()
	{
		return false;
	}


	function getTooltip()
	{
		if (!this.isHidden())
		{
			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				}
			];
		}
		else
		{
			return;
		}
	}


	function shareVisibility()
	{
		this.getContainer().getActor().updateVisibility(this.getContainer().getActor().getTile(), 1, this.m.Vala.getContainer().getActor().getFaction());
	}


	function onUpdate( _properties )
	{
		if (this.m.Vala == null)
		{
			this.removeSelf();
		}

		_properties.Vision -= 1;

		this.shareVisibility();
	}


	function onMovementFinished()
	{
		if (this.m.Vala == null)
		{
			this.removeSelf();
		}

		this.shareVisibility();
	}


	function onTurnStart()
	{
		if (this.m.Vala == null)
		{
			this.removeSelf();
		}

		this.shareVisibility();
	}


	function onTurnEnd()
	{
		if (this.m.Vala == null)
		{
			this.removeSelf();
		}

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}


	function onRefresh()
	{
		if (this.m.TurnsLeft != 3)
		{
			this.m.TurnsLeft = 3;
			this.spawnIcon("status_effect_52", this.getContainer().getActor().getTile());
			this.shareVisibility();
		}
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});
