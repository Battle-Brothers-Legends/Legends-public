// Extend TooltipModule behaviors via FU without touching vanilla/legends sources
(function(){
    // 1) Route FU contentType queries to FU backend
    var notifyBackendQueryTooltipData = TooltipModule.prototype.notifyBackendQueryTooltipData;
    TooltipModule.prototype.notifyBackendQueryTooltipData = function (_data, _callback)
    {
        if (this.mSQHandle !== null && _data !== null && 'contentType' in _data && _data.contentType.search("FU-") == 0)
        {
            SQ.call(this.mSQHandle, 'onQueryFUTooltipData', _data, _callback);
        }
        else
        {
            notifyBackendQueryTooltipData.call(this, _data, _callback);
        }
    };

    // 2) Make tooltips persist when hovering over the tooltip itself
    //    Hide only when leaving both the source element and the tooltip.
    var fuNamespace = '.fu-persist';

    // Override register to add our own hover tracking on the tooltip container
    var register = TooltipModule.prototype.register;
    TooltipModule.prototype.register = function(_parentDiv)
    {
        register.call(this, _parentDiv);
        if (!this.mContainer) return;

        var self = this;
        // Initialize flag
        this.mHoveringTooltip = false;
        // Remove any previous FU handlers
        this.mContainer.off(fuNamespace);
        // Track entering/leaving tooltip
        this.mContainer.on('mouseenter' + fuNamespace, function(){ self.mHoveringTooltip = true; });
        this.mContainer.on('mouseleave' + fuNamespace, function(){
            self.mHoveringTooltip = false;
            // If source is not hovered anymore, hide
            if (self.mCurrentElement == null || !self.mCurrentElement.is(':hover'))
            {
                self.hideUITooltip();
            }
        });
    };

    // Clean up our handlers on unregister
    var unregister = TooltipModule.prototype.unregister;
    TooltipModule.prototype.unregister = function()
    {
        if (this.mContainer) this.mContainer.off(fuNamespace);
        unregister.call(this);
    };

    // Guard hideUITooltip so it does nothing while the tooltip or source is hovered
    var hideUITooltip = TooltipModule.prototype.hideUITooltip;
    TooltipModule.prototype.hideUITooltip = function()
    {
        try {
            if ((this.mContainer && this.mContainer.is(':hover')) || (this.mCurrentElement && this.mCurrentElement.is(':hover')) || this.mHoveringTooltip === true)
            {
                return; // keep visible
            }
        } catch (e) {}
        return hideUITooltip.call(this);
    };

    // Guard hideTooltip as well; some vanilla builds hide on tooltip mouseenter
    var hideTooltip = TooltipModule.prototype.hideTooltip;
    TooltipModule.prototype.hideTooltip = function()
    {
        try {
            if ((this.mContainer && this.mContainer.is(':hover')) || this.mHoveringTooltip === true)
            {
                return; // keep visible when hovering tooltip
            }
        } catch (e) {}
        return hideTooltip.call(this);
    };
})();
