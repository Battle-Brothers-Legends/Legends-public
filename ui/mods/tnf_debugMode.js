"use strict";

CharacterScreenDatasource.prototype.tnf_giveActiveCharacter = function(_keyword)
{
  this.tnf_notifyBackendGiveActiveCharacter(_keyword);
};

CharacterScreenDatasource.prototype.tnf_notifyBackendGiveActiveCharacter = function (_keyword)
{
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
  SQ.call(this.mSQHandle, 'tnf_onGiveActiveCharacter', [ activeCharacterID, _keyword ]);
};