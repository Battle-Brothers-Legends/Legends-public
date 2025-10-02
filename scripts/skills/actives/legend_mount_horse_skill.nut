this.legend_mount_horse_skill <- this.inherit("scripts/skills/skill", {
    m = {
        Bridle = null
    },

    function create()
    {
        this.m.ID = "actives.legend_mount_horse";
        this.m.Name = "Mount";
        this.m.Description = "Mount your horse if you are adjacent to it.";
        this.m.Icon = "skills/horse_pirouette.png"; // placeholder
        this.m.IconDisabled = "skills/horse_pirouette_bw.png";
        this.m.Overlay = "horse_mount";
        this.m.SoundOnUse = [ "sounds/combat/gallop.wav" ];
        this.m.Type = this.Const.SkillType.Active;
        this.m.Order = this.Const.SkillOrder.UtilityTargeted;
        this.m.IsSerialized = false;
        this.m.IsActive = true;
        this.m.IsTargeted = false;
        this.m.IsStacking = false;
        this.m.IsAttack = false;
        this.m.ActionPointCost = 4;
        this.m.FatigueCost = 10;
        this.m.MinRange = 1;
        this.m.MaxRange = 1;
    }

    function setBridle( _item )
    {
        this.m.Bridle = this.WeakTableRef(_item);
    }

    function getAdjacentBindableHorse( _actor )
    {
        local tile = _actor.getTile();
        for (local i = 0; i < 6; ++i)
        {
            if (!tile.hasNextTile(i)) continue;
            local t = tile.getNextTile(i);
            if (!t.IsOccupiedByActor) continue;
            local e = t.getEntity();
            if (!e.getFlags().has("IsHorse")) continue;

            // If bridle has a specific UID, enforce match
            local want = this.m.Bridle != null ? this.m.Bridle.getHorseUID() : null;
            local has = e.getFlags().has("HorseBridleUID") ? e.getFlags().get("HorseBridleUID") : null;
            if (want != null && has != null && want != has) continue;

            return e;
        }
        return null;
    }

    function isUsable()
    {
        if (!this.skill.isUsable()) return false;
        local a = this.getContainer().getActor();
        // Already mounted? Then cannot mount
        if (a.getSkills().hasSkill("status.legend_mounted")) return false;
        local h = this.getAdjacentBindableHorse(a);
        return h != null;
    }

    function onUse( _user, _targetTile )
    {
        local horse = this.getAdjacentBindableHorse(_user);
        if (horse == null) return false;

        // Bind bridle to this horse if not yet bound
        if (this.m.Bridle != null && this.m.Bridle.getHorseUID() == null)
        {
            local uid = horse.getFlags().has("HorseBridleUID") ? horse.getFlags().get("HorseBridleUID") : null;
            if (uid == null)
            {
                uid = this.Math.rand(100000, 999999) + "-" + this.Math.rand(100000, 999999);
                horse.getFlags().set("HorseBridleUID", uid);
            }
            this.m.Bridle.setHorseUID(uid, horse.getName());
        }

        // Apply mounted status
        local st = this.new("scripts/skills/status/legend_mounted_status");
        st.setMountPair(_user, horse);
        _user.getSkills().add(st);

        // Remove horse from map (kept in roster)
        horse.removeFromMap();

        return true;
    }
});

