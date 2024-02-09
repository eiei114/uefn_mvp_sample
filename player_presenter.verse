using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

player_presenter := class():

    Player : player

    var QFortCharacter : ?fort_character = false
    var QAgent : ?agent = false
    var QPlayerModel : ?player_model = false
    var QPlayerView : ?player_view = false

    Initialize()<suspends>:void=
        Print("Player Presenter Initialized")
        if :
            FortCharacter := Player.GetFortCharacter[]
            set QFortCharacter = option{FortCharacter}
            Agent := agent[Player]
            set QAgent = option{Agent}
            Model := player_model{}
            set QPlayerModel = option{Model}
            View := player_view{}
            set QPlayerView = option{View}
        then :
            Model.Initialize()
            View.Initialize(Player)
            View.Show()
            sync:
                AwaitModelHandle(Model, View)
                AwaitViewHandle(Model, View)

    AwaitModelHandle(Model : player_model,View : player_view)<suspends>:void=
        sync:  
            loop:
               Sleep(0.1)
               Score := Model.ScoreIncrementedEvent.Await()
               View.SetScoreMessage(Score)
            loop:
               Sleep(0.1)
               ButtonCount := Model.ButtonCountIncrementedEvent.Await()
               View.SetButtonCountMessage(ButtonCount)

    AwaitViewHandle(Model : player_model,View : player_view)<suspends>:void=
        loop:
            Sleep(0.1)
            View.ButtonOnClickedEvent.Await()
            Model.IncrementButtonCount()