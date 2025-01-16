this.legend_vala_chant <- this.inherit("scripts/skills/skill", {
	m = {
		Vala = null,
		Range = 1
	},
	function setVala(_v)
	{
		this.m.Vala = ::MSU.asWeakTableRef(_v);
	}

	function create()
	{
		this.m.Name = "";
		this.m.Icon = "";
		this.m.IconMini = "";
		this.m.Overlay = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		if (!this.checkEntities())
			return true;

		if (!this.isInRange())
			return true;

		return false;
	}

	function updateEffect(_v)
	{
	}

	function isMastered()
	{
		if (::MSU.isNull(this.m.Vala))
			return false;

		return this.m.Vala.getSkills().hasPerk(::Legends.Perk.LegendValaChantMastery);
	}

	function doValaChecks()
	{
		if (!::Tactical.isActive())
			return false;

		if (!("Entities" in ::Tactical))
			return false;

		if (("isCombatFinished" in ::Tactical.Entities) && ::Tactical.Entities.isCombatFinished())
			return false;

		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return false;

		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
			return false;

		if (actor.getTile() == null)
			return false;

		if (::MSU.isNull(this.m.Vala))
			return false;

		return true;
	}

	function checkEntities()
	{
		if (!this.doValaChecks())
			return false;

		return this.m.Vala.getTile() != null;
	}

	function isInRange()
	{
		if (!this.m.Vala.isPlacedOnMap() || this.m.Vala.getFlags().get("Devoured") == true)
			return false;

		return this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile()) <= this.m.Range;
	}

	function onUpdate( _properties )
	{
		if (!this.checkEntities())
		{
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false);
			return;
		}

		this.updateEffect(true);
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});
