module Device.View exposing (render)

import Data.Devices as Devices exposing(..)
import Html exposing (..)
import Html as Html

render : Devices.BlockDevices -> Html msg
render d =
    div [] [text <| toString d]