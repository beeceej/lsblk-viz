module Main exposing (..)

import Html exposing (..)
import Html as Html
import Html.Events exposing (..)
import Data.Devices as Devices exposing (..)
import Device.View exposing (..)
import Json.Decode as Json exposing(..)
import Http exposing (..)


-- MODEL


type alias Model =
    { devices : Devices.BlockDevices,
      error : String
    }



-- UPDATE


type Msg
    = NoOp
    | GotLsBlk (Result Http.Error Devices.BlockDevices)
    | RetrieveLsblk


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of

        GotLsBlk (Ok d)->
            ( {model | devices = d }, Cmd.none)


        GotLsBlk (Err a)->
            ( {model | error = toString a }, Cmd.none)

        NoOp ->
            (model, Cmd.none)

        RetrieveLsblk ->
          (model, getLsblk)




getLsblk =
  let
    p  = "8080"
    domain = "localhost"
    action = "lsblk"
    url =
      domain ++ ":" ++ p ++ "/" ++ action
  in
    Http.send GotLsBlk (Http.get "http://localhost:9999/lsblk" Devices.decodeBlockDevices)



-- VIEW


view : Model -> Html Msg
view model =
    div []
    [ button [onClick RetrieveLsblk] [text "Get Info"]
    , text <| toString model

    ]


-- APP


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd Msg)
init = 
  (
    {
    devices = {
      blockDevices = [emptyDevice]
    },
    error = ""
  }, getLsblk)

decodeTest =
    case Json.decodeString decodeBlockDevices json of
        Ok a ->
            toString a
            
        Err a ->
            "There be Errs..."

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


            

