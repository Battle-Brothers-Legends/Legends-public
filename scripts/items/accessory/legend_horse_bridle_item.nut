this.legend_horse_bridle_item <- this.inherit("scripts/items/accessory/accessory", {
    m = {
        HorseUID = null,
        HorseName = null
    },

    function create()
    {
        this.accessory.create();
        this.m.ID = "accessory.legend_horse_bridle";
        this.m.Name = "Horse Reins";
        this.m.Description = "Reins bound to a specific horse. Equip these to mount and control your horse in battle.";
        this.m.Icon = "tools/dog_01_leash_70x70.png"; // placeholder icon
        this.m.SlotType = this.Const.ItemSlot.Accessory;
        this.m.IsDroppedAsLoot = false;
        this.m.IsIndestructible = true;
        this.m.Value = 0;
        this.m.IsSellable = false;
    }

    function isAllowed( _actor )
    {
        // Prevent horses from equipping bridles
        if (_actor.getBackground() != null && _actor.getBackground().getID() == "background.legend_horse")
        {
            return false;
        }
        return true;
    }

    function setHorseUID( _uid, _name )
    {
        this.m.HorseUID = _uid;
        this.m.HorseName = _name != null ? _name : null;
        if (this.m.HorseName != null)
        {
            this.m.Name = format("Reins: %s", this.m.HorseName);
        }
    }

    function getHorseUID()
    {
        return this.m.HorseUID;
    }

    function getName()
    {
        if (this.m.HorseName != null)
        {
            return format("Reins: %s", this.m.HorseName);
        }
        return this.accessory.getName();
    }

    function onEquip()
    {
        this.accessory.onEquip();
        // Grant Mount skill while equipped - direct approach
        local actor = this.getContainer().getActor();
        local mount = this.new("scripts/skills/actives/legend_mount_horse_skill");
        mount.setBridle(this);
        actor.getSkills().add(mount);
    }

    function onUnequip()
    {
        this.accessory.onUnequip();
        // Remove Mount skill when bridle is unequipped
        local actor = this.getContainer().getActor();
        if (actor.getSkills().hasSkill("actives.legend_mount_horse"))
        {
            actor.getSkills().removeByID("actives.legend_mount_horse");
        }
    }

    function onSerialize( _out )
    {
        this.accessory.onSerialize(_out);
        _out.writeString(this.m.HorseUID == null ? "" : this.m.HorseUID);
        _out.writeString(this.m.HorseName == null ? "" : this.m.HorseName);
    }

    function onDeserialize( _in )
    {
        this.accessory.onDeserialize(_in);
        local uid = _in.readString();
        local nm = _in.readString();
        this.m.HorseUID = uid.len() == 0 ? null : uid;
        this.m.HorseName = nm.len() == 0 ? null : nm;
    }
});

