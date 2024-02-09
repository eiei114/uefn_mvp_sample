using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }

player_view := class():
    ScoreMessage<localizes>(Score: int) : message = "Score : {Score}"
    ScoreWidget : text_block = text_block{DefaultTextColor:= color{R:=1.0, G:=1.0, B:=1.0},DefaultJustification:=text_justification.Center}

    ButtonCountMessege<localizes>(Count : int): message = "ButtonCount : {Count}"
    ButtonCountWidget : text_block = text_block{DefaultTextColor:= color{R:=1.0, G:=1.0, B:=1.0},DefaultJustification:=text_justification.Center}

    ButtonMeessage<localizes>(): message = "ButtonEvent"
    ButtonWidget : button_loud = button_loud{}

    var QPlayerUI : ?player_ui = false
    var QNewUI : ?canvas = false

    ButtonOnClickedEvent<public>:event() = event(){}

    Initialize(Player : player)<suspends>:void =
        if (PlayerUI := GetPlayerUI[Player]):
            set QPlayerUI = option{PlayerUI}
            ButtonWidget.OnClick().Subscribe(OnButtonClicked)
            Print("Widget initialized")

    CreateUI():canvas =
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}
                    Offsets := margin{Top := 100.0, Left := 0.0, Right := 0.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    SizeToContent := true
                    Widget := ScoreWidget
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}
                    Offsets := margin{Top := 150.0, Left := 0.0, Right := 0.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    SizeToContent := true
                    Widget := ButtonCountWidget
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}
                    Offsets := margin{Top := 200.0, Left := 0.0, Right := 0.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    SizeToContent := true
                    Widget := ButtonWidget
        return MyCanvas

    Show():void =
        if (PlayerUI := QPlayerUI?):
            NewUI := CreateUI()
            set QNewUI = option{NewUI}
            PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.All})
            ButtonWidget.SetText(ButtonMeessage())

    SetScoreMessage(Value : int):void=
        ScoreWidget.SetText(ScoreMessage(Value))

    SetButtonCountMessage(Value : int):void=
        ButtonCountWidget.SetText(ButtonCountMessege(Value))

    OnButtonClicked(Message : widget_message):void=
        ButtonOnClickedEvent.Signal()
        Print("Button Clicked")
