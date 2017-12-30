module State.Message exposing (..)

import Http exposing (Error)
import Data.Devices as Devices exposing(..)

type Message
    = NoOp
    | GotLsBlk (Result Http.Error Devices.BlockDevices)
    | RetrieveLsblk