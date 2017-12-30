module Data.Devices exposing (..)


type alias BlockDevices =
    { blockDevices : List Device
    }


type alias Device =
    { name : String
    , majmin : String
    , rm : String
    , size : String
    , ro : String
    , diskType : String
    , mountPoint : Maybe String
    , children : Maybe Children
    }


type Children
    = Children (List Device)


empty : Device
empty =
    { name = ""
    , majmin = ""
    , rm = ""
    , size = ""
    , ro = ""
    , diskType = ""
    , mountPoint = Just ""
    , children = Nothing
    }
