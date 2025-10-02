this.legend_dismount_horse_skill <- this.inherit("scripts/skills/skill", {
    m = {
        MountedStatus = null
    },

    function create()
    {
        this.m.ID = "actives.legend_dismount_horse";
        this.m.Name = "Dismount";
        this.m.Description = "Dismount to an adjacent tile, leaving the horse here.";
        this.m.Icon = "skills/horse_kick.png"; // placeholder
        this.m.IconDisabled = "skills/horse_kick_bw.png";
        this.m.Overlay = "horse_dismount";
        this.m.SoundOnUse = [ "sounds/combat/hand_01.wav" ];
        this.m.Type = this.Const.SkillType.Active;
        this.m.Order = this.Const.SkillOrder.UtilityTargeted;
        this.m.IsSerialized = false;
        this.m.IsActive = true;
        this.m.IsTargeted = true;
        this.m.IsAttack = false;
        this.m.ActionPointCost = 4;
        this.m.FatigueCost = 10;
        this.m.MinRange = 1;
        this.m.MaxRange = 1;
    }

    function setMountedStatus( _st )
    {
        this.m.MountedStatus = this.WeakTableRef(_st);
    }

    function isUsable()
    {
        if (!this.skill.isUsable()) return false;
        if (!("m" in this) || this.m == null) return false;
        if (this.m.MountedStatus == null) return false;
        if (this.m.MountedStatus.isNull()) return false;
        return this.m.MountedStatus.m.Horse != null && !this.m.MountedStatus.m.Horse.isNull();
    }

    function onVerifyTarget( _originTile, _targetTile )
    {
        if (!_targetTile.IsEmpty) return false;
        if (this.Math.abs(_targetTile.Level - _originTile.Level) > 1) return false;
        return true;
    }

    function onUse( _user, _targetTile )
    {
        if (this.m.MountedStatus == null || this.m.MountedStatus.m.Horse == null || this.m.MountedStatus.m.Horse.isNull())
            return false;

        local horse = this.m.MountedStatus.m.Horse;
        local cur = _user.getTile();

        // Move rider to target tile first
        this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);

        // Bring horse back and place on vacated tile
        // The horse should be on the tactical map already but retreated
        if (horse.getTile() == null)
        {
            // Horse wasn't on map - add it
            this.Tactical.addEntityToMap(horse, cur.Coords.X, cur.Coords.Y);
        }
        else
        {
            // Horse is retreated - teleport it to the vacated tile (this will un-retreat it)
            this.Tactical.getNavigator().teleport(horse, cur, null, null, false);
        }

        // Remove mounted status (restores armor/skills)
        _user.getSkills().removeByID("status.legend_mounted");
        return true;
    }
});

