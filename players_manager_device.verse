
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

players_manager_device := class(creative_device):

    var PlayerMap : [player]?player_presenter = map{}

    OnBegin<override>()<suspends>:void=
        spawn {CheckForPlayer()}

    CheckForPlayer()<suspends>:void=
        Print("Player Manager Device CheckForPlayer")
        loop:
            Sleep(1.0)
            AllPlayers := GetPlayspace().GetPlayers()
            for (Player : AllPlayers):
                if (not PlayerMap[Player]):
                    PlayerInstance := player_presenter{Player := Player}
                    PlayerInstance.Initialize()
                    if (set PlayerMap[Player] = option{PlayerInstance}):
                        Print("Player Manager Device Player Added")
                    else:
                        Print("Player Manager Device Player Already Added")