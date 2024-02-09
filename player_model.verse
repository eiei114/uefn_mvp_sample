using { /Verse.org/Simulation }

player_model := class():

    var Score : int = 0
    var ButtonCount : int = 0

    ScoreIncrementedEvent<public>:event(int) = event(int){}
    ButtonCountIncrementedEvent<public>:event(int) = event(int){}

    Initialize()<suspends>:void=
        spawn {Update()}
        
    Update()<suspends>:void=
        Print("Player Model Update")
        loop:
            Sleep(1.0)
            set Score += 1
            ScoreIncrementedEvent.Signal(Score)

    IncrementButtonCount()<suspends>:void=
        set ButtonCount += 1
        ButtonCountIncrementedEvent.Signal(ButtonCount)
