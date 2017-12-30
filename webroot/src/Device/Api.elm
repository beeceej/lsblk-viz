module Device.Api exposing (..)

import Data.Devices as Devices exposing (..)
import Json.Decode as Json exposing (..)
import Http exposing (..)       
import State.Message as Message exposing(Message(..))
import Debug exposing (log)

decodeBlockDevices : Json.Decoder BlockDevices
decodeBlockDevices =
    Json.map Devices.BlockDevices
        (Json.field "blockdevices" (Json.list decodeDevice))


decodeDevice : Json.Decoder Device
decodeDevice =
    Json.map8 Devices.Device
        (Json.field "name" Json.string)
        (Json.field "maj:min" Json.string)
        (Json.field "rm" Json.string)
        (Json.field "size" Json.string)
        (Json.field "ro" Json.string)
        (Json.field "type" Json.string)
        (Json.maybe <| Json.field "mountpoint" Json.string)
        (decodeChildrenLazy)



{--Lazily Decode The Children type since it is used mutually recursively --}


decodeChildrenLazy : Json.Decoder (Maybe Devices.Children)
decodeChildrenLazy =
 Json.maybe <| Json.field "children" <| Json.map Children <| Json.list <| lazy (\_ -> decodeDevice)
 
get : Cmd Message.Message
get =
    let
        url = "http://localhost:9999/lsblk"
    in
         Debug.log "sending" (Http.send Message.GotLsBlk (Debug.log "2nd" (Http.get url decodeBlockDevices)))   
