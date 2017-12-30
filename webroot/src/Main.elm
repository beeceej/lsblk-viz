module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html as Html
import Html.Events exposing (onClick)
import Data.Devices as Devices exposing (empty)
import State.Message exposing (Msg(..))
import Device.Api exposing (get)
import Device.View as DeviceView exposing (render)


-- MODEL


type alias Model =
    { devices : Devices.BlockDevices
    , error : String
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotLsBlk (Ok a) ->
            ( { model | devices = a }, Cmd.none )

        GotLsBlk (Err a) ->
            ( { model | error = toString a }, Cmd.none )

        RetrieveLsblk ->
            ( model, Device.Api.get )

        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick RetrieveLsblk ] [ text "Get Info" ]
        , DeviceView.render model.devices
        , div [] [ text model.error ]
        ]


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { devices =
            { blockDevices = [ Devices.empty ]
            }
      , error = ""
      }
    , Device.Api.get
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
