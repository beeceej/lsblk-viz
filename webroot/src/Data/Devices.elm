module Data.Devices exposing (BlockDevices, Device, Children(..), empty, decodeBlockDevices, unwrap)

import Json.Decode as Json exposing (map, map8, list, string, lazy)


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


unwrap : Children -> List Device
unwrap (Children devices) =
    devices


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


decodeBlockDevices : Json.Decoder BlockDevices
decodeBlockDevices =
    Json.map BlockDevices
        (Json.field "blockdevices" (Json.list decodeDevice))


decodeDevice : Json.Decoder Device
decodeDevice =
    Json.map8 Device
        (Json.field "name" Json.string)
        (Json.field "maj:min" Json.string)
        (Json.field "rm" Json.string)
        (Json.field "size" Json.string)
        (Json.field "ro" Json.string)
        (Json.field "type" Json.string)
        (Json.maybe <| Json.field "mountpoint" Json.string)
        (decodeChildrenLazy)



{--Lazily Decode The Children type since it is used mutually recursively --}


decodeChildrenLazy : Json.Decoder (Maybe Children)
decodeChildrenLazy =
    Json.maybe <| Json.field "children" <| Json.map Children <| Json.list <| Json.lazy (\_ -> decodeDevice)
