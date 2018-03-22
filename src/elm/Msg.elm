module Msg exposing (..)
import Model exposing (..)
type Msg
    = Undo
    | Redo
    | AddDish
    | RemoveDish Int
    | UpdateDish Dish
    | UpdateDishName Int String
    | UpdateDishPrice Int String
    | UpdateDishAddInfo Int String