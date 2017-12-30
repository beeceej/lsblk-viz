module Device.View exposing (render)

import Data.Devices as Devices exposing (..)
import Html exposing (..)
import Html as Html
import State.Message as Message exposing(Message(..))



render : Devices.BlockDevices -> Html Message.Message
render d =
    div [] [ text <| toString d ]
