module Device.View exposing (render)

import Data.Devices as Devices exposing (..)
import Html exposing (..)
import Html as Html
import State.Message exposing (Msg)


render : Devices.BlockDevices -> Html Msg
render d =
    div [] [ text <| toString d ]
