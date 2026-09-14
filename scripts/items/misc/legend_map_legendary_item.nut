this.legend_map_legendary_item <- this.inherit("scripts/items/item", {
    m = {
        Target = "",
        LocationName = ""
    },
    function create() {
        this.item.create();
        this.m.ID = ::Legends.Maps.Type.Legendary;
        this.m.Name = "Legendary location map";
        this.m.Icon = "misc/map_legendary.png";
        this.m.Description = "This map seems to have marked location and a lot of annotations. Right click to study it.";
        this.m.SlotType = this.Const.ItemSlot.None;
        this.m.ItemType = this.Const.Items.ItemType.Usable;
        this.m.IsUsable = true;
        this.m.IsDroppedAsLoot = true;
        this.m.Value = 350;
    }

    function getBuyPrice() {
        if (this.m.IsSold) {
            return this.getSellPrice();
        }
        if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
            return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.World.Assets.BaseBuyPrice));
        }
        return this.item.getBuyPrice();
    }

    function getSellPrice() {
        if (this.m.IsBought) {
            return this.getBuyPrice();
        }
        if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null) {
            return this.Math.floor(this.getValue() * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.World.Assets.BaseSellPrice);
        }
        return this.item.getSellPrice();
    }

    function onUse( _actor, _item = null ) {
        if (this.m.Target == "") {
            this.randomizeLocation();
            ::Tooltip.reload();
        }

        if (this.m.Target == "")
            return;

        if (this.m.Target == "x")
            return;

        local location = ::Legends.Maps.getSpawnedLegendaryLocation(this.m.Target);

        if (location == null) {
            ::logInfo("Failed to apply map, because " + this.m.Target + " is not spawned");
            return false;
        }

        if (!location.getVisibilityMult()) {
            ::logInfo("Icy Cave frist, then Hunting Grounds.");
            return false;
        }

        ::World.uncoverFogOfWar(location.getPos(), 250.0);
        ::Settings.getTempGameplaySettings().CameraLocked = false;
        ::World.State.getMenuStack().popAll(true);
        ::World.getCamera().Zoom = 1.0;
        ::World.getCamera().setPos(location.getPos());

        this.Sound.play("sounds/scribble.wav", this.Const.Sound.Volume.Inventory);
        return false;
    }

    function setLocation(_target, _name) {
        this.m.Target = _target;
        this.m.LocationName = _name;
        if (this.m.Target == "") {
            this.m.IsUsable = true;
            return;
        }
        if (this.m.Target == "x") {
            this.m.Name = "Old map";
            this.m.IsUsable = false;
            this.m.Description = "This map unfortunately is unreadable, though you may be able to find someone to pay hefty sum for it.";
        } else {
            this.m.Name = "Legendary location map";
            this.m.IsUsable = true;
            this.m.Description = "This map seems to have marked location and a lot of annotations. After studing it for a moment, you conclude that it might be [color=" + ::Const.UI.Color.PositiveEventValue + "]" + _name + "[/color]";
        }
    }

    function randomizeLocation() {
        local location = ::Legends.Maps.generateLegendary();
        this.setLocation(location.Target, location.Name);
    }

    function onSerialize( _out ) {
        _out.writeString(this.m.Target);
        _out.writeString(this.m.LocationName);
        this.item.onSerialize(_out);
    }

    function onDeserialize( _in ) {
        local target = _in.readString();
        local locationName = _in.readString();
        this.item.onDeserialize(_in);
        this.setLocation(target, locationName);
    }
});
