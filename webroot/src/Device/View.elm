module Device.View exposing (render)

import Data.Devices exposing (Children(..), BlockDevices, Device, unwrap)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Css exposing (..)
import State.Message exposing (Msg)


render : BlockDevices -> Html Msg
render bd =
    div
        [ css
            [ border2 (px 1) solid ]
        ]
        (List.map renderDevice bd.blockDevices)


renderDevice : Device -> Html Msg
renderDevice d =
    div []
        [ p [] [ text <| d.name ]
        , p [] [ text <| d.majmin ]
        , p [] [ text <| d.rm ]
        , p [] [ text <| d.size ]
        , p [] [ text <| d.ro ]
        , p [] [ text <| d.diskType ]
        , p [] [ text <| d.name ]
        , case d.mountPoint of
            Nothing ->
                text ""

            Just a ->
                p [] [ text <| toString a ]
        , case d.children of
            Nothing ->
                p [] [ div [] [ text "No Children" ] ]

            Just child ->
                p [] [ div [] (List.map renderDevice <| Data.Devices.unwrap child) ]
        ]
