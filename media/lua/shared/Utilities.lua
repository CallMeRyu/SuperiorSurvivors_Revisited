
function isModEnabled(modname)

	local actmods = getActivatedMods();
	for i=0, actmods:size()-1, 1 do
		if actmods:get(i) == modname then
			return true;
		end
	end
	return false;
end


function getSaveDir()
	return Core.getMyDocumentFolder()..getFileSeparator().."Saves"..getFileSeparator().. getWorld():getGameMode() .. getFileSeparator() .. getWorld():getWorld().. getFileSeparator();
end

function getSourceSquareOfItem(item,character)

	if (item.getWorldItem ~= nil) and (item:getWorldItem() ~= nil) then
		return item:getWorldItem():getSquare()		
	elseif(item:getContainer() ~= nil) then
		return item:getContainer():getSourceGrid()
	end
	
	return character:getCurrentSquare()
	
end