::mods_hookBaseClass("entity/tactical/actor", function(o) {
    while(!("BloodSaturation" in o.m)) o = o[o.SuperName]; // find the base class
    if(!("_mod_legend" in o))
    {
        o._mod_legend <- true;// only override the methods once per base instance
        o.m.BloodSaturation = 1.5;
        o.m.DeathBloodAmount = 1.5;
        o.m.BloodPoolScale = 1.25;
    }
    local fn = o.onMovementFinish;
    o.onMovementFinish = function (_tile)
    {
        fn(_tile);
        this.m.Skills.MovementCompleted(_tile);
    }

    o.isArmedWithMagicStaff <- function()
	{
		local item = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return item != null && item.isItemType(this.Const.Items.ItemType.MagicStaff);
	}

    o.equipItem <- function( _item)
    {
        return this.getItems().equip(_item);
    }

    o.bagItem <- function (_item)
    {
        this.getItems().addToBag(_item);
    }

    o.setArmor <- function (_bodyPart, _value)
    {
        this.m.BaseProperties.Armor[_bodyPart] = _value;
    }

    o.resetPerks <- function ()
    {
        local perks = this.m.PerkPointsSpent;
		local hasStudent = false;

		if (this.getSkills().hasSkill("perk.student"))
		{
			perks = perks - 1;
			hasStudent = true;
		}

		this.m.PerkPoints += perks;
		this.m.PerkPointsSpent = 0;
		this.getSkills().removeByType(this.Const.SkillType.Perk);

		if (hasStudent && _actor.getLevel() >= 11)
		{
			this.getSkills().add(this.new("scripts/skills/perks/perk_student"));
		}
    }

        //
    // local onResurrected = o.onResurrected;
    // o.onResurrected = function ( _info ) 
    // {
    //     onResurrected(_info);
    //     this.World.getPlayerRoster().add(_info);
    // }
    // local onInit = o.onInit;
    // o.onInit = function ()
    // {
    //     o.onInit();
    //     o.m.BloodSaturation = 1.5;
    //     o.m.DeathBloodAmount = 1.5;
    //     o.m.BloodPoolScale = 1.25;
    //     o.m.BloodSplatterOffset = this.createVec(-1, -1);
    // }
    // }
});