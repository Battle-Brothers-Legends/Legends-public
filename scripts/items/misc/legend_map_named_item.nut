this.legend_map_named_item <- this.inherit("scripts/items/item", {
    m = {
        Target = null,
        LocationName = ""
    },
    function create() {
        this.item.create();
        this.m.ID = ::Legends.Maps.Type.Named;
        this.m.Name = "Scout report";
        this.m.Description = "This map points to a location with valuable loot.";
        this.m.Icon = "misc/map_named.png";
        this.m.SlotType = ::Const.ItemSlot.None;
        this.m.ItemType = ::Const.Items.ItemType.Usable;
        this.m.IsUsable = true;
        this.m.IsDroppedAsLoot = true;
        this.m.Value = 350;
    }

    function getBuyPrice() {
        if (this.m.IsSold) {
            return this.getSellPrice();
        }
        if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
            return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * this.getPriceMult() * ::World.State.getCurrentTown().getBuyPriceMult() * ::Const.World.Assets.BaseBuyPrice));
        }
        return this.item.getBuyPrice();
    }

    function getSellPrice() {
        if (this.m.IsBought) {
            return this.getBuyPrice();
        }
        if (("State" in ::World) && ::World.State != null && ::World.State.getCurrentTown() != null) {
            return ::Math.floor(this.getValue() * ::World.State.getCurrentTown().getSellPriceMult() * ::Const.World.Assets.BaseSellPrice);
        }
        return this.item.getSellPrice();
    }

    function setLocation() {
        if(this.m.Target != null && !this.m.Target.isNull()) {
            this.m.LocationName = this.m.Target.get().getName();
            this.m.Description = "This map points to a location with valuable loot. [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.m.LocationName + "[/color]";
        }
    }

    function onUse( _actor, _item = null ) {
        if (this.m.Target == null) {
            local maps = ::Legends.Maps.getAll().filter(@(idx, item) item.m.ID == ::Legends.Maps.Type.Named);
            local bestD = 9999;
            local bestLocation = null;
            foreach (location in ::World.EntityManager.getLocations()) {
                if (location.isAlliedWithPlayer() || location.getLoot().isEmpty()) {
                    continue;
                }
                local d = location.getTile().getDistanceTo(::World.State.getPlayer().getTile());
                if (d < bestD) {
                    local isOwned = false;
                    foreach(map in maps) {
                        if (map.m.Target == null || map.m.Target.isNull())
                            continue;
                        if (map.m.Target.getID() == location.getID()) {
                            isOwned = true;
                            break;
                        }
                    }
                    if (!isOwned) {
                        bestD = d;
                        bestLocation = location;
                    }
                }
            }
            if (bestLocation != null) {
                this.m.Target = this.WeakTableRef(bestLocation);
            }
        }

        local location = this.m.Target;
        if (this.m.Target != null && !this.m.Target.isNull()) {
            setLocation();

            ::World.uncoverFogOfWar(location.getPos(), 250.0);
            this.Settings.getTempGameplaySettings().CameraLocked = false;
            ::World.State.getMenuStack().popAll(true);
            ::World.getCamera().Zoom = 1.0;
            ::World.getCamera().setPos(location.getPos());
        }

        ::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
        return false;
    }

    function onSerialize( _out ) {
        if (this.m.Target != null && !this.m.Target.isNull()) {
            _out.writeU32(this.m.Target.getID());
        } else {
            _out.writeU32(0);
        }
        this.item.onSerialize(_out);
    }

    function onDeserialize( _in ) {
	    this.m.Target = null;
        local target = _in.readU32();
        if (target != 0) {
            this.m.Target = ::WeakTableRef(::World.getEntityByID(target));
        }
        this.item.onDeserialize(_in);
        if (this.m.Target != null && !this.m.Target.isNull()) {
            this.setLocation();
        }
    }
});
