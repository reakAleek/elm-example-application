module Update exposing (..)
import Msg exposing (..)
import Model exposing (..)
import Dict exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Undo ->
            let newModel = 
                case model.past of
                    x::xs -> { model | present = x, past = xs, future = model.present :: model.future }
                    [] -> model
            in 
                ( newModel, Cmd.none )
        Redo ->
            let newModel =
                case model.future of
                    x::xs -> { model | present = x, future = xs, past = model.present :: model.past }
                    [] -> model
            in 
                ( newModel, Cmd.none )
        AddDish ->
                let
                    dishes = model.present |> addEmptyDishToDishes
                in
                    ( { model | present = dishes, past = model.present :: model.past, future = [] }, Cmd.none )
        RemoveDish id ->
                let
                    dishes = model.present |> removeDishFromDishes id
                in
                    ( { model | present = dishes, past = model.present :: model.past, future = [] }, Cmd.none )
        UpdateDish dish ->
                ( updateDishInModel dish model, Cmd.none )
        UpdateDishName id name ->
            let 
                dishes = model.present
                newDish = model.present.dishes |> Dict.get id
            in
                case newDish of
                    Just dish -> 
                        let
                            newDishes = updateDishInDishes { dish | name = name } dishes
                            newModel = { model | present = newDishes, past = model.present :: model.past, future = [] }
                        in
                            ( newModel, Cmd.none )
                    Nothing ->
                        (model, Cmd.none)
        UpdateDishPrice id price ->
            let 
                dishes = model.present
                newDish = model.present.dishes |> Dict.get id
            in
                case newDish of
                    Just dish ->
                        let
                            newPrice = String.toFloat price |> Result.withDefault 0
                            newDishes = updateDishInDishes { dish | price = newPrice } dishes
                            newModel = { model | present = newDishes, past = model.present :: model.past, future = [] }
                        in
                            ( newModel, Cmd.none )
                    Nothing ->
                        ( model, Cmd.none )
        UpdateDishAddInfo id addInfo ->
            let 
                dishes = model.present
                newDish = model.present.dishes |> Dict.get id
            in
                case newDish of
                    Just dish ->
                        let
                            newDishes = updateDishInDishes { dish | addInfo = addInfo } dishes
                            newModel = { model | present = newDishes, past = model.present :: model.past, future = [] }
                        in
                            ( newModel, Cmd.none )
                    Nothing ->
                        ( model, Cmd.none )
addEmptyDishToDishes : Dishes -> Dishes
addEmptyDishToDishes dishes =
    dishes |> addDishToDishes (Model.emptyDish dishes.nextId)

addDishToDishes : Dish -> Dishes -> Dishes
addDishToDishes dish dishes =
        let
            newDishes = Dict.insert dish.id  dish dishes.dishes
        in
            { dishes | dishes = newDishes, nextId = dish.id + 1 }

addEmptyDishToModel : Model -> Model
addEmptyDishToModel model =
    let
        dishes = model.present |> addEmptyDishToDishes
    in
        { model | present = dishes }

removeDishFromDishes : Int -> Dishes -> Dishes
removeDishFromDishes id dishes =
    let
        newDishes = Dict.remove id dishes.dishes
    in
        { dishes | dishes = newDishes }

removeDishFromModel : Int -> Model -> Model
removeDishFromModel id model =
    let
        dishes = model.present |> removeDishFromDishes id
    in
        { model | present = dishes }

updateDishInDishes : Dish -> Dishes -> Dishes
updateDishInDishes dish dishes =
    let
        newDishes = Dict.update dish.id (\_ -> Just dish) dishes.dishes
    in
        { dishes | dishes = newDishes }

updateDishInModel : Dish -> Model -> Model
updateDishInModel dish model =
    let
        dishes = model.present |> updateDishInDishes dish
    in
        { model | present = dishes }