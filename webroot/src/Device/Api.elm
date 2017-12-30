module Device.Api exposing (..)

import Data.Devices as Devices exposing (Device, decodeBlockDevices)
import Http exposing (send, get)
import State.Message exposing (Msg(..))


get : Cmd Msg
get =
    let
        url =
            "http://localhost:9999/lsblk"
    in
        Http.send GotLsBlk <| Http.get url Devices.decodeBlockDevices
