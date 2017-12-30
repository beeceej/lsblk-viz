module State.Message exposing (..)

import Http exposing (Error)
import Data.Devices as Devices exposing (BlockDevices)


type Msg
    = NoOp
    | GotLsBlk (Result Http.Error Devices.BlockDevices)
    | RetrieveLsblk
