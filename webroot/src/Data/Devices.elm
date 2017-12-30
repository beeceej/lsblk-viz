module Data.Devices exposing (..)

import Json.Decode as Json exposing (..)


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

{--Lazily Decode The Children type since it is used in a mutually recursive way--}
decodeChildrenLazy : Json.Decoder (Maybe Children)
decodeChildrenLazy =
    Json.maybe <| Json.field "children" <| Json.map Children <| Json.list <| lazy (\_ -> decodeDevice)

emptyDevice : Device
emptyDevice =
    { name = ""
    , majmin = ""
    , rm = ""
    , size = ""
    , ro = ""
    , diskType = ""
    , mountPoint = Just ""
    , children = Nothing
    }


json =
    """
{
    "blockdevices": [
       {"name": "sda", "maj:min": "8:0", "rm": "0", "size": "238.5G", "ro": "0", "type": "disk", "mountpoint": null,
          "children": [
             {"name": "sda1", "maj:min": "8:1", "rm": "0", "size": "200M", "ro": "0", "type": "part", "mountpoint": "/boot/efi"},
             {"name": "sda2", "maj:min": "8:2", "rm": "0", "size": "1G", "ro": "0", "type": "part", "mountpoint": "/boot"},
             {"name": "sda3", "maj:min": "8:3", "rm": "0", "size": "237.3G", "ro": "0", "type": "part", "mountpoint": null,
                "children": [
                   {"name": "fedora-root", "maj:min": "253:0", "rm": "0", "size": "50G", "ro": "0", "type": "lvm", "mountpoint": "/"},
                   {"name": "fedora-swap", "maj:min": "253:1", "rm": "0", "size": "7.8G", "ro": "0", "type": "lvm", "mountpoint": "[SWAP]"},
                   {"name": "fedora-home", "maj:min": "253:2", "rm": "0", "size": "179.5G", "ro": "0", "type": "lvm", "mountpoint": "/home"}
                ]
             }
          ]
       }
    ]
 }
"""
