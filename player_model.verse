using { /Verse.org/Simulation }

player_model := class():

    #スコア
    var Score : int = 0
    #ボタンカウント
    var ButtonCount : int = 0

　　#スコアが増えたときのイベント
    ScoreIncrementedEvent<public>:event(int) = event(int){}
    #ボタンカウントが増えたときのイベント
    ButtonCountIncrementedEvent<public>:event(int) = event(int){}

    #初期化
    Initialize()<suspends>:void=
        spawn {Update()}
        
    #更新
    Update()<suspends>:void=
        Print("Player Model Update")
        loop:
            Sleep(1.0)
            set Score += 1
            ScoreIncrementedEvent.Signal(Score)

    #ボタンカウントを１増やす
    IncrementButtonCount()<suspends>:void=
        set ButtonCount += 1
        ButtonCountIncrementedEvent.Signal(ButtonCount)
