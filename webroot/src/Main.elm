module Main exposing (..)

import Html exposing (..)
import Html as Html
import Html.Events exposing (..)
import Data.Devices as Devices exposing (..)
import State.Message as Message exposing(Message(..))
import Device.Api exposing (get)
import Device.View as DeviceView exposing(render)


-- MODEL


type alias Model =
    { devices : Devices.BlockDevices
    , error : String
    }

-- type alias Msg = State.Message.Msg


update : Message.Message -> Model -> ( Model, Cmd Message.Message )
update msg model =
    case msg of
        Message.GotLsBlk (Ok a) ->
            Debug.log "result: " (( { model | devices = a }, Cmd.none ))

        Message.GotLsBlk (Err _) ->
            ( { model | error = toString a }, Cmd.none )

        Message.RetrieveLsblk ->
            ( model, Device.Api.get )
        
        Message.NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Message.Message
view model =
    div []
        [ button [ onClick RetrieveLsblk ] [ text "Get Info" ]
        , DeviceView.render model.devices
        , div [] [text model.error]
        ]


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Message.Message )
init =
    ( { devices =
            { blockDevices = [ Devices.empty ]
            }
      , error = ""
      }
    , Device.Api.get
    )


subscriptions : Model -> Sub Message.Message
subscriptions model =
    Sub.none
