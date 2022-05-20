let ESX = null
emit('esx:getSharedObject', (obj) => (ESX = obj));
ESX.RegisterServerCallback("xCoore:GetPlayerData", (source, cb) => {
    let xplayer = ESX.GetPlayerFromId(source)
    if (xplayer) {
        cb(xplayer)
    }
})