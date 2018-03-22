module View exposing (..)
import Msg exposing (Msg)
import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onFocus, onBlur)
import Dict exposing (..)


view : Model -> Html Msg
view model =
    div [] [
        headerView,
        div [ class "section" ] [
            div [ class "container is-fluid" ] [
                div [ class "columns" ] [
                    div [ class "column is-4", style [("background", "whitesmoke")] ] [ 
                        undoRedoDishesButtonsView model,
                        dishListView model.present.dishes,
                        addDishButtonView
                    ],
                    div [ class "column is-8", style [("background", "lightslategrey")] ] [ 
                        text "Preview"
                    ]
                ]
            ]
        ]
    ]

headerView : Html Msg
headerView  = 
    div [ style [("padding", "1rem 0 0 0")] ] [
        nav [ class "level" ] [ 
            p [ class "level-item has-text-centered" ] [
                a [ class "button is-small", target "_blank",  href "https://github.com/reakAleek/react-redux-example-application"] [
                    span [ class "icon" ] [
                        i [ class "fa fa-github" ] []
                    ],
                    span [] [ text "Github" ]
                ]
             ]
         ] 
    ]


undoRedoDishesButtonsView : Model -> Html Msg
undoRedoDishesButtonsView model =
    div [ class "buttons" ] [
        button [ class "button", onClick Msg.Undo, disabled (List.isEmpty model.past) ] [
            span [ class "icon"] [
                i [ class "fa fa-undo"] []
            ],
            span [] [ text "Undo" ]
        ],
        button [ class "button", onClick Msg.Redo, disabled (List.isEmpty model.future) ] [
            span [ class "icon"] [
                i [ class "fa fa-repeat"] []
            ],
            span [] [ text "Redo"]
        ]
    ] 

dishListView : Dict Int Dish -> Html Msg
dishListView dishes =
    dishes
    |> Dict.values
    |> List.map (\dish -> li [] [ dishView dish ])
    |> ul []

dishView : Dish -> Html Msg
dishView dish =
    div [ class "box", style [("margin-bottom", "1rem")]] [
        div [ class "field is-grouped" ] [
            p [ class "control is-expanded"] [
                dishNameInputView dish.name dish.id
            ],
            p [ class "control"] [
                button [ class "button is-danger", onClick (Msg.RemoveDish dish.id) ] [
                    span [ class "icon"] [
                        i [ class "fa fa-trash-o" ] []
                    ]
                ]
            ]
        ],
        dishPriceInputView dish.price dish.id,
        dishAddInforTextareaView dish.addInfo dish.id
    ]

dishNameInputView : String -> Int -> Html Msg
dishNameInputView name id =
    input [ class "input", value name,  onInput (Msg.UpdateDishName id)] []

dishPriceInputView : Float -> Int -> Html Msg
dishPriceInputView price id =
    div [ class "field has-addons" ] [
        p [ class "control is-expanded" ] [
            input [ 
                class "input",
                type_ "number",
                step "0.01",
                value (toString price),
                Html.Attributes.min "0",
                placeholder "Price",
                onInput (Msg.UpdateDishPrice id)
            ] []
        ],
        p [ class "control"] [
            a [ class "button is-static" ] [
                span [ class "icon" ] [
                    i [ class "fa fa-eur" ] []
                ]
            ]
        ]
    ]

dishAddInforTextareaView : String -> Int -> Html Msg
dishAddInforTextareaView addInfo id =
    div [ class "field" ] [
        div [ class "control" ] [
            textarea [ 
                style [("resize", "none"), ("height", "3rem"), ("transition", "height 125ms ease-in-out")],
                rows 1,
                class "textarea",
                placeholder "Additional infos...",
                value addInfo,
                onInput (Msg.UpdateDishAddInfo id)
            ] []
        ]
    ]

addDishButtonView : Html Msg
addDishButtonView =
    button [ class "button is-success", style [("width", "100%")], onClick Msg.AddDish ] [
        text "Add Dish"
    ]


{-
view : Model -> Html Msg
view model =
    div [] [
        model.present.dishes
        |> Dict.values
        |> List.map renderDish
        |> ul []
        ,
        renderPreview model,
        button [ onClick Msg.AddDish ] [ text "Add dish" ]
        , button [ onClick Msg.Undo ] [ text "Undo" ]
        , button [ onClick Msg.Redo ] [ text "Redo" ]
    ]

renderPreview : Model -> Html Msg
renderPreview model =
    div [] [
        model.present.dishes
        |> Dict.values
        |> List.map renderDish2
        |> ul []
    ]

renderDish : Dish -> Html Msg
renderDish dish =
    li [] [
        div [] [ input [ value dish.name, onInput (Msg.UpdateDishName dish.id)  ] [] , button [ onClick (Msg.RemoveDish dish.id) ] [ text "remove" ] ]
    ]


renderDish2 : Dish -> Html Msg
renderDish2 dish =
    li [] [
        div [] [ text dish.name ]
    ]
-}