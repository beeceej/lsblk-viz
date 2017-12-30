module State.Model exposing (Model)

import Data.Devices as Devices exposing (BlockDevices)


type alias Model =
    { devices : Devices.BlockDevices
    , error : String
    }
