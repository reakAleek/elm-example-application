module Model exposing (..)
import Dict exposing (..)

type alias Model =
    { future : List Dishes
    , present : Dishes
    , past : List Dishes
    }

initModel : Model
initModel =
    { future = []
    , present = initDishes
    , past = []
    }

initDishes : Dishes
initDishes =
    { dishes = Dict.insert 0 initDish Dict.empty
    , nextId = 1
    }

initDish : Dish
initDish =
    { id = 0
    , name = "Wiener Schnitzel"
    , price = 8.50
    , addInfo = "Mit Pommes oder Kartoffelsalat"
    , veggie = False
    , hot = 0
    }

emptyDish : Int -> Dish
emptyDish id =
    { id = id
    , name = ""
    , price = 0
    , addInfo = ""
    , veggie = False
    , hot = 0
    }

type alias Dish =
    { id : Int
    , name : String
    , price : Float
    , addInfo : String
    , veggie : Bool
    , hot : Int
    }

type alias Dishes =
    { dishes : Dict Int Dish
    , nextId : Int
    }